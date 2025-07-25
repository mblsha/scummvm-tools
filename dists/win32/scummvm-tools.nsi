# ScummVM Tools
#
# ScummVM Tools is the legal property of its developers, whose names
# are too numerous to list here. Please refer to the COPYRIGHT
# file distributed with this source distribution.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#!define _DEBUG

Name "ScummVM Tools"

# Included files
!include MUI2.nsh

#########################################################################################
# Command line options
#########################################################################################

#!define top_srcdir   ""
#!define build_dir    ""
#!define text_dir     ""
#!define ARCH         ""    ;(optional, defaults to win32)

# Check parameters
!ifndef top_srcdir
	!error "Top source folder has not been passed to command line!"
!endif

!ifndef build_dir
	!error "Build folder has not been passed to command line (this folder should contain the executable and linked DLLs)!"
!endif

!ifndef text_dir
	!error "Text folder has not been passed to command line (this folder should contain all the text files used by the installer)!"
!endif

!ifndef ARCH
	!warning "ARCH has not been defined, defaulting to 'win32'"
	!define ARCH         "win32"
!endif

#########################################################################################
# Folders
#########################################################################################
!define media_dir  "${top_srcdir}\gui\media"

#########################################################################################
# General Symbol Definitions
#########################################################################################
!define REGKEY      "Software\ScummVM\$(^Name)"
!define VERSION     "2.10.0git"
!define COMPANY     "ScummVM Team"
!define URL         "https://www.scummvm.org/"
!define DESCRIPTION "ScummVM Tools Installer. Look! A three headed monkey (TM)!"
!define COPYRIGHT   "Copyright � 2001-2025 The ScummVM Team"

#########################################################################################
# Installer configuration
#########################################################################################
OutFile          ${build_dir}\scummvm-tools-${VERSION}-${ARCH}.exe
InstallDir       $PROGRAMFILES\ScummVM\tools                             ; Default installation folder
InstallDirRegKey HKCU "Software\ScummVM\ScummVM Tools" "InstallPath"    ; Get installation folder from registry if available
                                                                        ; The application name needs to be refered directly instead of through ${REGKEY}
                                                                        ; because lang strings aren't initialized at the point InstallDirRegKey is called

CRCCheck on
XPStyle  on
#TargetMinimalOS 5.0    ; Minimal version of windows for installer: Windows 2000 or more recent
                        ; (will build unicode installer with NSIS 2.50+)

VIProductVersion 2.10.0.0
VIAddVersionKey  ProductName      $(^Name)
VIAddVersionKey  ProductVersion  "${VERSION}"
VIAddVersionKey  CompanyName     "${COMPANY}"
VIAddVersionKey  CompanyWebsite  "${URL}"
VIAddVersionKey  FileVersion     "${VERSION}"
VIAddVersionKey  FileDescription "${DESCRIPTION}"
VIAddVersionKey  LegalCopyright  "${COPYRIGHT}"

BrandingText "$(^Name) ${VERSION}"   ; Change branding text on the installer to show our name and version instead of NSIS's

# Show Details when installing/uninstalling files
ShowInstDetails   show
ShowUninstDetails show

!ifdef _DEBUG
	SetCompress off                      ; for debugging the installer, lzma takes forever
	RequestExecutionLevel user
!else
	SetCompressor /FINAL /SOLID lzma
	SetCompressorDictSize 64
	RequestExecutionLevel admin          ; for installation into program files folders
!endif

#########################################################################################
# MUI Symbol Definitions
#########################################################################################
!define MUI_WELCOMEFINISHPAGE_BITMAP "graphics\left.bmp"
!define MUI_ICON                     "graphics\scummvm-install.ico"
!define MUI_UNICON                   "graphics\scummvm-install.ico"

#Start menu
!define MUI_STARTMENUPAGE_REGISTRY_ROOT      HKCU
!define MUI_STARTMENUPAGE_REGISTRY_KEY       ${REGKEY}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_STARTMENUPAGE_DEFAULTFOLDER      $(^Name)

