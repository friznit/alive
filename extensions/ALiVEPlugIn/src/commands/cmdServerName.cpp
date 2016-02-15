/*!
 * \brief   ALiVE Class - cmdServerName
 * \details This file will contain functions for CMD_ServerName
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdServerName(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    std::string cFile;
    std::string cFileName;

    char split = '\0';

    // Get command arguments (Linux Specific)
#ifdef __gnu_linux__
    std::ifstream cmdLine("/proc/self/cmdline");

    if(!cmdLine.is_open()) {
        vReturnParams.push_back("ServerName");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Unable to get command line arguments");
        data->sReturn = CreateCSV(vReturnParams);

        LogError(data->sFunctionName,
                 "Unable to get command line arguments", data->sRawMsg);

        return;
    }

    split = '\0';
#else
    // Get command arguments (Windows Specific)
    std::istringstream cmdLine(GetCommandLine());

    split = '-';
#endif

    std::string line;

    // Find the -config parameter
    while(std::getline(cmdLine, line, split)) {
        if(line.find("config") != std::string::npos) {
            // Get the -config value
            size_t pos = line.find("=");
            cFileName = line.substr(pos + 1);

            break;
        }
    }

#ifdef __gnu_linux
    cmdLine.close();
#endif

    if(cFileName.empty()) {
        vReturnParams.push_back("ServerName");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Server was not started with -config parameter");
        data->sReturn = CreateCSV(vReturnParams);

        LogError(data->sFunctionName,
                 "Server was not started with -config parameter", data->sRawMsg);

        return;
    }

    // Get working directory
    char cCurrentPath[FILENAME_MAX];
    if(!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath))) {
       vReturnParams.push_back("ServerName");
       vReturnParams.push_back("ERROR");
       vReturnParams.push_back("Unable to get current directory");
       data->sReturn = CreateCSV(vReturnParams);

       LogError(data->sFunctionName,
                "Unable to get current directory", data->sRawMsg);

       return;
    }

    // Put the working directory with the config filename
    cFile = cCurrentPath;
#ifdef __gnu_linux__
    cFile += "/";
#else
    cFile += "\\";
#endif
    cFile += cFileName;

    LOG_FINFO() << "    Config file: " << cFile;

    // Open the config file
    std::ifstream file(cFile);

    // Make sure we really did open the config file
    if(!file.is_open()) {
        vReturnParams.push_back("ServerName");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Unable to open config file");
        data->sReturn = CreateCSV(vReturnParams);

        LogError(data->sFunctionName,
                 "Unable to open config file", data->sRawMsg);

        return;
    }

    std::string servername;

    // Iterate through every line
    while(std::getline(file, line)) {
        // Find line that starts with "hostname"
        if(line.find("hostname") == 0) {
            size_t first = line.find_first_of('"');
            size_t last = line.find_last_of('"');

            if((first == std::string::npos) || (last == std::string::npos)) {
                vReturnParams.push_back("ServerName");
                vReturnParams.push_back("ERROR");
                vReturnParams.push_back("Unable to find hostname in config");
                data->sReturn = CreateCSV(vReturnParams);

                LogError(data->sFunctionName,
                         "Unable to find hostname in config", data->sRawMsg);

                return;
            }

            // Get string between the quotes
            servername = line.substr(first + 1, last - first - 1);

            break;
        }
    }

    // Close the file
    file.close();

    LOG_FINFO() << "    ServerName: " << servername;

    // Return the servername
    vReturnParams.push_back(servername);
    data->sReturn = CreateCSV(vReturnParams);
}
