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

service on new http:Listener(9090) {

    resource function post crm/v3/objects/meetings/batch/upsert(@http:Payload BatchInputSimplePublicObjectBatchInputUpsert payload) returns BatchResponseSimplePublicUpsertObject{
        return {
            completedAt: "2025-01-07T08:47:48.319Z",
            "requestedAt": "2025-01-07T08:47:48.319Z",
            "startedAt": "2025-01-07T08:47:48.319Z",
            "results": [
                {
                    "createdAt": "2025-01-07T08:47:48.319Z",
                    "archived": true,
                    "archivedAt": "2025-01-07T08:47:48.319Z",
                    "new": true,
                    "id": "string",
                    "properties": {
                        "additionalProp1": "string1",
                        "additionalProp2": "string2",
                        "additionalProp3": "string3"
                    },
                    "updatedAt": "2025-01-07T08:47:48.319Z"
                }
            ],
            "status": "COMPLETE"
        };

    }

    resource function get crm/v3/objects/meetings(string? after, string[]? properties, string[]? propertiesWithHistory, string[]? associations, int:Signed32 'limit = 10, boolean archived = false) returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error {
        return {
            "results": [
                {
                    "id": "67358768215",
                    "properties": {
                        "hs_createdate": "2024-12-20T10:27:17.536Z",
                        "hs_lastmodifieddate": "2024-12-27T10:31:04.308Z",
                        "hs_object_id": "67358768215"
                    },
                    "createdAt": "2024-12-20T10:27:17.536Z",
                    "updatedAt": "2024-12-27T10:31:04.308Z",
                    "archived": false
                },
                {
                    "id": "67497972287",
                    "properties": {
                        "hs_createdate": "2024-12-23T15:56:48.198Z",
                        "hs_lastmodifieddate": "2024-12-30T16:01:07.152Z",
                        "hs_object_id": "67497972287"
                    },
                    "createdAt": "2024-12-23T15:56:48.198Z",
                    "updatedAt": "2024-12-30T16:01:07.152Z",
                    "archived": false
                },
                {
                    "id": "67537491329",
                    "properties": {
                        "hs_createdate": "2024-12-24T17:20:33.277Z",
                        "hs_lastmodifieddate": "2024-12-24T17:20:34.348Z",
                        "hs_object_id": "67537491329"
                    },
                    "createdAt": "2024-12-24T17:20:33.277Z",
                    "updatedAt": "2024-12-24T17:20:34.348Z",
                    "archived": false
                }
            ],
            "paging": {
                "next": {
                    "after": "67542196651",
                    "link": "https://api.hubapi.com/crm/v3/objects/meetings?hs_static_app=developer-docs-ui&hs_static_app_version=1.11867&limit=10&archived=false&after=67542196651"
                }
            }
        };

    }

    resource function post crm/v3/objects/meetings(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject|error {
        return {
            "createdAt": "2025-01-07T08:47:48.319Z",
            "archived": true,
            "archivedAt": "2025-01-07T08:47:48.319Z",
            "new": true,
            "id": "string",
            "properties": {
                "additionalProp1": "string1",
                "additionalProp2": "string2",
                "additionalProp3": "string3"
            },
            "updatedAt": "2025-01-07T08:47:48.319Z"
        };
    }

};

