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

import ballerina/http;
import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.engagement.meeting as hsmeeting;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string serviceUrl = ?;

hsmeeting:OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

public function main() returns error? {
    string meetingId = "";
    final hsmeeting:Client meetingClient = check new ({auth});

    //create a meeting batch
    hsmeeting:BatchInputSimplePublicObjectInputForCreate createBatchPayload = {
        "inputs": [
            {
                "properties": {},
                "associations": []
            }
        ]
    };
    hsmeeting:BatchResponseSimplePublicObject meetingResponse = check meetingClient->/batch/create.post(createBatchPayload);
    meetingId = meetingResponse.results[0].id;
    io:println(`A meeting batch created with id ${meetingId}`);

    //get created meeting batch by id
    hsmeeting:BatchReadInputSimplePublicObjectId payload =
        {
        "propertiesWithHistory": [],
        "inputs": [
            {
                "id": meetingId
            }
        ],
        "properties": [
            "hs_timestamp"
        ]
    };
    hsmeeting:BatchResponseSimplePublicObject|hsmeeting:BatchResponseSimplePublicObjectWithErrors meetingOutput = check meetingClient->/batch/read.post(payload);
    io:println(`Created Meeting batch id: ${meetingOutput.results[0].id} and scheduled date ${meetingOutput.results[0].properties["hs_timestamp"]}`);

    //update created meeting batch scheduled date
    hsmeeting:BatchInputSimplePublicObjectBatchInput updatePayload = {
        "inputs": [
            {
                "id": meetingId,
                "properties": {
                    "hs_timestamp": "2021-03-23T01:02:44.872Z"
                }
            }
        ]
    };
    hsmeeting:BatchResponseSimplePublicObject|hsmeeting:BatchResponseSimplePublicObjectWithErrors _ = check meetingClient->/batch/update.post(updatePayload);
    io:println(`Meeting batch updated with id ${meetingId}`);

    //archive created meeting batch
    hsmeeting:BatchInputSimplePublicObjectId archivePayload = {
        "inputs": [
            {
                "id": meetingId
            }
        ]
    };
    http:Response _ = check meetingClient->/batch/archive.post(archivePayload);
    io:println(`Meeting batch archived with id ${meetingId}`);

}

