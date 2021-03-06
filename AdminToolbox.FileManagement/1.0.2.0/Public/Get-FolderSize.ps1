function Get-FolderSize {
    <#
    .DESCRIPTION
    Quckly Finds the size of a path

    .Parameter Folder
    Folder that is being audited for size

    .Parameter ByteSize
    Measurement used for displaying the folder size

    .EXAMPLE
    Finds the size of the C:\users folder in MegaBytes

    Get-Foldersize -Folder c:\users\ -ByteSize MB

    .EXAMPLE
    Finds the size of the C:\users folder in GigaBytes

    Get-Foldersize -Folder c:\users\ -ByteSize GB

    .EXAMPLE
    Finds the size of the C:\users folder in MegaBytes

    Get-Foldersize -Folder c:\users\ -ByteSize TB
    #>

    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true)]$Folder,
        [Parameter(Position = 1)]$ByteSize
    )

    if ($ByteSize -eq 'MB') {
        "{0:N2} MB" -f ((Get-ChildItem $Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
    }
    elseif ($ByteSize -eq 'GB') {
        "{0:N2} GB" -f ((Get-ChildItem $Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1GB)
    }
    elseif ($ByteSize -eq 'TB') {
        "{0:N2} TB" -f ((Get-ChildItem $Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1TB)
    }
    else {
        "{0:N2} MB" -f ((Get-ChildItem $Folder -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
    }
}