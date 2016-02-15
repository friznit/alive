/*!
 * \brief   Logger
 * \details This file will handle most of the logging
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include <logger.h>

std::shared_ptr<spdlog::logger> LogConsole = spdlog::stdout_logger_mt("console");
#ifdef __gnu_linux__
std::shared_ptr<spdlog::logger> LogFile = spdlog::daily_logger_st("file", "@aliveserver/aliveplugin", 23, 59);
#else
std::shared_ptr<spdlog::logger> LogFile = spdlog::daily_logger_st("file", "@aliveserver\\aliveplugin", 23, 59);
#endif
