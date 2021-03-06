function Start-BurnSubtitles {
    <#
    .DESCRIPTION
    Burn subtitles from an srt file. 

    .PARAMETER Video
    Specify Video Input

    .PARAMETER Transcode
    Specify if the video should also be transcoded

    .PARAMETER SrtFile
    Specify an srt file for use with the Srt parameter set

    .Example
    If the transcode switch parameter is used then the file will be transcoded in addition to the subtitles being burned.

    Start-BurnSubtitles -Movie "Action Jackson.mkv" -srtfile "Action Jackson.srt" -Transcode
    #>
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        $video,
        [Parameter(Mandatory = $False)]
        [Switch]
        $transcode,
        [Parameter(Mandatory = $true)]$srtfile
    )

    if ($env:FFToolsSource -and $env:FFToolsTarget) {
        #Change directory to the source folder
        Set-Location $env:FFToolsSource

        #Split variable to only provide the file name
        $videosplit = ($video).Split('\')[-1]
        $srtfilesplit = ($srtfile).Split('\')[-1]

        #execute subtitle burn
        if ($transcode) {
            ffmpeg.exe -i "$videosplit" -vf "subtitles=$srtfilesplit" -c:v libx265 -crf 21 -ac 6 -c:a aac -preset veryfast  "$env:FFToolsTarget$video"
        }

        else {
                ffmpeg.exe -i "$videosplit" -vf "subtitles=$srtfilesplit" "$env:FFToolsTarget$video"
        }
    }

    else {
        Write-Warning "You must first run Set-FFToolsVariables! This is only required once."
    }
}