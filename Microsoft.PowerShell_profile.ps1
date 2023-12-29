set-alias k -value kubectl
set-psreadlineoption -editmode vi
set-psreadlineoption -bellstyle none
#$Env:PATH += ";$pwd"

import-module posh-git
import-module oh-my-posh

oh-my-posh --init --shell pwsh --config "$(scoop prefix oh-my-posh3)\themes\jandedobbeleer.omp.json" | Invoke-Expression

New-Alias "hfcli" huggingface-cli
# New-Alias -Name s -Value { Start-Process -NoNewWindow @args } -Force

function usp {
	start "$(cd 'C:\Users\rne1223\projects\unreal'; fd -e uproject | fzf)"
}

# https://stackoverflow.com/questions/57318124/getting-pid-from-within-a-start-job

#$mpId = Start-Job -Name musicPlayer -ScriptBlock {
#	(Start-Process "C:\Users\rne1223\scoop\shims\mpv.exe" -PassThru -ArgumentList "--playlist='C:\Users\rne1223\playlist' --no-video --volume=50").Id
#}

function playm($Volume = "50")
{
	#Start-Job -ScriptBlock { C:\Users\rne1223\scoop\shims\mpv.exe --playlist='C:\Users\rne1223\playlist' --no-video --volume=30}
	C:\Users\rne1223\scoop\shims\mpv.exe --no-video --volume=30 "$(cat C:\Users\rne1223\playlist | fzf)" 
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

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
 If (Test-Path "C:\Users\rne1223\scoop\apps\miniconda3\current\Scripts\conda.exe") {
     (& "C:\Users\rne1223\scoop\apps\miniconda3\current\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
     }
#     #endregion

. $(pack completion --shell powershell)
