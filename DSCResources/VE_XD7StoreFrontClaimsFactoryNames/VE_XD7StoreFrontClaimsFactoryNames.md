## XD7StoreFrontClaimsFactoryNames

Configures the claims factory names

### Syntax

```
XD7StoreFrontClaimsFactoryNames [string]
{
    ClaimsFactoryName = [String]
    VirtualPath = [String]
    SiteId = [Uint64]
}
```

### Properties

* **ClaimsFactoryName**: The name of the claims factory to use.
* **VirtualPath**: Citrix Storefront Authentication Service IIS Virtual Path.
* **SiteId**: Citrix Storefront Authentication Service IIS Site Id.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7
    XD7StoreFrontClaimsFactoryNames XD7StoreFrontClaimsFactoryNamesExample {
        ClaimsFactoryName = 'FASClaimsFactory'
        VirtualPath = '/Citrix/prodauth'
        SiteId = 1
    }
}
```