# Finish page
!define MUI_FINISHPAGE_RUN        "$INSTDIR\scummvm-tools.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.txt"
!define MUI_FINISHPAGE_RUN_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED

!define MUI_LICENSEPAGE_RADIOBUTTONS

!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

#########################################################################################
# Installer pages
#########################################################################################
# Variables
Var StartMenuGroup

;Remember the installer language
!define MUI_LANGDLL_REGISTRY_ROOT      HKCU
!define MUI_LANGDLL_REGISTRY_KEY       ${REGKEY}
!define MUI_LANGDLL_REGISTRY_VALUENAME "InstallerLanguage"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE ${top_srcdir}\COPYING
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE "English"    ;first language is the default language

!ifndef _DEBUG    ; Skip other languages when building debug builds
;!insertmacro MUI_LANGUAGE "Afrikaans"
;!insertmacro MUI_LANGUAGE "Albanian"
;!insertmacro MUI_LANGUAGE "Arabic"
;!insertmacro MUI_LANGUAGE "Belarusian"
;!insertmacro MUI_LANGUAGE "Bosnian"
;!insertmacro MUI_LANGUAGE "Breton"
;!insertmacro MUI_LANGUAGE "Bulgarian"
!insertmacro MUI_LANGUAGE "Catalan"
;!insertmacro MUI_LANGUAGE "Croatian"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Danish"
;!insertmacro MUI_LANGUAGE "Dutch"
;!insertmacro MUI_LANGUAGE "Esperanto"
;!insertmacro MUI_LANGUAGE "Estonian"
;!insertmacro MUI_LANGUAGE "Farsi"
;!insertmacro MUI_LANGUAGE "Finnish"
!insertmacro MUI_LANGUAGE "French"
;!insertmacro MUI_LANGUAGE "Galician"
!insertmacro MUI_LANGUAGE "German"
;!insertmacro MUI_LANGUAGE "Greek"
;!insertmacro MUI_LANGUAGE "Hebrew"
!insertmacro MUI_LANGUAGE "Hungarian"
;!insertmacro MUI_LANGUAGE "Icelandic"
;!insertmacro MUI_LANGUAGE "Indonesian"
;!insertmacro MUI_LANGUAGE "Irish"
!insertmacro MUI_LANGUAGE "Italian"
;!insertmacro MUI_LANGUAGE "Japanese"
;!insertmacro MUI_LANGUAGE "Korean"
;!insertmacro MUI_LANGUAGE "Kurdish"
;!insertmacro MUI_LANGUAGE "Latvian"
;!insertmacro MUI_LANGUAGE "Lithuanian"
;!insertmacro MUI_LANGUAGE "Luxembourgish"
;!insertmacro MUI_LANGUAGE "Macedonian"
;!insertmacro MUI_LANGUAGE "Malay"
;!insertmacro MUI_LANGUAGE "Mongolian"
!insertmacro MUI_LANGUAGE "Norwegian"
!insertmacro MUI_LANGUAGE "NorwegianNynorsk"
!insertmacro MUI_LANGUAGE "Polish"
;!insertmacro MUI_LANGUAGE "Portuguese"
!insertmacro MUI_LANGUAGE "PortugueseBR"
;!insertmacro MUI_LANGUAGE "Romanian"
!insertmacro MUI_LANGUAGE "Russian"
;!insertmacro MUI_LANGUAGE "Serbian"
;!insertmacro MUI_LANGUAGE "SerbianLatin"
;!insertmacro MUI_LANGUAGE "SimpChinese"
;!insertmacro MUI_LANGUAGE "Slovak"
;!insertmacro MUI_LANGUAGE "Slovenian"
!insertmacro MUI_LANGUAGE "Spanish"
;!insertmacro MUI_LANGUAGE "SpanishInternational"
!insertmacro MUI_LANGUAGE "Swedish"
;!insertmacro MUI_LANGUAGE "Thai"
;!insertmacro MUI_LANGUAGE "TradChinese"
;!insertmacro MUI_LANGUAGE "Turkish"
!insertmacro MUI_LANGUAGE "Ukrainian"
;!insertmacro MUI_LANGUAGE "Uzbek"
!endif

