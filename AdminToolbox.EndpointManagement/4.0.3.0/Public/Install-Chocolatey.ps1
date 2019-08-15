function Install-Chocolatey {
    <#
    .DESCRIPTION
    Installs Chocolatey

    .EXAMPLE
    Install-Chocolatey

    .Link
    Get-ChocoInstalls
    Get-ChocoOutdated
    Install-ChocoPackages
    Invoke-ChocoUpgrade
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute( `
            "PSAvoidUsingInvokeExpression", `
            "", `
            Justification = "Using Chocolatey-provided call")]
    param()

    $ErrorActionPreference = 'SilentlyContinue'

    try {
        choco.exe -v | Out-Null
        Write-Host 'Chocolatey already installed.' -ForegroundColor Green
        return
    }
    catch {
        #Check for Admin Privleges
        Get-Elevation

        #Install Chocolatey
        $downloadUrl = 'https://chocolatey.org/install.ps1'
        Write-Output 'Installing Chocolatey...'
        Set-ExecutionPolicy Bypass -Scope Process -Force; `
            Invoke-Expression `
        ((New-Object System.Net.WebClient).DownloadString($downloadUrl))
    }
}