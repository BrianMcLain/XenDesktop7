## XD7StoreFrontRegisterStoreGateway

Register an authentication Gateway with a Store.

### Syntax

```
XD7StoreFrontRegisterStoreGateway [string]
{
    StoreName = [String]
    GatewayName = [String]
    AuthenticationProtocol[] = [String] { CitrixAGBasic | CitrixAGBasicNoPassword | HttpBasic | Certificate | CitrixFederation | IntegratedWindows | Forms-Saml | ExplicitForms }
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **StoreName**: Citrix StoreFront name.
* **GatewayName**: Gateway name.
* **AuthenticationProtocol[]**: Authentication Protocol.
* **Ensure**: Ensure.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontRegisterStoreGateway XD7StoreFrontRegisterStoreGatewayExample {
        GatewayName = 'Netscaler'
        StoreName = 'mock'
        AuthenticationProtocol = @('ExplicitForms','CitrixFederation','CitrixAGBasicNoPassword')
        Ensure = 'Present'
    }
}
```