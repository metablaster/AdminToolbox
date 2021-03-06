function Enable-RSATFeatures {
    <#
    .DESCRIPTION
    Enables Remote Server Administration Tools On Windows 10 PC's.
    #>

    #Check for Admin Privleges
    Get-Elevation

    #Install RSAT Features
    Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online

    #Upate the help after
    Update-Help
}