import ballerina/oauth2;
import ballerinax/hubspot.crm.engagement.meeting as meeting;
import ballerina/io;
import ballerina/http;

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

    string meetingId = "";
    final meeting:Client meetingClient = check new ({auth});

    meeting:SimplePublicObjectInputForCreate createPayload ={
        "properties": {
            "hs_timestamp": "2021-03-23T01:02:44.872Z",
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
    meetingId = meetingResponse.id;
    io:println(`A meeting created associated to the contact (contactId:${contactId}) with id ${meetingId}`);

    //get created meeting by id
    meeting:SimplePublicObjectWithAssociations meetingOutput = check meetingClient->/[meetingId]();
    io:println(`Created Meeting title: ${meetingOutput.properties["hs_meeting_title"]} and scheduled date ${meetingOutput.properties["hs_timestamp"]}`);

    //update created meeting scheduled date and titile
    meeting:SimplePublicObjectInput updatePayload ={
        "properties": {
            "hs_timestamp": "2021-05-23T01:02:44.872Z",
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


