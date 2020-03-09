<#
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.157
	 Created on:   	2/20/2020 12:12 PM
	 Created by:   	CERBDM
	 Organization:
	 Filename:     	VE_XD7StoreFrontClaimsFactoryNames.psm1
	-------------------------------------------------------------------------
	 Module Name: VE_XD7StoreFrontClaimsFactoryNames
	===========================================================================
#>


Import-LocalizedData -BindingVariable localizedData -FileName VE_XD7StoreFrontClaimsFactoryNames.Resources.psd1;

function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$ClaimsFactoryName,

		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter()]
		[System.UInt64]
		$SiteId=1
	)

	Import-Module Citrix.StoreFront.Authentication -ErrorAction Stop -Verbose:$false;
	$authenticationService = Get-STFAuthenticationService -VirtualPath $VirtualPath -SiteId $SiteId

	Import-module WebAdministration -ErrorAction Stop -Verbose:$false;
	$IISPath = Get-WebApplication | Where-Object {$_.Path -eq $VirtualPath} | Select-Object -ExpandProperty PhysicalPath
	[xml]$xmlcontent = get-content "$IISPath\web.config"
	$ClaimsFactoryValue = $xmlcontent.configuration."citrix.deliveryservices".certificateAuthentication.routeTable.routes.route.defaults.add | Where-Object {$_.param -eq "claimsFactoryName"} | select-object -ExpandProperty Value


	$returnValue = @{
		VirtualPath = $VirtualPath
		SiteId = $SiteId
		ClaimsFactoryName = [System.String]$ClaimsFactoryValue
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
		$ClaimsFactoryName,

		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter()]
		[System.UInt64]
		$SiteId=1
	)

	Import-Module Citrix.StoreFront.Authentication -ErrorAction Stop -Verbose:$false;
	$authenticationService = Get-STFAuthenticationService -VirtualPath $VirtualPath -SiteId $SiteId
	Set-STFClaimsFactoryNames -AuthenticationService $authenticationService -ClaimsFactoryName $ClaimsFactoryName

}


function Test-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$ClaimsFactoryName,

		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter()]
		[System.UInt64]
		$SiteId=1
	)

	$targetResource = Get-TargetResource @PSBoundParameters;

	if ($ClaimsFactoryName -eq $targetResource.ClaimsFactoryName) {
		Write-Verbose ($localizedData.ResourceInDesiredState -f $VirtualPath);
		return $true;
	}
	else {
		Write-Verbose ($localizedData.ResourcePropertyMismatch -f 'ClaimsFactoryName', $ClaimsFactoryName, $targetResource.ClaimsFactoryName);
		Write-Verbose ($localizedData.ResourceNotInDesiredState -f $VirtualPath);
		return $false;
	}

}


Export-ModuleMember -Function *-TargetResource

