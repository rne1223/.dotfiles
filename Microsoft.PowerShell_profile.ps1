set-alias k -value kubectl
set-psreadlineoption -editmode vi
set-psreadlineoption -bellstyle none
#$Env:PATH += ";$pwd"

import-module posh-git
import-module oh-my-posh

oh-my-posh --init --shell pwsh --config "$(scoop prefix oh-my-posh3)\themes\jandedobbeleer.omp.json" | Invoke-Expression

# New-Alias "hfcli" huggingface-cli
# New-Alias -Name s -Value { Start-Process -NoNewWindow @args } -Force

function usp {
	$exec = "$(Set-Location 'C:\Users\rne1223\projects\unreal'; fd -e uproject -L | fzf)"

    if (!$exec) {
        Write-Output "Please select an Unreal Project"  -ForegroundColor Red
        return        
    }

    # Run the project
	Start-Process $exec

	# Extract the directory path 
	$directoryPath = Split-Path -Path $exec
    # CD to Project Directory
	Set-Location $directoryPath
}

# https://stackoverflow.com/questions/57318124/getting-pid-from-within-a-start-job

#$mpId = Start-Job -Name musicPlayer -ScriptBlock {
#	(Start-Process "C:\Users\rne1223\scoop\shims\mpv.exe" -PassThru -ArgumentList "--playlist='C:\Users\rne1223\playlist' --no-video --volume=50").Id
#}

#########################
### Alias  ##############
#########################

function Get-PlaylistLink($csv = "C:\Users\rne1223\playlist"){
   $csvData = Import-Csv -Path $csv 

    $firstColumnHeader = ($csvData | Get-Member -MemberType NoteProperty).Name[0]
    # Select the first column by its header
    $firstColumn = $csvData | Select-Object -ExpandProperty $firstColumnHeader
    # Output the first column's data
    $test = $firstColumn | fzf

    # Access column data using the column header as the property name
    foreach ($row in $csvData) {
        if ($row.song_name -eq $test) {
            return $row.url 
        }
    }
}

function playm($Volume = "50")
{
	#Start-Job -ScriptBlock { C:\Users\rne1223\scoop\shims\mpv.exe --playlist='C:\Users\rne1223\playlist' --no-video --volume=30}
	C:\Users\rne1223\scoop\shims\mpv.exe --no-video --volume=30 "$(Get-PlaylistLink)"
}

function kills(){
	stop-process -Name "$(get-process | fzf | awk '{ print $NF}')"
}


function newshim {
    param(
	[string]$name,
        [string]$filepath
    )
    New-Item -Path "$name.shim" -Value "path = $filepath"
    Copy-Item -Path "C:\Users\rne1223\scoop\apps\scoop-shim\current\shim.exe" -Destination "$name.exe" 
	Move-Item -Path "$name.*" -Destination "C:\Users\rne1223\scoop\shims"


    Write-Output "done" 
}

function updateVscode ($zipFilePath) {
	$codePath = "C:\Users\rne1223\scoop\apps\vscode"
	Move-Item -Path ./$zipFilePath -Destination $codePath/$zipFilePath
    Set-Location $codePath
    # Define the regex pattern for extracting the version number
    $pattern = '\d+(\.\d+)+'

    # Use regex to find the first match in the input string
    $match = [regex]::Match($zipFilePath, $pattern)

    #Check if a match is found
    if ($match.Success) {
        # Extract and output the matched value
        $versionNumber = $match.Value
        Expand-Archive -Path $zipFilePath -DestinationPath "./$versionNumber" -Force
    } else {
        Write-Host "Version number not found in the input string."
    }

    Move-Item -Path "./current" "current_old"
    sudo ln -s $versionNumber current
    Remove-Item current_old
}

# Function to be use with fd to find files with a time input 
function fdt([string]$time="1hour"){

	#$currentTime = Get-Date 
	#$elapsedTime = $currentTime.AddHours(-$time) ## Subtract the value of $lapsed from $currentTime
	#$finalTime= $elapsedTime.ToString("yyyy-MM-dd") 
	fd -d 1 --newer "$time"
} 

function cb (){
	$filepath = Get-Location | set-clipboard
	return $filepath
} 

function cbf ($file) {

    process {
        $inputValue = $_
        Write-Host "Processing: $inputValue"
    }
	
}

function dar() {
    Start-Process "D:\Videos\DavinciProjects\Project.drb"
}




#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
 If (Test-Path "C:\Users\rne1223\scoop\apps\miniconda3\current\Scripts\conda.exe") {
     (& "C:\Users\rne1223\scoop\apps\miniconda3\current\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Where-Object {$_} | Invoke-Expression
     }
#     #endregion

. $(pack completion --shell powershell)
