<#
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.157
	 Created on:   	3/09/2020 6:03 PM
	 Created by:   	CERBDM
	 Organization:
	 Filename:     	VE_XD7StoreFrontCitrixAGBasicOptions.psm1
	-------------------------------------------------------------------------
	 Module Name: VE_XD7StoreFrontCitrixAGBasicOptions
	===========================================================================
#>


Import-LocalizedData -BindingVariable localizedData -FileName VE_XD7StoreFrontCitrixAGBasicOptions.Resources.psd1;

function Get-TargetResource
{
	[CmdletBinding()]
	[OutputType([System.Collections.Hashtable])]
	param
	(
		[parameter(Mandatory = $true)]
		[System.String]
		$VirtualPath,

		[parameter(Mandatory = $true)]
		[System.UInt64]
		$SiteId
	)

	Import-Module Citrix.StoreFront.Authentication -ErrorAction Stop -Verbose:$false;
	$authenticationService = Get-STFAuthenticationService -VirtualPath $VirtualPath -SiteId $SiteId
	$CredentialValidationModeValue = Get-STFCitrixAGBasicOptions -AuthenticationService $authenticationService | Select-Object -ExpandProperty CredentialValidationMode

	$returnValue = @{
		VirtualPath = $VirtualPath
		SiteId = $SiteId
		CredentialValidationMode = [System.String]$CredentialValidationModeValue
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

		[parameter(Mandatory = $true)]
		[System.UInt64]
		$SiteId,

		[ValidateSet("Password","Kerberos","Auto")]
		[System.String]
		$CredentialValidationMode
	)

	Import-Module Citrix.StoreFront.Authentication -ErrorAction Stop -Verbose:$false;
	$authenticationService = Get-STFAuthenticationService -VirtualPath $VirtualPath -SiteId $SiteId
	Write-Verbose ($localizedData.SettingResourceProperty -f 'CredentialValidationMode');
	Set-STFCitrixAGBasicOptions -AuthenticationService $authenticationService -CredentialValidationMode $CredentialValidationMode

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

		[parameter(Mandatory = $true)]
		[System.UInt64]
		$SiteId,

		[ValidateSet("Password","Kerberos","Auto")]
		[System.String]
		$CredentialValidationMode
	)

	$targetResource = Get-TargetResource @PSBoundParameters;

	if ($CredentialValidationMode -eq $targetResource.CredentialValidationMode) {
		Write-Verbose ($localizedData.ResourceInDesiredState -f $VirtualPath);
		return $true;
	}
	else {
		Write-Verbose ($localizedData.ResourcePropertyMismatch -f 'CredentialValidationMode', $CredentialValidationMode, $targetResource.CredentialValidationMode);
		Write-Verbose ($localizedData.ResourceNotInDesiredState -f $VirtualPath);
		return $false;
	}
}


Export-ModuleMember -Function *-TargetResource

