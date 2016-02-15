#ifndef LOGGER_H_
#define LOGGER_H_

#include <spdlog/spdlog.h>

#define LOG_CCRIT() LogConsole->critical()
#define LOG_FCRIT() LogFile->critical()

#define LOG_CERR() LogConsole->error()
#define LOG_FERR() LogFile->error()

#define LOG_CINFO() LogConsole->info()
#define LOG_FINFO() LogFile->info()

#define LOG_CWARN() LogConsole->warn()
#define LOG_FWARN() LogFile->warn()

#define LOG_CDBG() LogConsole->debug()
#define LOG_FDBG() LogFile->debug()

#define LOG_CTRC() LogConsole->trace()
#define LOG_FTRC() LogFile->trace()

extern std::shared_ptr<spdlog::logger> LogConsole;
extern std::shared_ptr<spdlog::logger> LogFile;

#endif // LOGGER_H_
