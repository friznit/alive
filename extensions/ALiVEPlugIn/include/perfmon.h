/*!
 * \brief   PerfMon Class
 * \details This class will handle Performance Monitor specific actions
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#ifndef PERFMON_H_
#define PERFMON_H_

#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#include <logger.h>

#ifdef __gnu_linux__
#else
#include <windows.h>
#endif

/*!
 * This class will handle all Performance Monitor specific actions
 */
class PerfMon {
    public:
        PerfMon();
        ~PerfMon();

        /*!
         * Get CPU usage sampled from SamplingThread
         * @return CPU usage in %
         */
        double GetCPUUsage();

    private:
        //! Thread Identity
        pthread_t perfThread;

        // CPU Performance Data
        static double perfCPU;
        static pthread_mutex_t perfCPUMutex;

        /*!
         * Our Sampling Thread
         */
        static void *SamplingThread(void*);
};

#endif // PERFMON_H_
