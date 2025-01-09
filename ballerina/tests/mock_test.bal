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

//import ballerina/http;

final Client mockClient = check new Client(config, serviceUrl = "http://localhost:9090/crm/v3/objects/meetings");

//final string mockTestFeedbackSubmissionId = "512";

@test:Config {}
function testMockUpsertBatch() {
    BatchInputSimplePublicObjectBatchInputUpsert payload = {
        "inputs": [
            {
                "properties": {},
                "associations": [],
                "id": "21212121121"
            }
        ]
    };

    BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors|error response = mockClient->/batch/upsert.post(payload);

    if response is BatchResponseSimplePublicUpsertObject {
        test:assertTrue(response.status is "COMPLETE");
    } else {
        test:assertFail("Failed to create or update batch of meetings");
    }
}

@test:Config {}
function testMockGetMeetings() {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error response = mockClient->/;
    if response is CollectionResponseSimplePublicObjectWithAssociationsForwardPaging {
        test:assertTrue(response.results.length() > 0);
    } else {
        test:assertFail("Failed to get meetings");
    }
}

@test:Config {}

function testMockCreateMeeting() {
    BatchInputSimplePublicObjectInputForCreate payload = {
        "inputs": [
            {
                "properties": {},
                "associations": []
            }
        ]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error response = hubspot->/batch/create.post(payload);

    if response is BatchResponseSimplePublicObject {
        meetingBatchId = response.results[0].id;
        test:assertTrue(response.status is "COMPLETE");
    } else {
        test:assertFail("Failed to create batch of meetings");
    }
}
