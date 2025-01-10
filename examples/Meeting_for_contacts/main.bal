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

import ballerinax/hubspot.crm.engagement.meeting as meeting;
import ballerina/http;
import ballerina/io;
import ballerina/oauth2;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string serviceUrl = ?;
configurable string contactId = ?;

meeting:OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

public function main() returns error? {
    final meeting:Client meetingClient = check new ({auth});

    //create a meeting associated with the contact
    meeting:SimplePublicObjectInputForCreate createPayload = {
        "properties": {
            "hs_timestamp": "2025-03-23T01:02:44.872Z",
            "hs_meeting_title": "Intro meeting",
            "hs_meeting_body": "The first meeting to discuss options",
            "hs_internal_meeting_notes": "These are the meeting notes",
            "hs_meeting_external_url": "https://Zoom.com/0000",
            "hs_meeting_location": "Remote",
            "hs_meeting_start_time": "2021-03-23T01:02:44.872Z",
            "hs_meeting_end_time": "2021-03-23T01:52:44.872Z",
            "hs_meeting_outcome": "SCHEDULED"
        },
        "associations": [
            {
                "to": {
                    "id": contactId
                },
                "types": [
                    {
                        "associationCategory": "HUBSPOT_DEFINED",
                        "associationTypeId": 200
                    }
                ]
            }
        ]

    };
    meeting:SimplePublicObject meetingResponse = check meetingClient->/.post(createPayload);
    string meetingId = meetingResponse.id;
    io:println(`A meeting created associated to the contact (contactId:${contactId}) with id ${meetingId}`);

    //get created meeting by id
    meeting:SimplePublicObjectWithAssociations meetingOutput = check meetingClient->/[meetingId]();
    io:println(`Created Meeting title: ${meetingOutput.properties["hs_meeting_title"]} and scheduled date ${meetingOutput.properties["hs_timestamp"]}`);

    //update created meeting scheduled date and titile
    meeting:SimplePublicObjectInput updatePayload = {
        "properties": {
            "hs_timestamp": "2025-05-23T01:02:44.872Z",
            "hs_meeting_title": "Intro meeting updated"
        }
    };
    meeting:SimplePublicObject updatedOutput = check meetingClient->/[meetingId].patch(updatePayload);
    io:println(`Meeting updated with title ${updatedOutput.properties["hs_meeting_title"]} and scheduled date ${updatedOutput.properties["hs_timestamp"]}`);

    //get all meetings associated with the contact
    meeting:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging meetingList = check meetingClient->/;
    io:println(`Meetings associated with the contact: ${meetingList.toBalString()}`);

    //delete the created meeting
    http:Response response = check meetingClient->/[meetingId].delete();
    io:println(`Meeting deleted with status code ${response.statusCode}`);
}

