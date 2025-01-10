# Meeting_for_contacts Example for HubSpot Meetings

This Ballerina example demonstrates how to create, retrieve, update, list, and delete meetings associated with a specific contact in HubSpot using the `ballerinax/hubspot.crm.engagement.meeting` connector.

## Prerequisites

- **Ballerina Swan Lake:** Install from [here](https://ballerina.io/downloads/).
- **HubSpot Developer Account:** Obtain API credentials (Client ID, Client Secret, Refresh Token).
- **Contact ID:** Ensure you have a valid contact ID from HubSpot.

## Setup

1. Create a `Config.toml` file with your HubSpot credentials and the contact ID:

    ```toml
    clientId = "<Your Client ID>"
    clientSecret = "<Your Client Secret>"
    refreshToken = "<Your Refresh Token>"
    contactId = "<Contact ID>"
    ```

2. Place the `Config.toml` in the root directory of this example.

## Running the Example

Navigate to this example's directory and execute:

* To build the example:

    ```bash
    bal build
    ```

* To run the example:

    ```bash
    bal run
    ```

## Code Overview

- **`main()`:** Initializes the HubSpot client and demonstrates various meeting operations for a specific contact.
  - Creates a meeting associated with a contact.
  - Retrieves the created meeting by its ID.
  - Updates the meeting's title and scheduled date.
  - Lists all meetings associated with the contact.
  - Deletes the created meeting.

## Dependencies

- `ballerina/io`
- `ballerina/oauth2`
- `ballerinax/hubspot.crm.engagement.meeting`

## Notes

- Ensure the `Config.toml` file is properly configured with your HubSpot API credentials and a valid contact ID.
- Dependencies should be set up in your project.

## License

Licensed under the Apache License 2.0. See [LICENSE](http://www.apache.org/licenses/LICENSE-2.0) for details.