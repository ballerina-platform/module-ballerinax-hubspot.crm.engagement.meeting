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

import ballerina/oauth2;
import ballerina/test;

configurable string clientId = "clientId";
configurable string clientSecret = "clientSecret";
configurable string refreshToken = "refreshToken";
configurable boolean enableClientOauth2 = false;

// create connection config for live client
ConnectionConfig config = {
    auth: enableClientOauth2 ? {
            clientId,
            clientSecret,
            refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        } : {token: "Bearer token"}
};

// create live client
final Client hubspot = check new Client(config);
// keep the meeting id as reference for other tests after creation
string meetingId = "";
// keep the meeting batch id as reference for other tests after creation
string meetingBatchId = "";

@test:Config {
    dependsOn: [testUpdateMeeting],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testArchiveMeeting() returns error? {
    error? response = check hubspot->/[meetingId].delete();
    test:assertTrue(response == ());
};

@test:Config {
    dependsOn: [testgetMeetingById],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testUpdateMeeting() returns error? {
    SimplePublicObjectInput payload = {
        "properties": {
            "hs_meeting_title": "test meeting changed"
        }
    };
    SimplePublicObject updatedOutput = check hubspot->/[meetingId].patch(payload);
    test:assertEquals(updatedOutput.properties["hs_meeting_title"], "test meeting changed");
}

@test:Config {
    dependsOn: [testCreateMeeting],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testgetMeetingById() returns error? {
    SimplePublicObjectWithAssociations meeting = check hubspot->/[meetingId]();
    test:assertTrue(meeting.id == meetingId);
}

@test:Config {
    dependsOn: [testgetBatchById],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testUpdateBatch() returns error? {
    BatchInputSimplePublicObjectBatchInput payload = {
        "inputs": [
            {
                "id": meetingBatchId,
                "properties": {}
            }
        ]
    };
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/batch/update.post(payload);
    test:assertTrue(response.status is "COMPLETE");
}

@test:Config {
    dependsOn: [testCreateBatch],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testgetBatchById() returns error? {
    BatchReadInputSimplePublicObjectId payload =
        {
        "propertiesWithHistory": [],
        "inputs": [
            {
                "id": meetingBatchId
            }
        ],
        "properties": []
    };
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/batch/read.post(payload);
    test:assertTrue(response.results.length() >= 0);
}

@test:Config {
    dependsOn: [testgetBatchById],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testArchiveBatch() returns error? {
    BatchInputSimplePublicObjectId payload = {
        "inputs": [
            {
                "id": meetingBatchId
            }
        ]
    };
    error? response = check hubspot->/batch/archive.post(payload);
    test:assertTrue(response == ());
}

@test:Config {
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testCreateMeeting() returns error? {
    SimplePublicObjectInputForCreate payload = {
        "properties": {
            "hs_timestamp": "2021-03-23T01:02:44.872Z",
            "hs_meeting_title": "test meeting"
        },
        "associations": []
    };
    SimplePublicObject output = check hubspot->/.post(payload = payload);
    meetingId = output.id;
    test:assertTrue(output.createdAt !is "");
};

@test:Config {
    dependsOn: [testCreateMeeting],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testgetAllMeetings() returns error? {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging meetings = check hubspot->/;
    test:assertTrue(meetings.results.length() > 0);
};

@test:Config {
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testCreateBatch() returns error? {
    BatchInputSimplePublicObjectInputForCreate payload = {
        "inputs": [
            {
                "properties": {},
                "associations": []
            }
        ]
    };
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/batch/create.post(payload);
    meetingBatchId = response.results[0].id;
    test:assertTrue(response.status is "COMPLETE");
}

@test:Config {
    dependsOn: [testgetAllMeetings],
    groups: ["live_service_test"],
    enable: enableClientOauth2
}
function testSearchMeetings() returns error? {
    PublicObjectSearchRequest query = {
        query: "test"
    };
    CollectionResponseWithTotalSimplePublicObjectForwardPaging searchResult = check hubspot->/search.post(payload = query);
    test:assertTrue(searchResult.results.length() > 0);
}
