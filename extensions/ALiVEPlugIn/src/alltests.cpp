/*!
 * \brief   Unit Tester
 * \details This file will initialize the unit tester
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "gtest/gtest.h"

int main(int ac, char** av) {
    ::testing::InitGoogleTest(&ac, av);

    return RUN_ALL_TESTS();
}
