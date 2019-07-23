<#PSScriptInfo
.VERSION 1.0
.GUID 96b94fc3-2b96-47b7-82e8-d0551ec2e738
.AUTHOR Microsoft Corporation
.COMPANYNAME Microsoft Corporation
.COPYRIGHT (c) Microsoft Corporation. All rights reserved.
.TAGS DSCConfiguration
.LICENSEURI https://github.com/PowerShell/ActiveDirectoryDsc/blob/master/LICENSE
.PROJECTURI https://github.com/PowerShell/ActiveDirectoryDsc
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
.PRIVATEDATA
#>

#Requires -module ActiveDirectoryDsc

<#
    .DESCRIPTION
        This configuration will set an Active Directory domain's default password
        policy to set the minimum password length and complexity.
#>

Configuration ConfigureDefaultPasswordPolicy_Config
{
    Param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $DomainName,

        [parameter(Mandatory = $true)]
        [System.Boolean]
        $ComplexityEnabled,

        [parameter(Mandatory = $true)]
        [System.Int32]
        $MinPasswordLength
    )

    Import-DscResource -Module ActiveDirectoryDsc

    Node localhost
    {
        ADDomainDefaultPasswordPolicy 'DefaultPasswordPolicy'
        {
            DomainName        = $DomainName
            ComplexityEnabled = $ComplexityEnabled
            MinPasswordLength = $MinPasswordLength
        }
    }
}
