## XD7StoreFrontStoreLaunchOptions

Configure options used by a Store when launching an application or desktop on XenApp and XenDesktop

### Syntax

```
XD7StoreFrontStoreLaunchOptions [string]
{
    VirtualPath = [String]
    SiteId = [Uint64]
    [ AddressResolutionType = [String] { Dns | DnsPort | Dot | DotPort | IPV4 | IPV4Port | NoChange | Uri } ]
    [ RequestIcaClientSecureChannel = [String] ]
    [ AllowSpecialFolderRedirection = [Boolean] ]
    [ RequireLaunchReference = [Boolean] ]
    [ OverrideIcaClientName = [Boolean] ]
    [ OverlayAutoLoginCredentialsWithTicket = [Boolean] ]
    [ IgnoreClientProvidedClientAddress = [Boolean] ]
    [ SetNoLoadBiasFlag = [Boolean] ]
    [ VdaLogonDataProvider = [String] ]
}
```

### Properties

* **VirtualPath**: Citrix Storefront Store Service IIS Virtual Path.
* **SiteId**: Citrix Storefront Store Service IIS Site Id.
* **AddressResolutionType**: Specifies the type of address to use in the .ica launch file.
* **RequestIcaClientSecureChannel**: Specifies TLS settings.
* **AllowSpecialFolderRedirection**: Redirect special folders such as Documents, Computer and the Desktop.
* **RequireLaunchReference**: Specifies whether or not the use of launch references is enforced.
* **OverrideIcaClientName**: Specifies whether or not a Web Interface-generated ID must be passed in the clientname entry of an .ica launch file.
* **OverlayAutoLoginCredentialsWithTicket**: Specifies whether a logon ticket must be duplicated in a logon ticket entry or placed in a separate .ica launch file ticket entry only.
* **IgnoreClientProvidedClientAddress**: Specifies whether or not to ignore the address provided by the Citrix client.
* **SetNoLoadBiasFlag**: Specifies whether XenApp load bias should be used.
* **VdaLogonDataProvider**: The Vda logon data provider to use during launch.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7
    XD7StoreFrontStoreLaunchOptions XD7StoreFrontStoreLaunchOptionsExample {
        VirtualPath = "/Citrix/prod"
        SiteID = 1
        VdaLogonDataProvider = "FASLogonDataProvider"
    }
}
```
