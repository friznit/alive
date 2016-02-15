/*!
 * \brief   Arma Entry Point
 * \details These functions will handle the RVExtension entry point for Arma.
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include <string>
#include "aliveplugin.h"

Alive alive;

void ALiVE_Extension(char *output, int outputSize, const char *function) {
    Alive::AliveData data;

    // Start measuring time
    std::chrono::time_point<std::chrono::system_clock> start, end;
    start = std::chrono::system_clock::now();

    // Parse incoming message
    alive.ParseMessage(function, &data);

    LOG_FTRC() << "###### ALiVE_Extension ParseMessage ######";
    LOG_FTRC() << "    ALiVE_Extension RAW [" << data.sRawMsg << "]";
    LOG_FTRC() << "    ALiVE_Extension Function [" << data.sFunctionName << "]";
    for(uint32_t i = 0; i < data.vParams.size(); i++) {
        LOG_FTRC() << "    ALiVE_Extension     Param(" << i << ") [" << data.vParams.at(i) << "]";
    }

    // Handle parsed message
    alive.HandleMessage(&data);

    LOG_FTRC() << "###### ALiVE_Extension HandleMessage ######";
    LOG_FTRC() << "    ALiVE_Extension Return [" << data.sReturn << "]";

    // Check for buffer overrun
    if(data.sReturn.size() >= outputSize) {
        LOG_FWARN() << "    Buffer overrun";
        LOG_FWARN() << "        Size: " << data.sReturn.size();
        LOG_FWARN() << "        Max:  " << outputSize;

        data.sReturn = "['" + data.sFunctionName + "','BUFFER OVERRUN']";
    }

    // Copy return value back to Arma
    memset(output, 0x00, outputSize);
    std::copy(data.sReturn.begin(), data.sReturn.end(), output);
    output[data.sReturn.size()] = '\0';

    // Calculate elapsed time
    end = std::chrono::system_clock::now();
    std::chrono::duration<double> elapsed = end - start;
    elapsed *= 1000;

    LOG_FDBG() << "|/-\\ Elapsed time: " << elapsed.count() << "ms";
}

#ifdef __gnu_linux__
//! Linux entry point
void RVExtension(char *output, int outputSize, const char *function) {
    LOG_FTRC() << "RVExtension IN  [" << function << "]";
    ALiVE_Extension(output, outputSize, function);
    LOG_FTRC() << "RVExtension OUT [" << output << "]";
}
#else
//! Windows entry point
__stdcall void _RVExtension(char *output, int outputSize, const char *function) {
    LOG_FTRC() << "RVExtension IN  [" << function << "]";
    ALiVE_Extension(output, outputSize, function);
    LOG_FTRC() << "RVExtension OUT [" << output << "]";
}

int CALLBACK WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow) {
    return 0;
}
#endif
