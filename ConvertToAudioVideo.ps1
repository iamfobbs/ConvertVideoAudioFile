###################################################################################################
# CONVERTING YOUR AUDIO OR VIDEO FILES USING POWERSHELL AND A THIRD PARTY COMPONENT CALLLED FFMPEG.
## Note: FFMPEG allows for a lot of flexibily with regards to the output of your given file.
# Resolution can be set etc.
#
# Refer to link for more details if required otherwise simply change $path $from $_.Extention and location of your $ffmpeg.

#Set the path to crawl
$path = 'D:\Dio\Videos\Test'
#The source or input file format
$from = '.mkv'
#The encoding bit rate
$rate = '192k'
Get-ChildItem -Path:$path -Include:"*$from" -Recurse | ForEach-Object -Process: { 
        $file = $_.Name.Replace($_.Extension,'.avi')
        $input = $_.FullName
        $output = $_.DirectoryName
        $output = "$output\$file"
#-i Input file path
#-id3v2_version Force id3 version so windows can see id3 tags
#-f Format is MP3
#-ab Bit rate
#-ar Frequency
# Output file path
#-y Overwrite the destination file without confirmation
        $arguments = "-i `"$input`" -id3v2_version 3 -f mp3 -ab $rate -ar 44100 `"$output`" -y"
        $ffmpeg = "D:\Projects\ConvertVideoAudioFile\FFMPEGx64\bin\ffmpeg.exe"
        Invoke-Expression "$ffmpeg $arguments"
        Write-Host "$file converted to $output"
#Delete the old file when finished
#This could use some error checking around it to prevent accidental deletion.
        #Remove-Item -Path:$_
    }