;Reserve Files (will make sure the file will be stored first in the data block
;               making the installer start faster when compressing in solid mode)
!insertmacro MUI_RESERVEFILE_LANGDLL

#########################################################################################
# Installer sections
#########################################################################################
Section "ScummVM" SecMain
	SetOutPath $INSTDIR
	SetOverwrite on

	# Text files
	File /oname=COPYING.txt      "${text_dir}\COPYING"
	File /oname=COPYING_BSD2.txt "${text_dir}\COPYING.BSD2"
	File /oname=COPYING_LUA.txt  "${text_dir}\COPYING.LUA"
	File /oname=NEWS.txt         "${text_dir}\NEWS"
	File /oname=README.txt       "${text_dir}\README"

	# Tools and dlls
	File "${build_dir}\construct_mohawk.exe"
	File "${build_dir}\decine.exe"
	File "${build_dir}\degob.exe"
	File "${build_dir}\dekyra.exe"
	File "${build_dir}\descumm.exe"
	File "${build_dir}\desword2.exe"
	File "${build_dir}\extract_mohawk.exe"
	File "${build_dir}\gob_loadcalc.exe"
	File "${build_dir}\grim_animb2txt.exe"
	File "${build_dir}\grim_cosb2cos.exe"
	File "${build_dir}\grim_diffr.exe"
	File "${build_dir}\grim_int2flt.exe"
	File "${build_dir}\grim_meshb2obj.exe"
	File "${build_dir}\grim_patchex.exe"
	File "${build_dir}\grim_set2fig.exe"
	File "${build_dir}\grim_sklb2txt.exe"
	File "${build_dir}\grim_unlab.exe"
	File "${build_dir}\grim_bm2bmp.exe"
	File "${build_dir}\grim_delua.exe"
	File "${build_dir}\grim_imc2wav.exe"
	File "${build_dir}\grim_luac.exe"
	File "${build_dir}\grim_mklab.exe"
	File "${build_dir}\grim_patchr.exe"
	File "${build_dir}\grim_setb2set.exe"
	File "${build_dir}\grim_til2bmp.exe"
	File "${build_dir}\grim_vima.exe"
	File "${build_dir}\scummvm-tools.exe"
	File "${build_dir}\scummvm-tools-cli.exe"

	# Media
	SetOutPath $INSTDIR\media
	File "${media_dir}\detaillogo.jpg"
	File "${media_dir}\logo.jpg"
	File "${media_dir}\tile.gif"

	WriteRegStr HKCU "${REGKEY}" InstallPath "$INSTDIR"    ; Store installation folder
SectionEnd

# Write Start menu entries and uninstaller
Section -post SecMainPost
	SetOutPath $INSTDIR
	WriteUninstaller $INSTDIR\uninstall.exe
	!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
	CreateDirectory "$SMPROGRAMS\$StartMenuGroup"
	CreateShortCut "$SMPROGRAMS\$StartMenuGroup\$(^Name).lnk"           "$INSTDIR\scummvm-tools.exe" "" "$INSTDIR\scummvm-tools.exe" 0    ; Create shortcut with icon
	CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Readme.lnk"             "$INSTDIR\README.txt"
	CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk" "$INSTDIR\uninstall.exe"
	!insertmacro MUI_STARTMENU_WRITE_END
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
	WriteRegStr   HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" InstallLocation $INSTDIR
	WriteRegDWORD HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
	WriteRegDWORD HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
SectionEnd

# Installer functions
Function .onInit
	!insertmacro MUI_LANGDLL_DISPLAY

!ifdef _DEBUG && NSIS_CONFIG_LOG
	LogSet on    ; Will write a log file to the install folder (when using the special NSIS logging build)
!endif
FunctionEnd

