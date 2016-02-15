/*!
 * \brief   ALiVE Class - cmdSendBulkJSON
 * \details This file will contain functions for CMD_SendBulkJSON
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdSendBulkJSON(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Check parameter count
    if(data->vParams.size() != 3) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Parameter error");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendBulkJSON", "Parameter error", data->sRawMsg);

        return;
    }

    // Get parameter values
    std::string method      = data->vParams.at(0);
    std::string module      = data->vParams.at(1);
    std::string jsondata    = data->vParams.at(2);

    // Set URL
    std::string url = Config.url + "/" + module + "/_all_docs?include_docs=true";

    // Set User:Pass
    std::string userpwd = Config.user + ":" + Config.pass;

    // Send data
    CurlData cData;
    if(!curlGet(url, &cData, userpwd, jsondata, method)) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back(cData.error);
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendBulkJSON", "curlGet() failed", cData.error);

        return;
    }

    // A vector to put JSON data into
    std::vector<std::string> jsonVector;

    // Parse JSON
    rapidjson::Document d;
    d.Parse(cData.content.c_str());

    // Make sure it's an object
    if(!d.IsObject()) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("JSON not a valid object");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendBulkJSON",
                 "JSON not a valid IsObject", cData.content);

        return;
    }

    // Look for member 'rows'
    rapidjson::Value::ConstMemberIterator itr = d.FindMember("rows");
    if(itr == d.MemberEnd()) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("'rows' not found");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendBulkJSON",
                 "'rows' not found", data->sRawMsg);

        return;
    }

    // Is it an array ?
    const rapidjson::Value &rows = d["rows"];
    if(!rows.IsArray()) {
        vReturnParams.push_back(data->sFunctionName);
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("'rows' is not an array");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - SendBulkJSON",
                 "'rows is not an array'", data->sRawMsg);

        return;
    }

    pthread_mutex_lock(&JSONMap_Mutex);

    // Push rows into our JSONMap
    for(rapidjson::SizeType i = 0; i < rows.Size(); i++) {
        rapidjson::StringBuffer buffer;
        rapidjson::Writer<rapidjson::StringBuffer> writer(buffer);

        // Make sure it's an object
        if(!rows[i].IsObject())
            continue;

        // Find member 'doc'
        rapidjson::Value::ConstMemberIterator rowItr = rows[i].FindMember("doc");
        if(rowItr == rows[i].MemberEnd())
            continue;

        const rapidjson::Value &doc = rows[i]["doc"];
        if(!doc.IsObject())
            continue;

        doc.Accept(writer);

        JSONMap[module].push_back(buffer.GetString());
        LOG_FDBG() << "### Pushing: " << buffer.GetString();
    }

    pthread_mutex_unlock(&JSONMap_Mutex);

    // Return success
    vReturnParams.push_back("OK");
    data->sReturn = CreateCSV(vReturnParams);
}
