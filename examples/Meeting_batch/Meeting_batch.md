# Meeting_batch Example for HubSpot Meetings

This Ballerina example demonstrates how to perform batch operations on meetings in HubSpot using the `ballerinax/hubspot.crm.engagement.meeting` connector.

## Prerequisites

- **Ballerina Swan Lake:** Install from [here](https://ballerina.io/downloads/).
- **HubSpot Developer Account:** Obtain API credentials (Client ID, Client Secret, Refresh Token).

## Setup

1. Create a `Config.toml` file with your HubSpot credentials:

    ```toml
    clientId = "<Your Client ID>"
    clientSecret = "<Your Client Secret>"
    refreshToken = "<Your Refresh Token>"
    serviceUrl = "<HubSpot API URL>"
    ```

2. Place the `Config.toml` file in the root directory of this example.

## Running the Example

Navigate to this example's directory and execute the following commands:

* To build the example:

    ```bash
    bal build
    ```

* To run the example:

    ```bash
    bal run
    ```

## Code Overview

This example demonstrates the following operations:

1. **Create a Meeting Batch**  
   A batch of meetings is created with specified properties and associations.

2. **Retrieve a Meeting Batch by ID**  
   Fetches details of the created meeting batch using its unique ID.

3. **Update a Meeting Batch**  
   Updates the scheduled date of the created meeting batch.

4. **Archive a Meeting Batch**  
   Archives the created meeting batch using its unique ID.

### Key Code Components

- **`meeting:Client`**: Initializes the client with OAuth2 credentials.
- **`create.post()`**: Creates a batch of meetings.
- **`read.post()`**: Retrieves details of the meeting batch.
- **`update.post()`**: Updates properties of the meeting batch.
- **`archive.post()`**: Archives the meeting batch.

## Dependencies

- `ballerina/io`
- `ballerina/oauth2`
- `ballerinax/hubspot.crm.engagement.meeting`

## Notes

- Ensure the `Config.toml` file is properly configured with your HubSpot API credentials.
- Ensure that the `serviceUrl` is set to the correct HubSpot API URL.
- This example assumes that the HubSpot meeting properties and associations are properly configured in your HubSpot account.

## License

Licensed under the Apache License 2.0. See [LICENSE](http://www.apache.org/licenses/LICENSE-2.0) for details.
