<#
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.157
	 Created on:   	2/20/2020 12:12 PM
	 Created by:   	CERBDM
	 Organization:
	 Filename:     	VE_XD7StoreFrontStoreLaunchOptions.psm1
	-------------------------------------------------------------------------
	 Module Name: VE_XD7StoreFrontStoreLaunchOptions
	===========================================================================
	Notes:
		Skipped the following since they had issues
		AllowFontSmoothing (Wouldn't set), RDPOnly (No Get), IcaTemplateName (No Get)
#>


Import-LocalizedData -BindingVariable localizedData -FileName VE_XD7StoreFrontStoreLaunchOptions.Resources.psd1;

function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter()]
		[System.UInt64]
		$SiteId=1
	)

	Import-Module Citrix.StoreFront.Stores -ErrorAction Stop -Verbose:$false;
	$storeService = Get-STFStoreService -VirtualPath $VirtualPath -SiteId $SiteId
	$LaunchOptions = Get-STFStoreLaunchOptions -StoreService $storeservice

	$returnValue = @{
		VirtualPath = [System.String]$VirtualPath
		SiteId = [System.UInt64]$SiteId
		AddressResolutionType = [System.String]$LaunchOptions.AddressResolutionType
		RequestIcaClientSecureChannel = [System.String]$LaunchOptions.RequestIcaClientSecureChannel
		AllowSpecialFolderRedirection = [System.Boolean]$LaunchOptions.AllowSpecialFolderRedirection
		RequireLaunchReference = [System.Boolean]$LaunchOptions.RequireLaunchReference
		OverrideIcaClientName = [System.Boolean]$LaunchOptions.OverrideIcaClientName
		OverlayAutoLoginCredentialsWithTicket = [System.Boolean]$LaunchOptions.OverlayAutoLoginCredentialsWithTicket
		IgnoreClientProvidedClientAddress = [System.Boolean]$LaunchOptions.IgnoreClientProvidedClientAddress
		SetNoLoadBiasFlag = [System.Boolean]$LaunchOptions.SetNoLoadBiasFlag
		VdaLogonDataProvider = [System.String]$LaunchOptions.VdaLogonDataProviderName
	}

	$returnValue
}


function Set-TargetResource
{
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter()]
		[System.UInt64]
		$SiteId=1,

		[ValidateSet("Dns","DnsPort","Dot","DotPort","IPV4","IPV4Port","NoChange","Uri")]
		[System.String]
		$AddressResolutionType,

		[System.String]
		$RequestIcaClientSecureChannel,

		[System.Boolean]
		$AllowSpecialFolderRedirection,

		[System.Boolean]
		$RequireLaunchReference,

		[System.Boolean]
		$OverrideIcaClientName,

		[System.Boolean]
		$OverlayAutoLoginCredentialsWithTicket,

		[System.Boolean]
		$IgnoreClientProvidedClientAddress,

		[System.Boolean]
		$SetNoLoadBiasFlag,

		[System.String]
		$VdaLogonDataProvider
	)

	Import-Module Citrix.StoreFront.Stores -ErrorAction Stop -Verbose:$false;
	$storeService = Get-STFStoreService -VirtualPath $VirtualPath -SiteId $SiteId

    $ChangedParams = @{
        StoreService = $storeService
    }
    $targetResource = Get-TargetResource -SiteId $SiteId -VirtualPath $VirtualPath
    foreach ($property in $PSBoundParameters.Keys) {
        if ($targetResource.ContainsKey($property)) {
            $expected = $PSBoundParameters[$property];
            $actual = $targetResource[$property];
            if ($PSBoundParameters[$property] -is [System.String[]]) {
                if (Compare-Object -ReferenceObject $expected -DifferenceObject $actual) {
                    if (!($ChangedParams.ContainsKey($property))) {
                        Write-Verbose -Message ($localizedData.SettingResourceProperty -f $property)
                        $ChangedParams.Add($property, $PSBoundParameters[$property])
                    }
                }
            }
            elseif ($expected -ne $actual) {
                if (!($ChangedParams.ContainsKey($property))) {
                    Write-Verbose -Message ($localizedData.SettingResourceProperty -f $property)
                    $ChangedParams.Add($property, $PSBoundParameters[$property])
                }
            }
        }
    }

    Set-STFStoreLaunchOptions @ChangedParams

}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter()]
		[System.UInt64]
		$SiteId=1,

		[ValidateSet("Dns","DnsPort","Dot","DotPort","IPV4","IPV4Port","NoChange","Uri")]
		[System.String]
		$AddressResolutionType,

		[System.String]
		$RequestIcaClientSecureChannel,

		[System.Boolean]
		$AllowSpecialFolderRedirection,

		[System.Boolean]
		$RequireLaunchReference,

		[System.Boolean]
		$OverrideIcaClientName,

		[System.Boolean]
		$OverlayAutoLoginCredentialsWithTicket,

		[System.Boolean]
		$IgnoreClientProvidedClientAddress,

		[System.Boolean]
		$SetNoLoadBiasFlag,

		[System.String]
		$VdaLogonDataProvider
	)

	$targetResource = Get-TargetResource -SiteId $SiteId -VirtualPath $VirtualPath

    $inCompliance = $true;
    foreach ($property in $PSBoundParameters.Keys) {
        if ($targetResource.ContainsKey($property)) {
            $expected = $PSBoundParameters[$property];
            $actual = $targetResource[$property];
            if ($PSBoundParameters[$property] -is [System.String[]]) {
                if (Compare-Object -ReferenceObject $expected -DifferenceObject $actual) {
                    Write-Verbose ($localizedData.ResourcePropertyMismatch -f $property, ($expected -join ','), ($actual -join ','));
                    $inCompliance = $false;
                }
            }
            elseif ($expected -ne $actual) {
                Write-Verbose ($localizedData.ResourcePropertyMismatch -f $property, $expected, $actual);
                $inCompliance = $false;
            }
        }
    }

    if ($inCompliance) {
        Write-Verbose ($localizedData.ResourceInDesiredState -f $VirtualPath);
    }
    else {
        Write-Verbose ($localizedData.ResourceNotInDesiredState -f $VirtualPath);
    }

    return $inCompliance;

}


Export-ModuleMember -Function *-TargetResource

