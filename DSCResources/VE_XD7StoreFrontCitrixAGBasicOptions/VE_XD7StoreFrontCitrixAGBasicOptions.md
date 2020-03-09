## XD7StoreFrontCitrixAGBasicOptions

Configure CitrixAGBasic protocol options

### Syntax

```
XD7StoreFrontCitrixAGBasicOptions [string]
{
    VirtualPath = [String]
    SiteId = [Uint64]
    [ CredentialValidationMode = [String] { Password | Kerberos | Auto } ]
}
```

### Properties

* **VirtualPath**: Citrix Storefront Authentication Service IIS Virtual Path.
* **SiteId**: Citrix Storefront Autentication Service IIS Site Id.
* **CredentialValidationMode**: Specifies the credential validation mode to use for authentication.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontCitrixAGBasicOptions XD7StoreFrontCitrixAGBasicOptionsExample {
        CredentialValidationMode = 'Kerberos'
        VirtualPath = '/Citrix/prodauth'
        SiteId = 1
    }
}
```
