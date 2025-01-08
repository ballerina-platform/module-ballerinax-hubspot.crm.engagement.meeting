import ballerina/test;
//import ballerina/http;

final Client mockClient = check new Client(config,serviceUrl = "http://localhost:9090/crm/v3/objects/meetings");

//final string mockTestFeedbackSubmissionId = "512";

@test:Config {}
function  testMockUpsertBatch() {
   BatchInputSimplePublicObjectBatchInputUpsert payload = {
        "inputs": [
            {
               "properties": {},
               "associations": [],
               "id":"21212121121"
            }                       
        ]
    };


   BatchResponseSimplePublicUpsertObject|BatchResponseSimplePublicUpsertObjectWithErrors|error response = mockClient->/batch/upsert.post(payload);


   if response is BatchResponseSimplePublicUpsertObject{
       test:assertTrue(response.status is "COMPLETE");
   }else {
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

function testMockCreateMeeting(){
    BatchInputSimplePublicObjectInputForCreate payload = {
        "inputs": [
            {
                "properties": {},
                "associations": []
            }
        ]
    };

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors|error response = hubspot ->/batch/create.post(payload);

    if response is BatchResponseSimplePublicObject{
        meetingBatchId = response.results[0].id;
        test:assertTrue(response.status is "COMPLETE");
    }else {
        test:assertFail("Failed to create batch of meetings");
    }
}

