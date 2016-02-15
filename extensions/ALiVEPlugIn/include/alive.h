/*!
 * \brief   ALiVE Class
 * \details This class will handle ALiVE specific actions
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#ifndef ALIVE_H_
#define ALIVE_H_

#include <chrono>
#include <fstream>
#include <iostream>
#include <map>
#include <regex>
#include <sstream>
#include <string>
#include <vector>

#include <pthread.h>

#include <curl/curl.h>

#include <logger.h>
#include <rapidjson/document.h>
#include <rapidjson/stringbuffer.h>
#include <rapidjson/writer.h>

#include <sigar.h>

#ifdef __gnu_linux__
#include <pwd.h>
#include <unistd.h>

#include <uuid/uuid.h>

#define GetCurrentDir getcwd
#else
#include <shlobj.h>
#include <direct.h>

#include <rpcdce.h>

#define GetCurrentDir _getcwd
#endif

static size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp) {
    ((std::string*)userp)->append((char*)contents, size * nmemb);
    return size * nmemb;
}

/*!
 * This class will handle all ALiVE specific actions
 */
class Alive {
    public:
        Alive();
        ~Alive();

         //! Enumeration of commands
        enum Commands {
            CMD_DateTime,
            CMD_GetBulkJSON,
            CMD_GroupName,
            CMD_SendBulkJSON,
            CMD_SendJSON,
            CMD_SendJSONAsync,
            CMD_SendJSONToFile,
            CMD_ServerAddress,
            CMD_ServerName,
            CMD_StartALiVE,
            CMD_UNKNOWN
        };

       //! A struct to hold data received from Arma 3
        struct AliveData {
            Commands eCmd;
            std::string sRawMsg;
            std::string sFunctionName;
            std::vector<std::string> vParams;

            std::string sReturn;

            AliveData() :
                eCmd(CMD_UNKNOWN) {}
        };

        /*!
         * Handle CMD_SendJSONAsync Thread
         * $param _data a void pointer
         */
        static void *cmdSendJSONThread(void *_data);

        /*!
         * Handle parsed message.
         * AliveData must be handled by ParseMessage(...) first.
         * @param data an Alive::AliveData pointer
         */
        void HandleMessage(AliveData *data);

        /*!
         * Parse message received from Arma 3.
         * $param msg a string containing the data from A3
         * $param data an Alive::AliveData pointer
         */
        void ParseMessage(const std::string &msg, AliveData *data);

    private:
        //! Command Map
        std::map<std::string, Commands> CommandMap; 

        //! JSON Map
        static std::map<std::string, std::vector<std::string>> JSONMap;
        static pthread_mutex_t JSONMap_Mutex;

        //! Our thread counter
        static uint32_t JSONAsync_Threads;
        static pthread_mutex_t JSONAsync_Threads_Mutex;

        //! Enable Debug ?
        bool debug = false;

        //! Disable Performance Monitor ?
        bool disablePerfMon = true;

        //! A struct holding configuration data
        struct {
            std::string type;
            std::string user;
            std::string pass;
            std::string group;
            std::string url;

            bool initialized = false;
        } Config;

        struct CurlData {
            std::string content;
            std::string error;
        };

        /*!
         * Handle CMD_DateTime
         * $param data an Alive::AliveData pointer
         */
        void cmdDateTime(Alive::AliveData *data);

        /*!
         * Handle CMD_GetBulkJSON
         * $param data an Alive::AliveData pointer
         */
        void cmdGetBulkJSON(Alive::AliveData *data);

        /*!
         * Handle CMD_SendBulkJSON
         * $param data an Alive::AliveData pointer
         */
        void cmdSendBulkJSON(Alive::AliveData *data);

        /*!
         * Handle CMD_SendJSON
         * $param data an Alive::AliveData pointer
         */
        void cmdSendJSON(Alive::AliveData *data);

        /*!
         * Handle CMD_SendJSONAsync
         * $param data an Alive::AliveData pointer
         */
        void cmdSendJSONAsync(Alive::AliveData *data);

        /*!
         * Handle CMD_ServerAddress
         * $param data an Alive::AliveData pointer
         */
        void cmdServerAddress(Alive::AliveData *data);

        /*!
         * Handle CMD_ServerName
         * $param data an Alive::AliveData pointer
         */
        void cmdServerName(Alive::AliveData *data);

        /*!
         * Handle CMD_StartALiVE
         * $param data an Alive::AliveData pointer
         */
        void cmdStartALiVE(Alive::AliveData *data);

        /*!
         * Use libcurl to get HTTP content
         * $param url the URL
         * $param data pointer to CurlData
         * $param userpwd a string with "username:password". Empty string if not used
         * $param postfields a string with the POST fields. Empty string if not used.
         * $param usePut wether to use POST or PUT as method
         * $return true/false whether the function succeeded or not
         */
        static bool curlGet(const std::string& url, CurlData *data,
                     const std::string& userpwd = "",
                     const std::string& postfields = "",
                     const std::string& method = "");

        /*!
         * Create CSV data.
         * @param vParams a vector of strings containing the parameters
         * @return the CSV string
         */
        static std::string CreateCSV(const std::vector<std::string> vParams);

        /*!
         * Gets the current system time
         * @param format the format of the returned value
         * @return the current system time in the specified format
         */
        std::string GetTime(const std::string &format);

         /*!
          * Write function errors to the logfile
          * @param function the function name
          * @param error the error description
          * @param raw the raw message sent to the plugin
          */
         void LogError(const std::string &function, const std::string &error, const std::string &raw);

         /*!
          * Write function warning to the logfile
          * @param function the function name
          * @param warning the warning description
          * @param raw the raw message sent to the plugin
          */
         void LogWarning(const std::string &function, const std::string &warning, const std::string &raw);

        /*!
         * Parse CSV data.
         * $param params a string containing the parameters received from Arma 3
         * $param vParams a vector of strings containing the various parameters
         */
        void ParseCSV(const std::string &params, std::vector<std::string> *vParams);

        /*!
         * Read ALiVE config file
         * @return a vector containing the config information
         */
        bool ReadConfig(std::vector<std::string> *params);
};

#endif // ALIVE_H_
