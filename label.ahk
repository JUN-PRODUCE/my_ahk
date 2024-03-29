;アクションセンターを開いてBluetoothスイッチをクリック
SwitchBluetooth:
	Critical, On
	BlockInput, On
	Send, #a
	Sleep, 200
	Send, +{Tab}
	Sleep, 150
	Send, {space}
	Sleep, 50
	Send, {Escape}
	BlockInput, Off
	Critical, Off
	;別Ver
;	Run, bthprops.cpl
;	Sleep, 50
;	Send, {Tab}
;	Sleep, 30
;	Send, {Space}
;	Sleep, 50
;	Send, !F4
;	WinClose, ahk_exe ApplicationFrameHost.exe
Return

;----------------------------------------------------------
;ソフト優先度変更
Process_Control:
	Process_High("barrier.exe/Freebracketer.exe/chrome.exe/QuickLook.exe/")
	Sleep, 50
	Process_Low("Rainmeter.exe/Billy.exe/1by1.exe/ShareX.exe/ClAdmin.exe/FxSound.exe/JDownloader2.exe/NetMonitor.exe/thilmera7s64.exe/UCR.exe/foobar2000.exe/Ferdium.exe/SmartSystemMenu.exe/")
Return

;----------------------------------------------------------
;Chrome 翻訳
Chrome_Translate:
	Critical, On
	BlockInput, On
	SetKeyDelay, -1
	SetMouseDelay, -1
	my_tooltip_function("翻訳", 950)
	Send, {RButton}
	Sleep, 80
	Send, t
	Sleep, 120
	Send, {NumpadRight}
	Send, {Esc}
	BlockInput, Off
	Critical, Off
Return

;----------------------------------------------------------
;半角スペース/改行を削除
; ShareX OCRの文字処理対策

OCR_Jp_Fix:
Critical, On
WinWait, ShareX - Optical character recognition,, 2
Clipboard := ""
WinActivate, ShareX - Optical character recognition
Sleep, 30
Send, ^a
Send, ^c
Sleep, 30
; vClip1 := RegExReplace(Clipboard, A_Space, "")
vClip1 := RegExReplace(Clipboard, "", "")
Clipboard := RegExReplace(vClip1, "\r\n", "")
; RegExReplace(Clipboard, "\r\n", "")
Sleep, 80
Send, ^v
; ToolTip, %Clipboard%
Critical, Off
Return



;----------------------------------------------------------
;Chrome検索分岐
Chrome_Search_fork:
	if (RegExMatch(Clipboard, "(http|ftp)"))
		{
			Run, %gChrome%chrome.exe "%Clipboard%", %gChrome%,,
			Return
		}
	Else
		{ ;URLじゃない場合検索
			Run, https://www.google.com/search?q=%Clipboard%
			Return
}


;----------------------------------------------------------
; テキスト処理

bracket3: ; ""
Send ^c
Sleep, 40
str := clipboard
str := """" . str . """"
clipboard := str
Sleep, 40
Send ^v
return

bracket7: ; []
Send ^c
Sleep, 40
str := clipboard
str := "[" . str . "]"
; str := RegExReplace(str, "\.", "].[")
clipboard := str
Sleep, 40
Send ^v
Return


bracket8: ; ()
Send ^c
Sleep, 40
str := clipboard
str := "(" . str . ")"
; str := RegExReplace(str, "\.", ").(")
clipboard := str
Sleep, 40
Send ^v
Return

bracket9: ; %%
Send ^c
Sleep, 40
str := clipboard
str := "%" . str . "%"
; str := RegExReplace(str, "\.", "%.%")
clipboard := str
Sleep, 40
Send ^v
Return
