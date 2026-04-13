curl https://ninite.com/chrome/ninite.exe -o chrome_ninite.exe
start chrome_ninite.exe
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f 
taskkill /F /IM explorer.exe 
start explorer.exe 
#echo "127.0.0.1		bing.com " >> c:\windows\system32\drivers\etc\hosts
#echo "127.0.0.1		www.bing.com " >> c:\windows\system32\drivers\etc\hosts

# Disable Windows AI/Recall features (CurrentUser + Machine)
$keys = @{
    'HKCU:\Software\Policies\Microsoft\Windows\WindowsAI' = @{ 'DisableAIDataAnalysis' = 1 }
    'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI' = @{
        'DisableAIDataAnalysis' = 1
        'AllowRecallEnablement' = 0
        'TurnOffSavingSnapshots' = 1
    }
}

foreach ($path in $keys.Keys) {
    $null = New-Item -Path $path -Force -EA SilentlyContinue
    foreach ($name in $keys[$path].Keys) {
        Set-ItemProperty -Path $path -Name $name -Value $keys[$path][$name] -Type DWord -Force
    }
}

Write-Host "Windows AI/Recall policies applied."
# Open the Debloater dialogue
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
#  add this to the line above "-CreateRestorePoint -Silent -SysPrep -Config <path> (do not include <>)

