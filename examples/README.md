# Examples

The `ballerinax/hubspot.crm.engagement.meeting` connector provides practical examples illustrating usage in various scenarios.

1. [Meeting_batch](./Meeting_batch/) - Manage batch of meeting 
2. [Meeting_for_contacts](./Meeting_for_contacts/) - Create update and archive meeting associated to a Contact  

## Prerequisites

- **Ballerina:** Download and install Ballerina from [here](https://ballerina.io/downloads/).
- **HubSpot developer account:** Create a HubSpot developer account and create an app to obtain the necessary credentials. Refer to the [Setup Guide](../ballerina/Package.md) for instructions.
- **`hubspot.crm.engagement.meeting` module:** Import the `ballerinax/hubspot.crm.engagement.meeting` module into your Ballerina project and configure it with the obtained credentials. Refer to the [Config.toml.template](./Meeting_batch/Config.toml.template) file for creating the `Config.toml` file.

```
import ballerinax/hubspot.crm.engagement.meeting as meeting;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string serviceUrl = ?;

meeting:OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

final meeting:Client meetingClient = check new ({auth});
```


## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