#########################################################################################
# Uninstaller sections
#########################################################################################
Section -un.Main SecUninstall
	Delete /REBOOTOK $INSTDIR\COPYING.txt
	Delete /REBOOTOK $INSTDIR\COPYING_BSD2.txt
	Delete /REBOOTOK $INSTDIR\COPYING_LUA.txt
	Delete /REBOOTOK $INSTDIR\NEWS.txt
	Delete /REBOOTOK $INSTDIR\README.txt

	Delete /REBOOTOK $INSTDIR\construct_mohawk.exe"
	Delete /REBOOTOK $INSTDIR\decine.exe"
	Delete /REBOOTOK $INSTDIR\degob.exe"
	Delete /REBOOTOK $INSTDIR\dekyra.exe"
	Delete /REBOOTOK $INSTDIR\descumm.exe"
	Delete /REBOOTOK $INSTDIR\desword2.exe"
	Delete /REBOOTOK $INSTDIR\extract_mohawk.exe"
	Delete /REBOOTOK $INSTDIR\gob_loadcalc.exe"
	Delete /REBOOTOK $INSTDIR\grim_animb2txt.exe"
	Delete /REBOOTOK $INSTDIR\grim_cosb2cos.exe"
	Delete /REBOOTOK $INSTDIR\grim_diffr.exe"
	Delete /REBOOTOK $INSTDIR\grim_int2flt.exe"
	Delete /REBOOTOK $INSTDIR\grim_meshb2obj.exe"
	Delete /REBOOTOK $INSTDIR\grim_patchex.exe"
	Delete /REBOOTOK $INSTDIR\grim_set2fig.exe"
	Delete /REBOOTOK $INSTDIR\grim_sklb2txt.exe"
	Delete /REBOOTOK $INSTDIR\grim_unlab.exe"
	Delete /REBOOTOK $INSTDIR\grim_bm2bmp.exe"
	Delete /REBOOTOK $INSTDIR\grim_delua.exe"
	Delete /REBOOTOK $INSTDIR\grim_imc2wav.exe"
	Delete /REBOOTOK $INSTDIR\grim_luac.exe"
	Delete /REBOOTOK $INSTDIR\grim_mklab.exe"
	Delete /REBOOTOK $INSTDIR\grim_patchr.exe"
	Delete /REBOOTOK $INSTDIR\grim_setb2set.exe"
	Delete /REBOOTOK $INSTDIR\grim_til2bmp.exe"
	Delete /REBOOTOK $INSTDIR\grim_vima.exe"
	Delete /REBOOTOK $INSTDIR\scummvm-tools.exe"
	Delete /REBOOTOK $INSTDIR\scummvm-tools-cli.exe"

	Delete /REBOOTOK $INSTDIR\media\detaillogo.jpg"
	Delete /REBOOTOK $INSTDIR\media\logo.jpg"
	Delete /REBOOTOK $INSTDIR\media\tile.gif"
SectionEnd

Section -un.post SecUninstallPost
	# Remove start menu entries
	SetShellVarContext all
	Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^Name).lnk"
	Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Readme.lnk"
	Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk"
	RmDir  /REBOOTOK  $SMPROGRAMS\$StartMenuGroup

	Delete /REBOOTOK $INSTDIR\uninstall.exe

	DeleteRegKey HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
	DeleteRegValue HKCU "${REGKEY}" StartMenuGroup
	DeleteRegValue HKCU "${REGKEY}" InstallPath
	DeleteRegValue HKCU "${REGKEY}" InstallerLanguage
	DeleteRegKey /IfEmpty HKCU "${REGKEY}"

	RmDir $INSTDIR    ; will only remove if empty (pass /r flag for recursive behavior)
	Push $R0
	StrCpy $R0 $StartMenuGroup 1
	StrCmp $R0 ">" no_smgroup
no_smgroup:
	Pop $R0
SectionEnd

# Uninstaller functions
Function un.onInit
	!insertmacro MUI_UNGETLANGUAGE
	ReadRegStr   $INSTDIR HKCU "${REGKEY}" InstallPath
	!insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuGroup
FunctionEnd
