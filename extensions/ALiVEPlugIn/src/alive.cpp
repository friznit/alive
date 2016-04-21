/*!
 * \brief   ALiVE Class
 * \details This class will handle ALiVE specific actions
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

std::map<std::string, std::vector<std::string>> Alive::JSONMap;
pthread_mutex_t Alive::JSONMap_Mutex;

uint32_t Alive::JSONAsync_Threads = 0;
pthread_mutex_t Alive::JSONAsync_Threads_Mutex;

Alive::Alive() {
    // Initialize the command map
    CommandMap["DateTime"]          = CMD_DateTime;
    CommandMap["GetBulkJSON"]       = CMD_GetBulkJSON;
    CommandMap["GroupName"]         = CMD_GroupName;
    CommandMap["SendBulkJSON"]      = CMD_SendBulkJSON;
    CommandMap["SendJSON"]          = CMD_SendJSON;
    CommandMap["SendJSONAsync"]     = CMD_SendJSONAsync;
    CommandMap["SendJSONToFile"]    = CMD_SendJSONToFile;
    CommandMap["ServerAddress"]     = CMD_ServerAddress;
    CommandMap["ServerName"]        = CMD_ServerName;
    CommandMap["StartALiVE"]        = CMD_StartALiVE;

    // TODO Set loglevel from config file
    spdlog::set_level(spdlog::level::debug);
    debug = true;
    spdlog::set_pattern("[%Y-%m-%d %T] [%l] %v");

    // Initialize mutexes
    pthread_mutex_init(&JSONMap_Mutex, NULL);
    pthread_mutex_init(&JSONAsync_Threads_Mutex, NULL);

    perfMon = new PerfMon();
}

Alive::~Alive() {
    // Destroy mutexes
    pthread_mutex_destroy(&JSONMap_Mutex);
    pthread_mutex_destroy(&JSONAsync_Threads_Mutex);

    delete perfMon;
}

void Alive::HandleMessage(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    if(!Config.initialized && data->eCmd != CMD_StartALiVE) {
        LOG_FWARN() << "ALiVE not initialized yet!";
    }

    switch(data->eCmd) {
        case CMD_DateTime:
            cmdDateTime(data);
            break;

        case CMD_GetBulkJSON:
            cmdGetBulkJSON(data);
            break;

        case CMD_GroupName:
            vReturnParams.push_back(Config.group);
            data->sReturn = CreateCSV(vReturnParams);

            LOG_FINFO() << "    GroupName: " << Config.group;
            break;

        case CMD_SendBulkJSON:
            cmdSendBulkJSON(data);
            break;

        case CMD_SendJSON:
            cmdSendJSON(data);
            break;

        case CMD_SendJSONAsync:
            cmdSendJSONAsync(data);
            break;

        case CMD_SendJSONToFile:
            break;

        case CMD_ServerAddress:
            cmdServerAddress(data);
            break;

        case CMD_ServerName:
            cmdServerName(data);
            break;

        case CMD_StartALiVE:
            cmdStartALiVE(data);
            break;

        case CMD_UNKNOWN:
            // Log and respond with the error
            vReturnParams.push_back(data->sFunctionName);
            vReturnParams.push_back("ERROR");
            vReturnParams.push_back("Unknown command");
            data->sReturn = CreateCSV(vReturnParams);

            LogError("HandleMessage - Unknown Command",
                       "Unknown command",
                       data->sRawMsg);
            break;
    }

    LOG_FDBG() << "    Return value [" << data->sReturn << "]";
}

void Alive::ParseMessage(const std::string &msg, Alive::AliveData *data) {
    std::string sParameters;

    // Clear data in case someone tried to set some values
    data->eCmd = CMD_UNKNOWN;
    data->sFunctionName.clear();
    data->sRawMsg.clear();
    data->vParams.clear();

    data->sRawMsg = msg;

    LOG_FDBG() << ">>> ParseMessage [" << data->sRawMsg << "]";

    // Separate the FunctionName from the Parameters
    std::regex e("(\\[.*\\]|[^\\s]+)");
    std::smatch sm;
    std::regex_search(data->sRawMsg, sm, e);

    if(sm.size() == 2) {
        data->sFunctionName = sm[1];
        sParameters = sm.suffix();
    }

    // Lets see if the function exists
    auto it = CommandMap.find(data->sFunctionName);
    if(it == CommandMap.end()) { return; }
    data->eCmd = it->second;
 
    // Find all parameters and put into a vector
    ParseCSV(sParameters, &data->vParams);

    if(debug) {
        LOG_FDBG() << "    Function: " << data->sFunctionName;
        LOG_FDBG() << "    Params:";
        for(uint32_t i = 0; i < data->vParams.size(); i++) {
            LOG_FDBG() << "            - [" << data->vParams.at(i) << "]";
        }
    }
}

bool Alive::curlGet(const std::string& url,
                    CurlData *data,
                    const std::string& userpwd,
                    const std::string& postfields,
                    const std::string& method) {
    std::vector<std::string> vReturnParams;

    // Clear data
    data->content.clear();
    data->error.clear();

    // In windows, this will init the winsock stuff
    curl_global_init(CURL_GLOBAL_ALL);

    CURL *curl = curl_easy_init();

    // If CURL failed to initialize, log and respons with the error
    if(!curl) {
        vReturnParams.push_back("curlGet");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Unable to initialize CURL");
        data->error = CreateCSV(vReturnParams);

        LOG_FERR() << "###### curlGet ######";
        LOG_FERR() << "    Error: Unable to initialize CURL";
        LOG_FERR() << "    RAW:   N/A";

        return false;
    }

    // Our temporary buffer
    std::string buffer;

    // Setup CURL and call the website
    CURLcode res;
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &buffer);

    // HTTP auth used ?
    if(userpwd != "") {
        curl_easy_setopt(curl, CURLOPT_HTTPAUTH, (long)CURLAUTH_BASIC);
        curl_easy_setopt(curl, CURLOPT_USERPWD, userpwd.c_str());
    }

    struct curl_slist *headers = NULL;

    // POST fields ?
    if(postfields != "") {
        headers = curl_slist_append(headers, "Content-Type: application/json");

        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postfields.c_str());
        curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);

        // Use custom method ?
        if(!method.empty()) {
            if((method == "DELETE") || (method == "GET") || (method == "POST") || (method == "PUT")) {
                curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, method.c_str());
            } else {
                LOG_FWARN() << "###### curlGet  ######";
                LOG_FWARN() << "    Warning: Unknown method: " << method;
                LOG_FWARN() << "    RAW:     N/A";
            }
        }
    }

    res = curl_easy_perform(curl);

    curl_slist_free_all(headers);

    // Check for errors
    if(res != CURLE_OK) {
        vReturnParams.push_back("curlGet");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("curl_easy_perform() failed");
        data->error = CreateCSV(vReturnParams);

        LOG_FERR() << "###### curlGet ######";
        LOG_FERR() << "    Error: curl_easy_perform() failed";
        LOG_FERR() << "    RAW:   " << curl_easy_strerror(res);

        // Always cleanup
        curl_easy_cleanup(curl);

        return false;
    }

    // Always cleanup
    curl_easy_cleanup(curl);

    data->content = buffer;

    return true;
}

std::string Alive::CreateCSV(const std::vector<std::string> vParams) {
    std::string buffer = "[";

    for(uint32_t i = 0; i < vParams.size(); i++) {
        if(i != 0) buffer += ",";
        buffer += "'";
        buffer += vParams.at(i);
        buffer += "'";
    }

    buffer += "]";

    return buffer;
}

void Alive::LogError(const std::string &function, const std::string &error, const std::string &raw) {
    LOG_FERR() << "###### " << function << " ######";
    LOG_FERR() << "    Error: " << error;
    LOG_FERR() << "    RAW:   " << raw;
}

void Alive::LogWarning(const std::string &function, const std::string &warning, const std::string &raw) {
    LOG_FWARN() << "###### " << function << " ######";
    LOG_FWARN() << "    Warning: " << warning;
    LOG_FWARN() << "    RAW:     " << raw;
}

void Alive::ParseCSV(const std::string &params, std::vector<std::string> *vParams) {
    // Make sure the parameters are within '[' and ']'
    std::size_t pFirst = params.find_first_of('[') + 1;
    std::size_t pLast  = params.find_last_of(']');
    if((pFirst == std::string::npos) || (pLast == std::string::npos)) {
        return;
    }
    std::string p = params.substr(pFirst, pLast - pFirst);

    // Find all parmeters
    uint32_t quotes = 0;
    uint32_t bracket = 0;
    char prev = 0;
    std::string result;

    // Do some CSV Parsing
    for(char &c : p) {
        switch(c) {
            case '"':
                ++quotes;
                break;

            case '{':
                ++bracket;
                break;

            case '}':
                --bracket;
                break;

            case ',':
                if((quotes == 0 && bracket == 0) || (((prev == '"' || prev == '\'') && (quotes & 1) == 0) && (bracket == 0))) {
                    pFirst = result.find_first_of('\'') + 1;
                    pLast = result.find_last_of('\'');
                    result = result.substr(pFirst, pLast - pFirst);

                    vParams->push_back(result);

                    result.clear();
                }
                break;

            default:;
        }

        result += prev = c;
    }

    if(bracket == 0 && result.size() != 0) {
        pFirst = result.find_first_of('\'') + 1;
        pLast = result.find_last_of('\'');
        result = result.substr(pFirst, pLast - pFirst);

        vParams->push_back(result);
    }
}
