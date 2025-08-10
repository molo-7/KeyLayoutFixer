;------------------------------------------
; English ⇄ Arabic Keyboard Mapper
; Hotkey: Ctrl + Shift + R
; By: molo
;------------------------------------------

enToAr := { "q": "ض", "w": "ص", "e": "ث", "r": "ق", "t": "ف", "y": "غ", "u": "ع", "i": "ه", "o": "خ", "p": "ح", "[": "ج", "]": "د", "a": "ش", "s": "س", "d": "ي", "f": "ب", "g": "ل", "h": "ا", "j": "ت", "k": "ن", "l": "م", ";": "ك", "'": "ط", "z": "ئ", "x": "ء", "c": "ؤ", "v": "ر", "b": "لا", "n": "ى", "m": "ة", ",": "و", ".": "ز", "/": "ظ"}

arToEn := {}
for key, value in enToAr
    arToEn[value] := key

^+r::
    oldClipboard := ClipboardAll

    Send, ^c
    ClipWait, 1

    selectedText := Clipboard
    if (!selectedText) {
        Clipboard := oldClipboard
        return
    }

    result := ""

    Loop, Parse, selectedText
    {
        char := A_LoopField
        charLower := RegExReplace(char, "[A-Z]", Chr(Asc(char)+32)) ; lowercase conversion
        ; English to Arabic
        if (enToAr.HasKey(charLower))
            result .= enToAr[charLower]
        ; Arabic to English
        else if (arToEn.HasKey(char))
            result .= arToEn[char]
        else
            result .= char
    }

    ; Paste Into Selected Input
    Clipboard := result
    Sleep, 50
    Send, ^v

    ; Restore original clipboard
    Sleep, 50
    Clipboard := oldClipboard
return