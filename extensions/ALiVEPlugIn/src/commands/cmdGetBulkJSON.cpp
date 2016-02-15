/*!
 * \brief   ALiVE Class - cmdGetBulkJSON
 * \details This file will contain functions for CMD_GetBulkJSON
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdGetBulkJSON(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Check parameter count
    if(data->vParams.size() != 1) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Parameter error");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - GetBulkJSON", "Parameter error", data->sRawMsg);

        return;
    }

    // Get parameter values
    std::string module = data->vParams.at(0);

    pthread_mutex_lock(&JSONMap_Mutex);

    // Did we reach the end ?
    auto it = JSONMap.find(module);
    if((it == JSONMap.end()) || (it->second.size() == 0)) {
        vReturnParams.push_back("END");
        data->sReturn = CreateCSV(vReturnParams);

        LOG_FDBG() << "    End of JSON reached";

        pthread_mutex_unlock(&JSONMap_Mutex);

        return;
    }
   
    // Return document
    vReturnParams.push_back(it->second.at(0));
    data->sReturn = CreateCSV(vReturnParams);

    // Erase the document we return
    it->second.erase(it->second.begin());

    pthread_mutex_unlock(&JSONMap_Mutex);
}
