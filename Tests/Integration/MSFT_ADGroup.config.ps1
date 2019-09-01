#region HEADER
# Integration Test Config Template Version: 1.2.0
#endregion

$configFile = [System.IO.Path]::ChangeExtension($MyInvocation.MyCommand.Path, 'json')
if (Test-Path -Path $configFile)
{
    <#
        Allows reading the configuration data from a JSON file, for real testing
        scenarios outside of the CI.
    #>
    $ConfigurationData = Get-Content -Path $configFile | ConvertFrom-Json
}
else
{
    $currentDomain = Get-ADDomain
    $netBiosDomainName = $currentDomain.NetBIOSName

    $ConfigurationData = @{
        AllNodes = @(
            @{
                NodeName                = 'localhost'
                CertificateFile         = $env:DscPublicCertificatePath

                Group1_Name             = 'DscGroup1'

                Group2_Name             = 'DscGroup2'
                Group2_Scope            = 'Global'

                Group3_Name             = 'DscGroup3'
                Group3_Scope            = 'Universal'

                Group4_Name             = 'DscGroup4'
                Group4_Scope            = 'DomainLocal'

                Group5_Name             = 'DscDistributionGroup1'
                Group5_Scope            = 'Universal'
                Group5_Category         = 'Distribution'

                AdministratorUserName   = ('{0}\Administrator' -f $netBiosDomainName)
                AdministratorPassword   = 'P@ssw0rd1'
            }
        )
    }
}

<#
    .SYNOPSIS
        Add a group using default values.
#>
Configuration MSFT_ADGroup_CreateGroup1_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group1_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Add a global group using default values.
#>
Configuration MSFT_ADGroup_CreateGroup2_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group2_Name
            GroupScope = $Node.Group2_Scope

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Add a universal group using default values.
#>
Configuration MSFT_ADGroup_CreateGroup3_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group3_Name
            GroupScope = $Node.Group3_Scope

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Changes the category for an existing universal group.
#>
Configuration MSFT_ADGroup_ChangeCategoryGroup3_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group3_Name
            Category   = 'Distribution'

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Add a domain local group using default values.
#>
Configuration MSFT_ADGroup_CreateGroup4_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group4_Name
            GroupScope = $Node.Group4_Scope

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Change existing domain local group to global group.
#>
Configuration MSFT_ADGroup_ChangeScopeGroup4_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            Ensure     = 'Present'
            GroupName  = $Node.Group4_Name
            GroupScope = 'Global'

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Remove a group.
#>
Configuration MSFT_ADGroup_RemoveGroup1_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            Ensure     = 'Absent'
            GroupName  = $Node.Group1_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Restore a group from recycle bin.
#>
Configuration MSFT_ADGroup_RestoreGroup1_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            Ensure                = 'Present'
            GroupName             = $Node.Group1_Name
            RestoreFromRecycleBin = $true

            Credential            = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Update an existing group.
#>
Configuration MSFT_ADGroup_UpdateGroup1_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            Ensure                = 'Present'
            GroupName             = $Node.Group1_Name
            Path                  = 'CN=Computers,DC=contoso,DC=com'
            DisplayName           = 'DSC Group 1'
            Description           = 'A DSC description'
            Notes                 = 'Notes for this group'
            ManagedBy             = 'CN=Administrator,CN=Users,DC=contoso,DC=com'
            Members               = @(
                'Administrator',
                'Guest'
            )

            Credential            = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Add a universal distribution group with one member.
#>
Configuration MSFT_ADGroup_CreateGroup5_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group5_Name
            GroupScope = $Node.Group5_Scope
            Category   = $Node.Group5_Category

            Members    = @(
                'Administrator'
            )

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Add and remove members from a group.
#>
Configuration MSFT_ADGroup_ModifyMembersGroup5_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName        = $Node.Group5_Name

            MembersToInclude = @(
                'Guest'
            )

            MembersToExclude = @(
                'Administrator'
            )

            Credential       = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Enforce members in a group.
#>
Configuration MSFT_ADGroup_EnforceMembersGroup5_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'Integration_Test'
        {
            GroupName  = $Node.Group5_Name
            Members    = @(
                'Administrator'
                'Guest'
            )

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}

<#
    .SYNOPSIS
        Cleanup everything
#>
Configuration MSFT_ADGroup_Cleanup_Config
{
    Import-DscResource -ModuleName 'ActiveDirectoryDsc'

    node $AllNodes.NodeName
    {
        ADGroup 'RemoveGroup1'
        {
            Ensure     = 'Absent'
            GroupName  = $Node.Group1_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }

        ADGroup 'RemoveGroup2'
        {
            Ensure     = 'Absent'
            GroupName  = $Node.Group2_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }

        ADGroup 'RemoveGroup3'
        {
            Ensure     = 'Absent'
            GroupName  = $Node.Group3_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }

        ADGroup 'RemoveGroup4'
        {
            Ensure     = 'Absent'
            GroupName  = $Node.Group4_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }

        ADGroup 'RemoveGroup5'
        {
            Ensure     = 'Absent'
            GroupName  = $Node.Group5_Name

            Credential = New-Object `
                -TypeName System.Management.Automation.PSCredential `
                -ArgumentList @(
                $Node.AdministratorUserName,
                (ConvertTo-SecureString -String $Node.AdministratorPassword -AsPlainText -Force)
            )
        }
    }
}
