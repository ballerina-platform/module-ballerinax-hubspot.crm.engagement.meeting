// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;

final Client meetingClient = check new Client(config, serviceUrl = "http://localhost:9090/crm/v3/objects/meetings");

@test:Config {}
function testMockUpsertBatch() returns error? {
    BatchInputSimplePublicObjectBatchInputUpsert payload = {
        "inputs": [
            {
                "properties": {},
                "associations": [],
                "id": "21212121121"
            }
        ]
    };
    BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors response = 
                                                                                        check meetingClient->/batch/upsert.post(payload);
    test:assertTrue(response.status is "COMPLETE");
}

@test:Config {}
function testMockGetMeetings() returns error? {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check meetingClient->/;
    test:assertTrue(response.results.length() > 0);
}

@test:Config {}
function testMockCreateMeeting() returns error? {
    SimplePublicObjectInputForCreate payload = {
        "properties": {
            "hs_timestamp": "2021-03-23T01:02:44.872Z",
            "hs_meeting_title": "test meeting"
        },
        "associations": []
    };
    SimplePublicObject output = check meetingClient->/.post(payload = payload);
    meetingId = output.id;
    test:assertTrue(output.createdAt !is "");
}
