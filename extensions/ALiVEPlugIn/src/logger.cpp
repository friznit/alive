/*!
 * \brief   Logger
 * \details This file will handle most of the logging
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include <logger.h>

std::shared_ptr<spdlog::logger> LogConsole = spdlog::stdout_logger_mt("console");
#ifdef __gnu_linux__
std::shared_ptr<spdlog::logger> LogFile = spdlog::daily_logger_st("file", "@aliveserver/aliveplugin", 23, 59, true);

// Temporary while testing performance monitor
std::shared_ptr<spdlog::logger> LogFilePerf = spdlog::daily_logger_st("filePerf", "@aliveserver/aliveplugin-perf", 23, 59, true);
#else
std::shared_ptr<spdlog::logger> LogFile = spdlog::daily_logger_st("file", "@aliveserver\\aliveplugin", 23, 59, true);

// Temporary while testing performance monitor
std::shared_ptr<spdlog::logger> LogFilePerf = spdlog::daily_logger_st("filePerf", "@aliveserver\\aliveplugin-perf", 23, 59, true);
#endif
