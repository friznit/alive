/*!
 * \brief   PerfMon Class
 * \details This class will handle Performance Monitor specific actions
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "perfmon.h"

double              PerfMon::perfCPU = 0.0;
pthread_mutex_t     PerfMon::perfCPUMutex;

PerfMon::PerfMon() {
    // Initialize mutexes
    pthread_mutex_init(&perfCPUMutex, NULL);

    // Create sampling thread
    int res = pthread_create(&perfThread, NULL, SamplingThread, NULL);
}

PerfMon::~PerfMon() {
    // Kill sampling thread
    pthread_cancel(perfThread);

    // Destroy mutexes
    pthread_mutex_destroy(&perfCPUMutex);
}

double PerfMon::GetCPUUsage() {
    double retval = 0.0;

    // Get CPU Performance Data
    pthread_mutex_lock(&perfCPUMutex);
    retval = perfCPU;
    pthread_mutex_unlock(&perfCPUMutex);

    return retval;
}

void *PerfMon::SamplingThread(void*) {
    // Linux specific
#ifdef __gnu_linux__
    // An object to hold our stream
    FILE *pFile;

    // Some CPU related variables
    long long int user = 0, nice = 0, system = 0, idle = 0, iowait = 0, irq = 0, softirq = 0;
    long int utime = 0, stime = 0;

    // Variables to put our calculation in
    long long int total_cpu_time1 = 0, total_cpu_time2 = 0;
    long int total_proc_time1 = 0, total_proc_time2 = 0;
    long int diff_cpu_time = 0, diff_proc_time = 0;
#else // Windows specific
    // Get currect process
    HANDLE hProcess = GetCurrentProcess();

    // Some FILETIMES
    FILETIME ftSys;
    FILETIME ftKernel, ftUser;

    // Some large integers to do our calculations with
    ULARGE_INTEGER uiSys, uiKernel, uiUser;
    ULARGE_INTEGER uiPrevSys, uiPrevKernel, uiPrevUser;

    // Don't calculate on first run, we have to sample data first
    bool bFirstRun = true;

    // Get number of cores/processors
    SYSTEM_INFO sysInfo;
    GetSystemInfo(&sysInfo);
    int nProcessors = sysInfo.dwNumberOfProcessors;
#endif

    while(1) {
        // Linux specific
#ifdef __gnu_linux__
        // Get total CPU time of process
        pFile = fopen("/proc/self/stat", "r");
        fscanf(pFile, "%*d %*s %*c %*d"
                      "%*d %*d %*d %*d %*u %*lu %*lu %*lu %*lu"
                      "%lu %lu", &utime, &stime);
        fclose(pFile);
        total_proc_time2 = utime + stime;

        // Get total CPU time
        pFile = fopen("/proc/stat", "r");
        fscanf(pFile, "%*s %llu %llu %llu %llu %llu %llu %llu", &user, &nice, &system, &idle, &iowait, &irq, &softirq);
        fclose(pFile);
        total_cpu_time2 = user + nice + system + idle + iowait + irq + softirq;

        // On first run we'll just set old and new variables almost equal
        if(total_cpu_time1 == 0) {
            total_cpu_time1 = total_cpu_time2 - 1;
            total_proc_time1 = total_proc_time2;
        }

        // Calculate the differences
        diff_cpu_time = (total_cpu_time2 - total_cpu_time1) / sysconf(_SC_NPROCESSORS_ONLN);
        diff_proc_time = total_proc_time2 - total_proc_time1;

        // We can't have values exceeding 100%. We'll just to what VW does. Deception!
        if(diff_cpu_time < diff_proc_time) diff_proc_time = diff_cpu_time;

        // Calculate and put the CPU usage in our class variable
        pthread_mutex_lock(&perfCPUMutex);
        perfCPU = ((double)diff_proc_time / diff_cpu_time) * 100;
        pthread_mutex_unlock(&perfCPUMutex);

        // Store data for use at next sample
        total_cpu_time1 = total_cpu_time2;
        total_proc_time1 = total_proc_time2;

#ifdef DEBUG
        printf("CPU  %llu %llu %llu %llu %llu %llu %llu\r\n", user, nice, system, idle, iowait, irq, softirq);
        printf("PROC %lu %lu\r\n", utime, stime);
        printf("DIFF %lu %lu\r\n", diff_cpu_time, diff_proc_time);
        printf("LOAD %f\r\n\r\n", perfCPU);
#endif

#else // Windows specific
        // Get system FileTime and copy to a large integer
        GetSystemTimeAsFileTime(&ftSys);
        memcpy(&uiSys, &ftSys, sizeof(FILETIME));

        // Get process times
        if(!GetProcessTimes(hProcess, &ftSys, &ftSys, &ftKernel, &ftUser)) {
            perfCPU = -1.0f;
        }
        // Copy ProcessTimes to our large integers
        memcpy(&uiKernel, &ftKernel, sizeof(FILETIME));
        memcpy(&uiUser, &ftUser, sizeof(FILETIME));

        if(bFirstRun) {
            bFirstRun = false;
        } else {
            // Calculate CPU load
            pthread_mutex_lock(&perfCPUMutex);
            perfCPU = (uiKernel.QuadPart - uiPrevKernel.QuadPart) + (uiUser.QuadPart - uiPrevUser.QuadPart);
            perfCPU /= (uiSys.QuadPart - uiPrevSys.QuadPart);
            perfCPU /= nProcessors;
            perfCPU *= 100;
            pthread_mutex_unlock(&perfCPUMutex);
        }

        uiPrevSys = uiSys;
        uiPrevKernel = uiKernel;
        uiPrevUser = uiUser;
#endif

        LogFilePerf->info() << "CPU: " << perfCPU << " %";

        // Wait before we sample again
        sleep(1);
    }

    pthread_exit(0);
}
