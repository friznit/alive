/*!
 * \brief   ALiVE Class - cmdSendJSONAsync
 * \details This file will contain functions for CMD_SendJSON
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

struct MyStruct {
    std::string functionname;

    std::string method;
    std::string module;
    std::string jsondata;

    std::string url;
    std::string userpwd;
};

void Alive::cmdSendJSONAsync(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Check parameter count
    if((data->vParams.size() != 3) && (data->vParams.size() != 0)) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Parameter error");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage SendJSONAsync", "Parameter error", data->sRawMsg);

        return;
    }

    // Polling for data
    if(data->vParams.size() == 0) {
        pthread_mutex_lock(&JSONMap_Mutex);

        // Did we reach the end ?
        auto it = JSONMap.find("JSONAsync");
        if((it == JSONMap.end()) || (it->second.size() == 0) ) {
            // Lets make sure there are noe threads running
            pthread_mutex_lock(&JSONAsync_Threads_Mutex);
            if(JSONAsync_Threads > 0) {
                vReturnParams.push_back("WAITING");
                LOG_FDBG() << "    Waiting for JSON data";
            } else {
                vReturnParams.push_back("END");
                LOG_FDBG() << "    End of JSON reached";
            }
            pthread_mutex_unlock(&JSONAsync_Threads_Mutex);

            data->sReturn = CreateCSV(vReturnParams);

            pthread_mutex_unlock(&JSONMap_Mutex);
            return;
        }

        // Return result
        vReturnParams.push_back(it->second.at(0));
        data->sReturn = CreateCSV(vReturnParams);

        // Erase the data we returned
        it->second.erase(it->second.begin());

        pthread_mutex_unlock(&JSONMap_Mutex);
        return;
    }

    // Add struct data
    MyStruct *myStruct = new MyStruct();
    myStruct->functionname  = data->sFunctionName;

    myStruct->method        = data->vParams.at(0);
    myStruct->module        = data->vParams.at(1);
    myStruct->jsondata      = data->vParams.at(2);

    myStruct->url           = Config.url + "/" + data->vParams.at(1);
    myStruct->userpwd       = Config.user + ":" + Config.pass;

    // Try to create the thread
    pthread_t thread;
    int res = pthread_create(&thread, NULL, cmdSendJSONThread, myStruct);

    // Make sure the thread was created
    if(res) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Unable to create thread.");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendJSONAsync",
                 "Unable to create thread.", data->sRawMsg);

        return;
    }

    // Increment thread counter
    pthread_mutex_lock(&JSONAsync_Threads_Mutex);
    ++JSONAsync_Threads;
    pthread_mutex_unlock(&JSONAsync_Threads_Mutex);

    // All OK
    vReturnParams.push_back(data->sFunctionName);
    vReturnParams.push_back("OK");
    data->sReturn = CreateCSV(vReturnParams);
}

// Our thread function
void *Alive::cmdSendJSONThread(void *_data) {
    std::vector<std::string> vReturnParams;
    MyStruct *myStruct = static_cast<MyStruct *>(_data);

    // Send data
    CurlData cData;
    if(!Alive::curlGet(myStruct->url, &cData,
                      myStruct->userpwd, myStruct->jsondata,
                      myStruct->method)) {
    }

    // Push data into our JSONMap
    pthread_mutex_lock(&JSONMap_Mutex);
    JSONMap["JSONAsync"].push_back(cData.content);
    LOG_FDBG() << "### Pushing: " << cData.content;
    pthread_mutex_unlock(&JSONMap_Mutex);

    // Reduce thread counter
    pthread_mutex_lock(&JSONAsync_Threads_Mutex);
    --JSONAsync_Threads;
    pthread_mutex_unlock(&JSONAsync_Threads_Mutex);

    delete myStruct;

    pthread_exit(0);
}
