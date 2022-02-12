<#		HIDE = 0,
			SHOWNORMAL = 1,
			SHOWMINIMIZED = 2,
			SHOWMAXIMIZED = 3,
			SHOWNOACTIVATE = 4,
			SHOW = 5,
			MINIMIZE = 6,
			SHOWMINNOACTIVE = 7,
			SHOWNA = 8,
			RESTORE = 9,
			SHOWDEFAULT = 10
#>

function Show-Process($Process, $Mode, [switch]$Foreground)
{
  $sig = '
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd);
  '    
  $type = Add-Type -MemberDefinition $sig -Name WindowAPI -PassThru
  $hwnd = $process.MainWindowHandle
  $null = $type::ShowWindowAsync($hwnd, $Mode)	
	
	if ($Foreground) {
    $null = $type::SetForegroundWindow($hwnd)
	}
}


#$CharArray=[array]$args.split('')
$CharArray= -split $args
#url di classicApp
$url=$CharArray[0]
Write-Host 'Url da lanciare $url '
#$CharArray = $CharArray[1..($CharArray.Length-1)]
$strarr=''
for ($i=1; $i -lt $CharArray.length; $i++) {
	$strarr=$strarr+' '+$CharArray[$i];
}
Write-Host $url $strarr

$application = Start-Process -FilePath $url -Argument $strarr -WindowStyle Minimized -PassThru

#usage 
Start-Sleep -Seconds 2
Show-Process -Process $application 1

Start-Sleep -Seconds 2
Show-Process -Process $application 2

Start-Sleep -Seconds 2
Show-Process -Process $application 3

Start-Sleep -Seconds 2
Show-Process -Process $application 4

Start-Sleep -Seconds 2
Show-Process -Process $application 5

Start-Sleep -Seconds 2
Show-Process -Process $application 6

Start-Sleep -Seconds 2
Show-Process -Process $application 7

Start-Sleep -Seconds 2
Show-Process -Process $application 8

Start-Sleep -Seconds 2
Show-Process -Process $application 9

Start-Sleep -Seconds 2
Show-Process -Process $application 10

#Usage
# powershell -ExecutionPolicy Bypass -File .\openApp.ps1
# powershell -ExecutionPolicy Bypass -File .\openApp.ps1 notepad.exe
