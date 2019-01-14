#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=MaxPayne_icon.ico
#AutoIt3Wrapper_Outfile=MaxPayne_Launcher.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UPX_Parameters=-9 --strip-relocs=0 --compress-exports=0 --compress-icons=0
#AutoIt3Wrapper_Res_Description=Max Payne Launcher
#AutoIt3Wrapper_Res_Fileversion=1.0.0.47
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.47
#AutoIt3Wrapper_Res_LegalCopyright=2014, SalFisher47
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_SaveSource=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Pragma Compile ****
#pragma compile(AutoItExecuteAllowed, true)
#pragma compile(Compression, 9)
#pragma compile(Compatibility, vista, win7, win8, win81, win10)
#pragma compile(InputBoxRes, true)
#pragma compile(CompanyName, 'SalFisher47')
#pragma compile(FileDescription, 'Max Payne Launcher')
#pragma compile(FileVersion, 1.0.0.47)
#pragma compile(InternalName, 'Max Payne Launcher')
#pragma compile(LegalCopyright, '2014, SalFisher47')
#pragma compile(OriginalFilename, MaxPayne_Launcher.exe)
#pragma compile(ProductName, 'Max Payne Launcher')
#pragma compile(ProductVersion, 1.0.0.47)
#EndRegion ;**** Pragma Compile ****
; === UniCrack Installer.au3 =======================================================================================================
; Title .........: Max Payne Launcher
; Version .......: 1.0.0.47
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Max Payne Widescreen Launcher
;				   - based on ThirteenAG's widescreen fix
; Author(s) .....: SalFisher47
; Last Modified .: January 02, 2019
; ==================================================================================================================================
$exe32bit = @ScriptDir & "\MaxPayne.exe"
$widescreen_fix_ini = @ScriptDir & "\scripts\MP1_widescreen_fix.ini"
$widescreen_fix_asi = @ScriptDir & "\scripts\MP1_widescreen_fix.asi"
$iniResX = IniRead($widescreen_fix_ini, "MAIN", "X", 0)
$iniResY = IniRead($widescreen_fix_ini, "MAIN", "Y", 0)
If ($iniResX == 0) And ($iniResY == 0) Then
	$iniResX = @DesktopWidth
	$iniResY = @DesktopHeight
ElseIf ($iniResX == 0) Or ($iniResY == 0) Then
	IniWrite($widescreen_fix_ini, "MAIN", "X", " 0")
	IniWrite($widescreen_fix_ini, "MAIN", "Y", " 0")
	$iniResX = @DesktopWidth
	$iniResY = @DesktopHeight
