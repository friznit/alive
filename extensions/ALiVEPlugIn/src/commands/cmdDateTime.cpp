/*!
 * \brief   ALiVE Class - cmdDateTime
 * \details This file will contain functions for CMD_DateTime
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "alive.h"

void Alive::cmdDateTime(Alive::AliveData *data) {
    std::vector<std::string> vReturnParams;

    // Check parameter count
    if(data->vParams.size() == 1) {
        // Get DateTime and return it
        vReturnParams.push_back(GetTime(data->vParams.at(0)));
        data->sReturn = CreateCSV(vReturnParams);
    } else {
        // Log and respond with the error
        vReturnParams.push_back("DateTime");
        vReturnParams.push_back("ERROR");
        vReturnParams.push_back("Parameter error");
        data->sReturn = CreateCSV(vReturnParams);

        LogError("HandleMessage - DateTime",
        "Parameter error",
        data->sRawMsg);
    }
}

std::string Alive::GetTime(const std::string &format) {
    time_t rawtime;
    struct tm *timeinfo;
    char buffer[128];
    time(&rawtime);

    timeinfo = gmtime(&rawtime);

    strftime(buffer, 128, format.c_str(), timeinfo);

    return buffer;
}

