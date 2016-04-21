/*!
 * \brief   PerfMon Unit Tester
 * \details This file will handle unit testing for perfmon.cpp
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "gtest/gtest.h"
#include "perfmon.h"

class PerfMonTest : public ::testing::Test {
    protected:
};

TEST_F(PerfMonTest, GetCPUUsage) {
    PerfMon perf;

/*    float number = 1.5;
    for(long long int i = 0; i < 1000000000; i++) {
        number *= number;
    }*/

    double value = perf.GetCPUUsage();

//    EXPECT_FLOAT_EQ(1.1, value);
}