EndIf
$desktopX = $iniResX
$desktopY = $iniResY
$desktopRatio = Round($desktopX/$desktopY, 2)
$RunFirst = IniRead(@ScriptDir & "\MaxPayne_Launcher.ini", "GAME", "RunFirst", 0)
$cracked = IniRead($widescreen_fix_ini, "EXE", "cracked", "0")
DirCreate(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher")
FileInstall("MaxPayne_ProgramData.ini", @AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", 0)
If Not FileExists(@AppDataCommonDir & "\SalFisher47\RunFirst") Then DirCreate(@AppDataCommonDir & "\SalFisher47\RunFirst")
FileInstall("RunFirst\RunFirst.exe", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", 0)
FileInstall("RunFirst\RunFirst.txt", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.txt", 0)
$cracked_ProgramData = IniRead(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", 0)
$CustomizedGame_Bonus = "Bonus Dead Man Walking Chapters"
If Not FileExists($exe32bit) Then
	MsgBox(16, "Max Payne Launcher", "Executable not found:" & @CRLF & "..\MaxPayne.exe")
	Exit
EndIf
Switch $desktopRatio
	Case 1.33   ; 4:3 aspect ratio, 1024x768
		If not FileExists($widescreen_fix_ini) Then
			DirCreate(@ScriptDir & "\scripts")
			FileInstall("d3d8.dll", @ScriptDir & "\d3d8.dll", 0)
			FileInstall("scripts\MP1_widescreen_fix.ini", $widescreen_fix_ini, 0)
			FileInstall("scripts\MP1_widescreen_fix.asi", $widescreen_fix_asi, 0)
		EndIf
		$CustomizedGame_Bonus = ""
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Customized Game", "Customized Game", "REG_SZ", $CustomizedGame_Bonus)
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Bits Per Pixel", "REG_DWORD", Binary(32))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Height", "REG_DWORD", Binary($desktopY))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Width", "REG_DWORD", Binary($desktopX))
		If $cracked == 1 Then
			If $cracked_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
				IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
			IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf
	Case 1.25   ; 5:4 aspect ratio, 1280x1024
		If not FileExists($widescreen_fix_ini) Then
			DirCreate(@ScriptDir & "\scripts")
			FileInstall("d3d8.dll", @ScriptDir & "\d3d8.dll", 0)
			FileInstall("scripts\MP1_widescreen_fix.ini", $widescreen_fix_ini, 0)
			FileInstall("scripts\MP1_widescreen_fix.asi", $widescreen_fix_asi, 0)
		EndIf
		$CustomizedGame_Bonus = ""
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Customized Game", "Customized Game", "REG_SZ", $CustomizedGame_Bonus)
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Bits Per Pixel", "REG_DWORD", Binary(32))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Height", "REG_DWORD", Binary($desktopY))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Width", "REG_DWORD", Binary($desktopX))
		If $cracked == 1 Then
			If $cracked_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
				IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
			IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf
	Case 1.77   ; 16:9 aspect ratio, 1360x768
		If not FileExists($widescreen_fix_ini) Then
			DirCreate(@ScriptDir & "\scripts")
			FileInstall("d3d8.dll", @ScriptDir & "\d3d8.dll", 0)
			FileInstall("scripts\MP1_widescreen_fix.ini", $widescreen_fix_ini, 0)
			FileInstall("scripts\MP1_widescreen_fix.asi", $widescreen_fix_asi, 0)
		EndIf
		$CustomizedGame_Bonus = "Widescreen HUD"
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Customized Game", "Customized Game", "REG_SZ", $CustomizedGame_Bonus)
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Bits Per Pixel", "REG_DWORD", Binary(32))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Height", "REG_DWORD", Binary($desktopY))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Width", "REG_DWORD", Binary($desktopX))
		If $cracked == 1 Then
			If $cracked_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
				IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
			IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf
	Case 1.78   ; 16:9 aspect ratio, 1366x768
		If not FileExists($widescreen_fix_ini) Then
			DirCreate(@ScriptDir & "\scripts")
			FileInstall("d3d8.dll", @ScriptDir & "\d3d8.dll", 0)
			FileInstall("scripts\MP1_widescreen_fix.ini", $widescreen_fix_ini, 0)
			FileInstall("scripts\MP1_widescreen_fix.asi", $widescreen_fix_asi, 0)
		EndIf
		$CustomizedGame_Bonus = "Widescreen HUD"
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Customized Game", "Customized Game", "REG_SZ", $CustomizedGame_Bonus)
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Bits Per Pixel", "REG_DWORD", Binary(32))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Height", "REG_DWORD", Binary($desktopY))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Width", "REG_DWORD", Binary($desktopX))
		If $cracked == 1 Then
			If $cracked_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
				IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
			IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf
	Case 1.60   ; 16:10 aspect ratio, 1440x900
		If not FileExists($widescreen_fix_ini) Then
			DirCreate(@ScriptDir & "\scripts")
			FileInstall("d3d8.dll", @ScriptDir & "\d3d8.dll", 0)
			FileInstall("scripts\MP1_widescreen_fix.ini", $widescreen_fix_ini, 0)
			FileInstall("scripts\MP1_widescreen_fix.asi", $widescreen_fix_asi, 0)
		EndIf
		$CustomizedGame_Bonus = "Widescreen HUD"
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Customized Game", "Customized Game", "REG_SZ", $CustomizedGame_Bonus)
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Bits Per Pixel", "REG_DWORD", Binary(32))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Height", "REG_DWORD", Binary($desktopY))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Width", "REG_DWORD", Binary($desktopX))
		If $cracked == 1 Then
			If $cracked_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
				IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
			IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf
	Case Else   ; other aspect ratio
		If not FileExists($widescreen_fix_ini) Then
			DirCreate(@ScriptDir & "\scripts")
			FileInstall("d3d8.dll", @ScriptDir & "\d3d8.dll", 0)
			FileInstall("scripts\MP1_widescreen_fix.ini", $widescreen_fix_ini, 0)
			FileInstall("scripts\MP1_widescreen_fix.asi", $widescreen_fix_asi, 0)
		EndIf
		$CustomizedGame_Bonus = ""
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Customized Game", "Customized Game", "REG_SZ", $CustomizedGame_Bonus)
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Bits Per Pixel", "REG_DWORD", Binary(32))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Height", "REG_DWORD", Binary($desktopY))
		RegWrite("HKCU\Software\Remedy Entertainment\Max Payne\Video Settings", "Display Width", "REG_DWORD", Binary($desktopX))
		If $cracked == 1 Then
			If $cracked_ProgramData == 1 Then
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			Else
				FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
				IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
				IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
				If $RunFirst == 1 Then
					ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
				Else
					ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
				EndIf
			EndIf
		Else
			FileInstall("MaxPayne.exe", @ScriptDir & "\MaxPayne.exe", 1)
			IniWrite($widescreen_fix_ini, "EXE", "cracked", " 1")
			IniWrite(@AppDataCommonDir & "\SalFisher47\WidescreenLauncher\MaxPayne1.ini", "EXE", "cracked", " 1")
			If $RunFirst == 1 Then
				ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe32bit & '"' & " " & $CmdLineRaw, @ScriptDir, "", @SW_HIDE)
			Else
				ShellExecute($exe32bit, " " & $CmdLineRaw, @ScriptDir)
			EndIf
		EndIf
EndSwitch