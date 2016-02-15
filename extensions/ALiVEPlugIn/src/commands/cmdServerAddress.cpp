/*!
 * \brief   ALiVE Class - cmdServerAddress
 * \details This file will contain functions for CMD_ServerAddress
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdServerAddress(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Make sure no parameters were passed
    if(data->vParams.size() > 0) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("This function does not require any parameters");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - ServerAddress",
                 "This function does not require any parameters", data->sRawMsg);

        return;
    }

    LOG_FINFO() << "    ServerAddress - Querying for IP @ ipify.org";

    // Get IP from ipify.org in JSON format
    CurlData cData;
    if(!curlGet("http://api.ipify.org/?format=json", &cData)) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back(cData.error);
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - ServerAddress",
                 "curlGet() failed", cData.error);

        return;
    }

    // Parse JSON
    rapidjson::Document d;
    d.Parse(cData.content.c_str());

    // Make sure it's an object
    if(!d.IsObject()) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("JSON not a valid object");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - ServerAddress",
                 "JSON not a valid object", cData.content);
    }

    // Look for member 'ip'
    rapidjson::Value::ConstMemberIterator itr = d.FindMember("ip");
    if(itr == d.MemberEnd()) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("No IP returned");
        data->sReturn = CreateCSV(vReturnParams);

        LogError(data->sFunctionName,
                 "No IP returned", data->sRawMsg);

        return;
    }

    // Return IP
    vReturnParams.push_back(itr->value.GetString());
    data->sReturn = CreateCSV(vReturnParams);

    LOG_FINFO() << "        IP returned: " << itr->value.GetString();
}
