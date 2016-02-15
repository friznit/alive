/*!
 * \brief   ALiVE Class - cmdSendJSON
 * \details This file will contain functions for CMD_SendJSON
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdSendJSON(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Check parameter count
    if(data->vParams.size() != 3) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Parameter error");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendJSON", "Parameter error", data->sRawMsg);

        return;
    }
    
    // Get parameter values
    std::string method = data->vParams.at(0);
    std::string module = data->vParams.at(1);
    std::string jsondata = data->vParams.at(2);

    // Set URL
    std::string url = Config.url;
    url += "/";
    url += module;

    // Set User:Pass
    std::string userpwd = Config.user;
    userpwd += ":";
    userpwd += Config.pass;

    // POST/PUT data
    CurlData cData;
    if(!curlGet(url, &cData, userpwd, jsondata, method)) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back(cData.error);
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendJSON", "curlGet() failed", cData.error);

        return;
    }

    // Parse JSON
    rapidjson::Document d;
    d.Parse(cData.content.c_str());

    if(d.IsArray()) {
        for(rapidjson::Value::ConstValueIterator itr = d.Begin(); itr != d.End(); ++itr) {
            if(itr->IsObject()) {
                rapidjson::Value::ConstMemberIterator mItr = itr->FindMember("error");
                if(mItr != itr->MemberEnd()) {
                    vReturnParams.push_back("ERROR");
                    data->sReturn = CreateCSV(vReturnParams);

                    return;
                }
            }
        }
    }

    // Return recieved data from the website
    vReturnParams.push_back(cData.content);
    data->sReturn = CreateCSV(vReturnParams);
}
