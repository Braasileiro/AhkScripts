; Separate GamePad View window switcher.

#Requires AutoHotkey v2.0
#SingleInstance Ignore

WS_BORDER := 0x800000
WS_CAPTION := 0xC00000
WS_DLGFRAME := 0x400000
WS_SIZEBOX := 0x40000

CemuExe := 'Cemu.exe'
TvWindowPrefix := 'Cemu '
GamePadViewWidth := 854
GamePadViewHeight := 480
GamePadViewWindowPrefix := 'GamePad View'

^T:: {
    if (WinExist('ahk_exe ' . CemuExe)) {
        if (WinExist(GamePadViewWindowPrefix)) {
            GamePadViewWindowStyle := WinGetStyle()

            ; Check if GamePad View has borders
            if (GamePadViewWindowStyle & WS_CAPTION) {
                ; Remove decoration of the GamePad View (Borderless)
                WinSetStyle(-WS_CAPTION)
                WinSetStyle(-WS_BORDER)
                WinSetStyle(-WS_DLGFRAME)
                WinSetStyle(-WS_SIZEBOX)

                ; Move (Bottom-Right)
                WinMove((A_ScreenWidth - GamePadViewWidth), (A_ScreenHeight - GamePadViewHeight))
            }
            
            ; Switch windows
            if (WinActive(TvWindowPrefix)) {
                WinActivate(GamePadViewWindowPrefix)
            } else {
                WinActivate(TvWindowPrefix)
            }
        }
    }
}
