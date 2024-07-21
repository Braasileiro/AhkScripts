; Separate GamePad View window switcher.

#Requires AutoHotkey v2.0
#SingleInstance Ignore
DetectHiddenWindows(true)

WS_BORDER := 0x800000
WS_CAPTION := 0xC00000
WS_DLGFRAME := 0x400000
WS_SIZEBOX := 0x40000

CemuExe := 'Cemu.exe'
TvWindowPrefix := 'Cemu '
GamePadViewWidth := 0
GamePadViewHeight := 0
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

                ; 854x480 (~16:9) is the Native Wii U GamePad resolution
                ; Resolutions lower than this will cause cropping
                global GamePadViewWidth := 854
                global GamePadViewHeight := 480
                WinMove(,, GamePadViewWidth, GamePadViewHeight)

                ; Move (Bottom-Right)
                WinMove((A_ScreenWidth - GamePadViewWidth), (A_ScreenHeight - GamePadViewHeight))
            }
            
            ; Switch windows
            if (WinActive(TvWindowPrefix)) {
                WinShow(GamePadViewWindowPrefix)
                WinActivate(GamePadViewWindowPrefix)
            } else {
                WinHide(GamePadViewWindowPrefix)
                WinActivate(TvWindowPrefix)
            }
        }
    }
}
