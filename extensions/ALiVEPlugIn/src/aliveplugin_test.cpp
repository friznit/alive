/*!
 * \brief   ALiVEPlugIn Unit Tester
 * \details This file will handle unit testing for aliveplugin.cpp
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "gtest/gtest.h"
#include "aliveplugin.h"

class ALiVEPlugInTest : public ::testing::Test {
    protected:
        Alive alive;
};

TEST_F(ALiVEPlugInTest, ALiVE_Extension_InvalidData) {
    char output[1024];
    ALiVE_Extension(output, 1024, "dsgah4ta¤w4wt aw4iuw4i ajwABW4 [''asd jas]");

    EXPECT_STREQ("['dsgah4ta\xC2\xA4w4wt','ERROR','Unknown command']", output);
}

TEST_F(ALiVEPlugInTest, ALiVE_Extension_ValidData) {
    char output[1024];
    ALiVE_Extension(output, 1024, "SendJSON ['sys_player/docid1234','['This is some random stuff']','PUT','{ some json data }','somedbname']");

    // TODO Define expectations
}

TEST_F(ALiVEPlugInTest, ALiVE_Extension_DateTime_Invalid) {
    char output[1024];
    ALiVE_Extension(output, 1024, "DateTime ['What''s this ?','More parameters ?']");

    EXPECT_STREQ("['DateTime','ERROR','Parameter error']", output);
}

TEST_F(ALiVEPlugInTest, ALiVE_Extension_StartALiVE) {
    char output[1024];
    ALiVE_Extension(output, 1024, "StartALiVE ['true']");

    EXPECT_STREQ("['StartALiVE','OK','Performance Monitor: Disabled']", output);
}
