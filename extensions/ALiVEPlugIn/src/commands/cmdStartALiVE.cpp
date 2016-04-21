/*!
 * \brief   ALiVE Class - cmdStartAlive
 * \details This file will contain functions for CMD_StartALiVE
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdStartALiVE(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Already initialized ?
    if(Config.initialized) {
        LogWarning(data->sFunctionName, "Already initialized", data->sRawMsg);

        vReturnParams.push_back("StartALiVE");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("ALiVE already initialized");

        data->sReturn = CreateCSV(vReturnParams);

        return;
    }

    // Check parameter count
    if(data->vParams.size() == 1) {
        // Parameter options are "false" and "true".
        if(data->vParams.at(0) == "true") {
            disablePerfMon = true;

            LOG_FINFO() << "    Disable Performance Monitor: true";
        } else {
            disablePerfMon = false;

            LOG_FINFO() << "    Disable Performance Monitor: false";
        }

        LOG_FINFO() << "    Reading 'alive.cfg'";

        // Try to get setting from the config file
        std::vector<std::string> params;
        if(ReadConfig(&params)) {
            // Put configuration from the file into our struct
            Config.type = params.at(0);
            Config.user = params.at(1);
            Config.pass = params.at(2);
            Config.group = params.at(3);

            // Did we get the 5th element ? If not, use a default value
            if(params.size() == 5) {
                Config.url = params.at(4);
            } else {
                Config.url = "http://db.alivemod.com:5984";
                LOG_FINFO() << "    No URL in config. Using default.";
            }

            LOG_FINFO() << "    Configuration 'alive.cfg' read OK.";

            // Useful DEBUG information for later.
            // But don't give away our password, sshhh...
            LOG_FDBG() << "    Alive Config:";
            LOG_FDBG() << "        Type:  " << Config.type;
            LOG_FDBG() << "        User:  " << Config.user;
            LOG_FDBG() << "        Pass:  xxxxxxxxxxxxxxxx";
            LOG_FDBG() << "        Group: " << Config.group;
            LOG_FDBG() << "        URL:   " << Config.url;

            CurlData cData;

            // The URL to check against
            CURL *curl = curl_easy_init();
            std::string urlAuth = "http://alivemod.com/api/authorise?&group=";
            urlAuth += curl_easy_escape(curl, Config.group.c_str(), Config.group.size());
            curl_easy_cleanup(curl);

            LOG_FINFO() << "    Checking WarRoom access...";
            LOG_FINFO() << "    URL: " << urlAuth;

            // Check for CURL errors
            if(!curlGet(urlAuth, &cData)) {
                vReturnParams.push_back("StartALiVE");
                vReturnParams.push_back("ERROR");
                vReturnParams.push_back(cData.error);
                data->sReturn = CreateCSV(vReturnParams);

                LogError("HandleMessage - StartALiVE", "curlGet() failed", cData.error);

                return;
            }

            // Did the website return anything but true ?
            // Then log and respond with the error
            if(cData.content != "\"true\"") {
                vReturnParams.push_back("StartALiVE");
                vReturnParams.push_back("ERROR");
                vReturnParams.push_back("You are not authorized to access ALiVE War Room with this account. Check IP and Groupname.");
                data->sReturn = CreateCSV(vReturnParams);

                LogError("HandleMessage - StartALiVE", "You are not authorized to access ALiVE War Room with this account. Check IP and Groupname.", data->sRawMsg);
                
                return;
            }

            LOG_FINFO() << "        WarRoom access granted.";

            // Set "username:password"
            std::string userpwd = Config.user;
            userpwd += ":";
            userpwd += Config.pass;

            LOG_FINFO() << "    Checking DB access...";

            // Check for errors while connecting to DB
            if(!curlGet(Config.url, &cData, userpwd)) {
                vReturnParams.push_back("StartALiVE");
                vReturnParams.push_back("ERROR");
                vReturnParams.push_back(cData.error);
                data->sReturn = CreateCSV(vReturnParams);

                LogError("HandleMessage - StartALiVE",
                         "curlGet() failed", cData.error);

                return;
            }

            // Parse JSON and look for ["couchdb":"Welcome"]
            rapidjson::Document d;
            d.Parse(cData.content.c_str());

            // Make sure it's an object
            if(!d.IsObject()) {
                vReturnParams.push_back("StartALiVE");
                vReturnParams.push_back("ERROR");
                vReturnParams.push_back("JSON not a valid object");
                data->sReturn = CreateCSV(vReturnParams);

                LogError("HandleMessage - StartALiVE",
                         "JSON not a valid object", cData.error);
            }

            if(d.HasMember("couchdb")) {
                if(d["couchdb"].IsString()) {
                    std::string buffer = d["couchdb"].GetString();
                    if(buffer == "Welcome") {
                        Config.initialized = true;

                        vReturnParams.push_back("StartALiVE");
                        vReturnParams.push_back("OK");

                        if(disablePerfMon) {
                            vReturnParams.push_back("Performance Monitor: Disabled");
                        } else {
                            vReturnParams.push_back("Performance Monitor: Enabled");
                        }

                        data->sReturn = CreateCSV(vReturnParams);

                        LOG_FINFO() << "        DB access granted.";
                        LOG_FINFO() << "    ALiVE successfully initialized.";

                        return;
                    }
                }
            }

            // Failed connecting to DB if we get here
            vReturnParams.push_back("StartALiVE");
            vReturnParams.push_back("ERROR");
            vReturnParams.push_back("Unable to connect to DB");
            data->sReturn = CreateCSV(vReturnParams);

            LogError("HandleMessage - StartALiVE",
                     "Unable to connect to DB", data->sRawMsg);
        } else {
            // Log and respond with the error
            vReturnParams.push_back("StartALiVE");
            vReturnParams.push_back("ERROR");
            vReturnParams.push_back("Unable to open alive.cfg");
            data->sReturn = CreateCSV(vReturnParams);

            LogError("HandleMessage - StartALiVE",
                     "Unable to open alive.cfg", data->sRawMsg);
        }
    } else {
        // Log and respond with the error
        vReturnParams.push_back("StartALiVE");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Parameter error");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - StartALiVE",
        "Parameter error",
        data->sRawMsg);
    }
}

bool Alive::ReadConfig(std::vector<std::string> *params) {
        std::string configfile;

    // Open configuration file
    std::ifstream file("alive.cfg");

    // Get user home directory
    // Linux and Windows has different approaches
#ifdef __gnu_linux__
    struct passwd *pw = getpwuid(getuid());
    configfile = pw->pw_dir;
    configfile += "/.alive/alive.cfg";
#else
    char buffer[MAX_PATH];
    BOOL result = SHGetSpecialFolderPath(NULL, buffer, CSIDL_LOCAL_APPDATA, false);
    configfile = buffer;
    configfile += "\\ALiVE\\alive.cfg";

    std::string altConfigFile = buffer;
    altConfigFile += "\\Arma3\\alive.cfg";
#endif // __gnu_linux__

    // Check if we were able to open file
    if(!file.is_open()) {
        // Most likely no file found, lets try user home directories
        file.open(configfile);
    }

#ifndef __gnu_linux__
    // Check if we were able to open file
    if(!file.is_open()) {
        // Most likely no file found, lets try the other directory
        file.open(altConfigFile);
    }
#endif

    // Check again with the new path
    if(file.is_open()) {
        std::string line;
        std::regex e("([^,]+)");

        LOG_FINFO() << "    Configuration found: " << configfile;

        while(std::getline(file, line)) {
            // Clear params
            params->clear();

            // Split and put the parameters inside the vector
            std::regex_iterator<std::string::iterator> match(
            line.begin(), line.end(), e);
            std::regex_iterator<std::string::iterator> rend;
            if(match != rend) params->push_back((*match++).str());
            if(match != rend) params->push_back((*match++).str());
            if(match != rend) params->push_back((*match++).str());
            if(match != rend) params->push_back((*match++).str());

            // Return when we've got the correct amount of parameters
            if(params->size() >= 4) return true;
        }

        file.close();
    }

    return false;
}
