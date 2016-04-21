/*!
 * \brief   Alive Unit Tester
 * \details This file will handle unit testing for alive.cpp
 * \author  Kim Adrian (secure)
 * \date    2015
 */

#include "gtest/gtest.h"
#include "alive.h"

class AliveTest : public ::testing::Test {
    protected:
        static void SetUpTestCase() {
            a = new Alive();
            Alive::AliveData data;
            a->ParseMessage("StartALiVE ['true']", &data);
            a->HandleMessage(&data);
        }

        static void TearDownTestCase() {
            delete a;
        }

        static Alive *a;
};

Alive *AliveTest::a = NULL;

TEST_F(AliveTest, CSVParseTest) {
    Alive::AliveData data;
    a->ParseMessage("SendJSON ['GET','events/_design/playerPage/_view/playerTotals?group_level=1&key=\"76561197970881889\"&stale=ok','']", &data);
    a->HandleMessage(&data);
}

TEST_F(AliveTest, cmdSendBulkJSON_and_cmdGetBulkJSON) {
    Alive::AliveData data;

    a->ParseMessage("SendBulkJSON ['GET','plugin_test','']", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['OK']", data.sReturn.c_str());

    while(data.sReturn != "['END']") {
        a->ParseMessage("GetBulkJSON ['plugin_test']", &data);
        a->HandleMessage(&data);
    }
}

TEST_F(AliveTest, cmdSendJSON) {
    Alive::AliveData data;

    uuid_t uuid;
    char uuid_str[37];

    // Generate an UUID
    uuid_generate_time_safe(uuid);
    uuid_unparse_lower(uuid, uuid_str);

    // Our JSON Data
    std::string jsondata = "{\"AliveTest\":\"cmdSendJSON\",\"Info\":\"This document was generated from the aliveTest Unit Tester\"}";

    // Set up our command
    std::string cmd = "SendJSON ['PUT','plugin_test/";
    cmd += uuid_str;
    cmd += "','";
    cmd += jsondata;
    cmd += "']";

    // Let the plugin do its magic
    a->ParseMessage(cmd, &data);
    a->HandleMessage(&data);

    // Strip the CSV part
    std::string recv = data.sReturn;
    recv = recv.substr(2, recv.size() - 4);

    // Parse it as a JSON string
    rapidjson::Document d;
    d.Parse(recv.c_str());

    // Our verifiers
    bool ok = false;
    std::string uuid_check;

    // Find member "ok"
    rapidjson::Value::ConstMemberIterator itr = d.FindMember("ok");
    if(itr != d.MemberEnd()) {
        ok = itr->value.GetBool();
        // Get the uuid as well
        uuid_check = d["id"].GetString();
    }

    // Verify...
    EXPECT_TRUE(ok);
    EXPECT_STREQ(uuid_check.c_str(), uuid_str);
}

TEST_F(AliveTest, cmdSendJSONAsync) {
    Alive::AliveData data;

    a->ParseMessage("SendJSONAsync ['GET','plugin_test','']", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['SendJSONAsync','OK']", data.sReturn.c_str());

    while(data.sReturn != "['END']") {
        a->ParseMessage("SendJSONAsync", &data);
        a->HandleMessage(&data);
        usleep(100000);
    }

    EXPECT_STREQ("['END']", data.sReturn.c_str());
}

TEST_F(AliveTest, cmdSendJSONAsync_events) {
    Alive::AliveData data;

    a->ParseMessage("SendJSONAsync ['POST','plugin_test','{\"realTime\":\"17/07/2015 00:56:21\",\"Server\":\"86.154.235.174\",\"Group\":\"NSG\",\"Operation\":\"ALiVE | Getting Started\",\"Map\":\"stratis\",\"gameTime\":\"0541\",\"Event\":\"Kill\",\"KilledSide\":\"UNKNOWN\",\"Killedfaction\":\"NATO\",\"KilledType\":\"Hunter HMG\",\"KilledClass\":\"Vehicle\",\"KilledPos\":\"029018\",\"KilledGeoPos\":[2999.94,1882.79,-0.0336151],\"KillerSide\":\"CIV\",\"Killerfaction\":\"NATO\",\"KillerType\":\"Hunter GMG\",\"KillerClass\":\"Vehicle\",\"KillerPos\":\"029018\",\"KillerGeoPos\":[2997.29,1887.46,-0.0150909],\"Weapon\":\"RCWS GMG 40 mm (Hunter GMG)\",\"WeaponType\":\"GMG_40mm\",\"Distance\":6,\"Killed\":\"vehicle_0\",\"Killer\":\"vehicle_1\",\"KillerConfig\":\"B_MRAP_01_gmg_F\",\"KilledConfig\":\"B_MRAP_01_hmg_F\",\"Player\":\"76561197982137286\",\"PlayerName\":\"Matt\",\"playerGroup\":\"NSG\"}']", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['SendJSONAsync','OK']", data.sReturn.c_str());

    while(data.sReturn != "['END']") {
        a->ParseMessage("SendJSONAsync", &data);
        a->HandleMessage(&data);
        usleep(100000);
    }

    EXPECT_STREQ("['END']", data.sReturn.c_str());
}

TEST_F(AliveTest, cmdServerAddress_InvalidParam) {
    Alive::AliveData data;

    a->ParseMessage("ServerAddress ['SomeParams']", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['ServerAddress','ERROR','This function does not require any parameters']", data.sReturn.c_str());
}

TEST_F(AliveTest, cmdServerAddress_Correct) {
    Alive::AliveData data;

    a->ParseMessage("ServerAddress", &data);
    a->HandleMessage(&data);

    std::regex e("\\['\\d{1,3}.\\d{1,3}.\\d{1,3}.\\d{1,3}'\\]");
    EXPECT_TRUE(std::regex_match(data.sReturn, e));
}

TEST_F(AliveTest, ParseMessage_HandleMessage_DateTime) {
    Alive::AliveData data;

    a->ParseMessage("DateTime ['%d/%m/%Y %T']", &data);
    a->HandleMessage(&data);

    std::regex e("\\['\\d{2}\\/\\d{2}\\/\\d{4}\\s\\d{2}:\\d{2}:\\d{2}'\\]");
    EXPECT_TRUE(std::regex_match(data.sReturn, e));
}

TEST_F(AliveTest, ParseMessage_HandleMessage_DateTime_InvalidParam) {
    Alive::AliveData data;

    a->ParseMessage("DateTime []", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['DateTime','ERROR','Parameter error']", data.sReturn.c_str());

    a->ParseMessage("DateTime ['utcnow','%d/%m/%Y %T']", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['DateTime','ERROR','Parameter error']", data.sReturn.c_str());
}

TEST_F(AliveTest, ParseMessage_HandleMessage_GroupName) {
    Alive::AliveData data;

    a->ParseMessage("GroupName", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['LTG']", data.sReturn.c_str());
}

TEST_F(AliveTest, ParseMessage_HandleMessage_ServerName_Fail) {
    Alive::AliveData data;

    a->ParseMessage("ServerName", &data);
    a->HandleMessage(&data);

    EXPECT_STREQ("['ServerName','ERROR','Server was not started with -config parameter']", data.sReturn.c_str());
}

TEST_F(AliveTest, ParseMessage_UnknownWithParameters) {
    Alive::AliveData data;

    a->ParseMessage("SomeFunction ['Param 1', 'Param, 2', 'Param ''3''']", &data);

    EXPECT_STREQ("SomeFunction", data.sFunctionName.c_str());
    EXPECT_EQ(Alive::CMD_UNKNOWN, data.eCmd);
    EXPECT_EQ(0, data.vParams.size());
}

TEST_F(AliveTest, ParseMessage_UnknownWithoutParameters) {
    Alive::AliveData data;

    a->ParseMessage("SomeFunction", &data);

    EXPECT_STREQ("SomeFunction", data.sFunctionName.c_str());
    EXPECT_EQ(Alive::CMD_UNKNOWN, data.eCmd);
    EXPECT_EQ(0, data.vParams.size());
}
