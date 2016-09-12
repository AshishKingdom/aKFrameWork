
'#######################
' aKFrameWork v1.012
'  A Qb64 Framework
'      library
'#######################
'Copyright © 2016-17 by Ashish Kushwaha
'Last Update on 12:24 PM 7/22/2016
'Any suggestion or bug about this library are always welcome
'find me at http://www.qb64.net/forum



'roundBox v1.000
' By Ashish
' 2016-17 Copyright Ashish
SUB roundBox (x1, y1, width, height, r!, c&)
p = r! / 2 - 1
p2 = r! / 2 + 1
p3 = r! / 3
COLOR c&
LINE (x1 + p2 - 1, y1)-(x1 + width - p3, y1)
LINE (x1 + p2 - 1, y1 + height)-(x1 + width - p3, y1 + height)
LINE (x1 - p2, y1 + r!)-(x1 - p2, y1 + height - r!)
LINE (x1 + width + p2 + 1, y1 + r!)-(x1 + width + p2 + 1, y1 + height - r!)
CIRCLE (x1 + p, y1 + r!), r!, , 1.5, 3.3
CIRCLE (x1 + p, y1 + height - r!), r!, , 2.9, 4.8
CIRCLE (x1 + width - p, y1 + r!), r!, , 0, 1.8
CIRCLE (x1 + width - p, y1 + height - r!), r!, , 4.7, 6.2
END SUB

FUNCTION aKStrLength& (s AS STRING)
aKStrLength = LEN(RTRIM$(s))
END FUNCTION

FUNCTION aKNumLength& (n AS LONG)
aKNumLength = LEN(LTRIM$(RTRIM$(STR$(n))))
END FUNCTION

FUNCTION aKNewdialog (title AS STRING, width, height)
i = aKDialogLength
aKDialog(i).title = title
aKDialog(i).height = height
aKDialog(i).width = width
aKDialog(i).shown = 0
aKDialogLength = aKDialogLength + 1
aKNewdialog = i
REDIM _PRESERVE aKDialog(i + 1) AS aKdialogType
END FUNCTION

SUB akDialogShow (id) STATIC
aKDialog(id).background = _COPYIMAGE(0)
x = _WIDTH / 2
y = _HEIGHT / 2
x1 = aKDialog(id).width / 2
y1 = aKDialog(id).height / 2
IF NOT aKDialog(id).save AND aKDialog(id).hasAnimation THEN
    aKDialog(id).save = -1: aKDialog(id).noShadow = -1: tmp& = _NEWIMAGE(_WIDTH, _HEIGHT, 32)
    aKDialog(id).content = _NEWIMAGE(aKDialog(id).width + 1, aKDialog(id).height + 1, 32)
    _DEST tmp&
    akDialogShow id
    _DEST aKDialog(id).content
    _PUTIMAGE (0, 0), tmp&, , (aKDialog(id).Wx, aKDialog(id).Wy - 25)-(aKDialog(id).Wx + aKDialog(id).width, aKDialog(id).height + aKDialog(id).Wy - 25)
    _DEST 0
    _FREEIMAGE tmp&
    aKRunAnimation id
    aKDialog(id).noShadow = 0
END IF
'box shadow
IF aKDialog(id).noShadow THEN GOTO noshadow
i = 21: a = i
DO WHILE i > 0
    LINE (x - x1 - 21 + i, y - y1 - 21 + i)-(x - x1 - 21 + i, y + y1 + 21 - i), _RGBA(0, 0, 0, a * 6)
    LINE (x + x1 + 21 - i, y - y1 - 21 + i)-(x + x1 +21- i, y + y1 + 21 - i), _RGBA(0, 0, 0, a * 6)
    LINE (x - x1 - 20 + i, y - y1 - 21 + i)-(x + x1 + 20 + -i, y - y1 - 21 + i), _RGBA(0, 0, 0, a * 6)
    LINE (x - x1 - 20 + i, y + y1 + 21 - i)-(x + x1 + 20 + -i, y + y1 + 21 - i), _RGBA(0, 0, 0, a * 6)
    i = i - 1: a = a - 3
LOOP
noshadow:

'Dialog Box
LINE (x - x1, y - y1)-(x + x1, y + y1), _RGB(230, 230, 230), BF
LINE (x - x1, y - y1)-(x + x1, y + y1), _RGB(0, 0, 255), B
'Title Bar
LINE ((x - x1) + 1, (y - y1) + 1)-((x + x1) - 1, (y - y1) + 25), _RGB(255, 255, 255), BF
COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
_PRINTSTRING ((x - x1) + 10, (y - y1) + 6), RTRIM$(aKDialog(id).title)
'close button
LINE ((x + x1) - 1, (y - y1) + 1)-((x + x1) - 30, (y - y1) + 25), _RGB(220, 0, 0), BF
COLOR _RGB(255, 255, 255), _RGB(220, 0, 0)
_PRINTSTRING ((x + x1) - 18, (y - y1) + 5), "x"
aKDialog(id).Cx2 = (x + x1) - 1: aKDialog(id).Cy = (y - y) + 1
aKDialog(id).Cx = (x + x1) - 30: aKDialog(id).Cy2 = (y - y1) + 25
'labels
wx = (x - x1): wy = (y - y1) + 25
aKDialog(id).Wx = wx: aKDialog(id).Wy = wy
FOR i = 1 TO aKlabelLength
    IF aKLabel(i).id = id THEN
        aKDrawObject id, aKLabel, i
    END IF
NEXT
'buttons
FOR i = 1 TO aKButtonLength
    IF aKButton(i).id = id THEN
        aKDrawObject id, aKButton, i
    END IF
NEXT
'check boxes
FOR i = 1 TO aKCheckBoxLength
    IF aKCheckBox(i).id = id THEN
        aKDrawObject id, aKCheckBox, i
    END IF
NEXT
'radio buttons
FOR i = 1 TO aKRadioLength
    IF aKRadioButton(i).id = id THEN
        aKDrawObject id, aKRadioButton, i
    END IF
NEXT
'Link labels
FOR i = 1 TO aKLinklabelLength
    IF aKLinkLabel(i).id = id THEN
        aKDrawObject id, aKLinkLabel, i
    END IF
NEXT
'Combo Boxes
FOR i = 1 TO aKComboBoxLength
    IF aKComboBox(i).id = id THEN
        aKDrawObject id, aKComboBox, i
    END IF
NEXT
'textbox
FOR i = 1 TO aKTextBoxLength
    IF aKTextBox(i).id = id THEN
        aKDrawObject id, aKTextBox, i
    END IF
NEXT
'Numeric Up and Down
FOR i = 1 TO aKNumericUDLength
    IF aKNumericUpDown(i).id = id THEN
        aKDrawObject id, aKNumericUpDown, i
    END IF
NEXT
'pictures
FOR i = 1 TO aKPictureLength
    IF aKPicture(i).id = id THEN
        aKDrawObject id, aKPicture, i
    END IF
NEXT
'dividers
FOR i = 1 TO aKDividerLength
    IF aKDivider(i).id = id THEN
        aKDrawObject id, aKDivider, i
    END IF
NEXT
'panels
FOR i = 1 TO aKPanelLength
    IF aKPanel(i).id = id THEN
        aKDrawObject id, aKPanel, i
    END IF
NEXT
'progress bars
FOR i = 1 TO aKProgressBarLength
    IF aKProgressBar(i).id = id THEN
        LINE (wx + aKProgressBar(i).x, wy + aKProgressBar(i).y)-(wx + aKProgressBar(i).x + aKProgressBar(i).width, wy + aKProgressBar(i).y + 20), _RGB(210, 210, 210), BF
        LINE (wx + aKProgressBar(i).x, wy + aKProgressBar(i).y)-(wx + aKProgressBar(i).x + aKProgressBar(i).width, wy + aKProgressBar(i).y + 20), _RGB(0, 0, 0), B
        px = aKProgressBar(i).width - 2
        ps& = _NEWIMAGE(px, 19, 32)
        _DEST ps&
        LINE (0, 0)-(px, 19), _RGB(0, 155, 0), BF
        FOR n = -px TO px STEP 10
            LINE (n, 0)-(n + px, 400), _RGB(0, 255, 0)
        NEXT

        FOR n = -px TO px STEP 20
            PAINT (n + 2, 1), _RGB(0, 255, 0), _RGB(0, 255, 0)
            PAINT (n + 5, 18), _RGB(0, 255, 0), _RGB(0, 255, 0)
        NEXT
        aKProgressBar(i).bar = ps&
        _DEST 0
    END IF
NEXT
'tooltips
FOR i = 1 TO aKTooltipLength
    IF aKTooltip(i).id = id THEN
        aKDrawObject id, aKTooltip, i
    END IF
NEXT
'finishing touch.....
_DEST 0: _SOURCE 0: _DISPLAY
aKDialog(id).Wx = wx: aKDialog(id).Wy = wy

END SUB


SUB aKError (routine$, ErrorCode)
SCREEN 0
CLS , 4
COLOR 15, 4
PRINT "aKFrameWork gets the following error : "
PRINT: PRINT
PRINT "An error occured while calling " + routine$ + " because"
SELECT CASE ErrorCode
    CASE 256
        PRINT "the handle of the dialog is not in use. " + routine$: PRINT "works only when it is in use."
    CASE 255
        PRINT "file not found."
    CASE 254
        PRINT "Undefined type has given."
    CASE 253
        PRINT "Invalid handle is given."
END SELECT
DO: _LIMIT 1: LOOP UNTIL INKEY$ <> "": SYSTEM
END SUB

FUNCTION aKAddlabel (id, text AS STRING, x, y)
i = aKlabelLength
aKLabel(i).text = text
aKLabel(i).x = x
aKLabel(i).y = y
aKLabel(i).id = id
aKlabelLength = aKlabelLength + 1
aKAddlabel = i
REDIM _PRESERVE aKLabel(i + 1) AS aKlabelType
END FUNCTION

FUNCTION aKAddButton (id, v$, x, y)
i = aKButtonLength
aKButton(i).value = v$
aKButton(i).x = x
aKButton(i).y = y
aKButton(i).id = id
aKAddButton = i
aKButtonLength = aKButtonLength + 1
REDIM _PRESERVE aKButton(i + 1) AS aKButtonType
END FUNCTION

FUNCTION aKAddCheckBox (id, t$, x, y)
i = aKCheckBoxLength
aKCheckBox(i).text = t$
aKCheckBox(i).x = x
aKCheckBox(i).y = y
aKCheckBox(i).id = id
aKAddCheckBox = aKCheckBoxLength
aKCheckBoxLength = aKCheckBoxLength + 1
REDIM _PRESERVE aKCheckBox(i + 1) AS akCheckBoxType
END FUNCTION

FUNCTION aKAddRadioButton (id, t$, x, y, gid)
i = aKRadioLength
aKRadioButton(i).text = t$
aKRadioButton(i).x = x
aKRadioButton(i).y = y
aKRadioButton(i).groupId = gid
aKRadioButton(i).id = id
aKAddRadioButton = i
aKRadioLength = aKRadioLength + 1
REDIM _PRESERVE aKRadioButton(i + 1) AS akRadioButtonType
END FUNCTION

FUNCTION aKAddLinklabel (id, t$, x, y)
i = aKLinklabelLength
aKLinkLabel(i).text = t$
aKLinkLabel(i).x = x
aKLinkLabel(i).y = y
aKLinkLabel(i).id = id
aKAddLinklabel = i
aKLinklabelLength = aKLinklabelLength + 1
REDIM _PRESERVE aKLinkLabel(i + 1) AS aKLinklabelType
END FUNCTION

FUNCTION aKAddComboBox (id, v$, o$, x, y)
i = aKComboBoxLength
aKComboBox(i).value = v$
aKComboBox(i).options = o$
aKComboBox(i).x = x
aKComboBox(i).y = y
aKComboBox(i).id = id
aKAddComboBox = i
aKComboBoxLength = aKComboBoxLength + 1
REDIM _PRESERVE aKComboBox(i + 1) AS aKComboBoxType
END FUNCTION

FUNCTION aKAddTextBox (id, v$, p$, x, y, width, typ)
i = aKTextBoxLength
aKTextBox(i).value = v$
aKTextBox(i).placeholder = p$
aKTextBox(i).x = x
aKTextBox(i).y = y
aKTextBox(i).width = width
aKTextBox(i).typ = typ
aKTextBox(i).id = id
aKAddTextBox = i
aKTextBoxLength = aKTextBoxLength + 1
REDIM _PRESERVE aKTextBox(i + 1) AS aKTextboxType
END FUNCTION

FUNCTION aKAddNumericUpDown (id, v, x, y, width)
i = aKNumericUDLength
aKNumericUpDown(i).value = v
aKNumericUpDown(i).x = x
aKNumericUpDown(i).y = y
aKNumericUpDown(i).width = width
aKNumericUpDown(i).id = id
aKAddNumericUpDown = i
aKNumericUDLength = aKNumericUDLength + 1
REDIM _PRESERVE aKNumericUpDown(i + 1) AS aKNumericUpDownType
END FUNCTION

FUNCTION aKAddProgressBar (id, x, y, width, value, active)
i = aKProgressBarLength
aKProgressBar(i).x = x
aKProgressBar(i).y = y
aKProgressBar(i).width = width
aKProgressBar(i).value = value
aKProgressBar(i).active = active
aKProgressBar(i).id = id
aKProgressBarLength = aKProgressBarLength + 1
aKAddProgressBar = i
REDIM _PRESERVE aKProgressBar(i + 1) AS aKProgressBarType
END FUNCTION

FUNCTION aKAddTooltip (id, typ, object, t$)
i = aKTooltipLength
SELECT CASE typ
    CASE aKLabel
        aKLabel(object).tooltip = -1
        aKLabel(object).tId = i
        aKTooltip(i).text = t$
        aKTooltip(i).id = id
    CASE aKButton
        aKButton(object).tooltip = -1
        aKButton(object).tId = i
        aKTooltip(i).text = t$
        aKTooltip(i).id = id
    CASE aKLinkLabel
        aKLinkLabel(object).tooltip = -1
        aKLinkLabel(object).tId = i
        aKTooltip(i).text = t$
        aKTooltip(i).id = id
    CASE aKPicture
        aKPicture(object).tooltip = -1
        aKPicture(object).tid = i
        aKTooltip(i).text = t$
        aKTooltip(i).id = id
    CASE ELSE
        aKError "aKAddToolip", 254
END SELECT
aKTooltipLength = aKTooltipLength + 1
REDIM _PRESERVE aKTooltip(i + 1) AS aKTooltipType
END FUNCTION

FUNCTION aKAddPanel (id, x, y, width, height, title$)
i = aKPanelLength
aKPanel(i).id = id
aKPanel(i).x = x
aKPanel(i).y = y
aKPanel(i).width = width
aKPanel(i).height = height
aKPanel(i).title = title$

aKPanelLength = aKPanelLength + 1

aKAddPanel = i

REDIM _PRESERVE aKPanel(i + 1) AS aKPanelType
END FUNCTION

FUNCTION aKAddDivider (id, x, y, typ, size)
i = aKDividerLength
aKDivider(i).id = id
aKDivider(i).x = x
aKDivider(i).y = y
IF NOT typ = aKVertical AND NOT typ = aKHorizontal THEN aKError "aKAddDivider", 254
aKDivider(i).typ = typ
aKDivider(i).size = size

aKDividerLength = aKDividerLength + 1

aKAddDivider = i

REDIM _PRESERVE aKDivider(i + 1) AS aKDividerType
END FUNCTION

FUNCTION aKAddPicture (id, x, y, width, height, img&)
i = aKPictureLength
aKPicture(i).id = id
aKPicture(i).x = x
aKPicture(i).y = y
aKPicture(i).height = height
aKPicture(i).width = width
aKPicture(i).img = img&

aKPictureLength = aKPictureLength + 1

aKAddPicture = i

REDIM _PRESERVE aKPicture(i + 1) AS aKPictureType
END FUNCTION

SUB aKCheck (id) STATIC
IF NOT aKDialog(id).shown AND NOT aKDialog(id).closed THEN akDialogShow id: aKDialog(id).shown = -1
DO
    Mouse.movement = _MOUSEINPUT

    FOR i = 1 TO aKProgressBarLength
        IF aKProgressBar(i).active AND aKProgressBar(i).id = id THEN
            IF aKProgressBar(i).oldValue <> aKProgressBar(i).value / 100 * aKProgressBar(i).width THEN
                IF aKProgressBar(i).oldValue <= aKProgressBar(i).value THEN s = 1 ELSE s = -1
                q = aKProgressBar(i).value / 100 * aKProgressBar(i).width
                e = aKProgressBar(i).oldValue / 100 * aKProgressBar(i).width
                FOR n = e TO q STEP s
                    _PUTIMAGE (aKDialog(id).Wx + aKProgressBar(i).x + 1, aKDialog(id).Wy + aKProgressBar(i).y + 1), aKProgressBar(i).bar
                    LINE (aKDialog(id).Wx + aKProgressBar(i).x + 1 + n, aKDialog(id).Wy + aKProgressBar(i).y + 1)-(aKDialog(id).Wx + aKProgressBar(i).x + aKProgressBar(i).width - 1, aKDialog(id).Wy + aKProgressBar(i).y + 19), _RGB(210, 210, 210), BF
                    _LIMIT 100
                    _DISPLAY
                NEXT
                aKProgressBar(i).oldValue = aKProgressBar(i).value
            END IF
            aKProgressBar(i).active = 0
            EXIT DO
        END IF
    NEXT
    IF Mouse.movement THEN
        Mouse.x = _MOUSEX: Mouse.y = _MOUSEY
        IF _MOUSEBUTTON(1) THEN Mouse.Lclick = -1 ELSE Mouse.Lclick = 0
        IF _MOUSEBUTTON(2) THEN Mouse.Rclick = -1 ELSE Mouse.Rclick = 0
        EXIT DO
    END IF
LOOP
END SUB

SUB aKUpdate (id)

IF NOT aKDialog(id).shown AND NOT aKDialog(id).closed THEN akDialogShow id: aKDialog(id).shown = -1
'close of dialog
IF NOT aKDialog(id).closed THEN
    IF Mouse.x > aKDialog(id).Cx AND Mouse.x < aKDialog(id).Cx2 AND Mouse.y > aKDialog(id).Cy AND Mouse.y < aKDialog(id).Cy2 AND Mouse.Lclick THEN aKHideDialog id: EXIT SUB
    'draging feature (suggested by Fellippe )
    IF Mouse.x > aKDialog(id).Wx AND Mouse.x < aKDialog(id).Cx - 30 AND Mouse.y > aKDialog(id).Wy - 25 AND Mouse.y < aKDialog(id).Wy THEN
        IF NOT RTRIM$(Mouse.icon) = "move" THEN Mouse.icon = "move": glutSetCursor 5
        IF Mouse.Lclick THEN
            tmp& = _NEWIMAGE(aKDialog(id).width + 1, aKDialog(id).height + 1, 32)
            tmp2& = _COPYIMAGE(0)
            _DEST tmp&
            _PUTIMAGE (0, 0), 0, tmp&, (aKDialog(id).Wx, aKDialog(id).Wy - 25)-(aKDialog(id).Wx + aKDialog(id).width + 8, aKDialog(id).Wy + aKDialog(id).height - 25)
            _DEST 0
            ox = (aKDialog(id).Wx - _MOUSEX)
            oy = (aKDialog(id).Wy - _MOUSEY) - 25

            _SETALPHA 122, , tmp&
            DO
                WHILE _MOUSEINPUT: WEND
                IF _MOUSEBUTTON(1) THEN
                    _PUTIMAGE , tmp2&
                    _PUTIMAGE (_MOUSEX + ox, _MOUSEY + oy), tmp&
                    _DISPLAY
                    dx = _MOUSEX + ox: dy = _MOUSEY + oy
                ELSE
                    IF dx < 1 THEN dx = 1
                    IF dy < 26 THEN dy = 26
                    IF dx + aKDialog(id).width > _WIDTH THEN dx = _WIDTH - aKDialog(id).width - 2
                    IF dy + aKDialog(id).height > _HEIGHT THEN dy = _HEIGHT - aKDialog(id).height
                    aKDialog(id).Wx = dx: aKDialog(id).Wy = dy
                    aKDialog(id).Cx = aKDialog(id).Wx + aKDialog(id).width - 30
                    aKDialog(id).Cx2 = aKDialog(id).Wx + aKDialog(id).width - 1
                    aKDialog(id).Cy = aKDialog(id).Wy - 24: aKDialog(id).Cy2 = aKDialog(id).Wy
                    _SETALPHA 255, , tmp&
                    IF aKDialog(id).hasAnimation THEN
                        IF UCASE$(RTRIM$(aKDialog(id).transition)) = "FADEWHITE" THEN
                            tmp4& = _NEWIMAGE(_WIDTH, _HEIGHT, 32)
                            _DEST tmp4&: LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB(255, 255, 255), BF: _DEST 0
                            _SETALPHA 125, , tmp4&: _PUTIMAGE , aKDialog(id).background: _PUTIMAGE , tmp4&
                            _FREEIMAGE tmp4&
                        ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "FADEBLACK" THEN
                            tmp4& = _NEWIMAGE(_WIDTH, _HEIGHT, 32)
                            _DEST tmp4&: LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB(0, 0, 0), BF: _DEST 0
                            _SETALPHA 125, , tmp4&: _PUTIMAGE , aKDialog(id).background: _PUTIMAGE , tmp4&
                            _FREEIMAGE tmp4&
                        ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "FOCUS" THEN
                            _PUTIMAGE , aKDialog(id).background
                            LINE (0, 0)-(_WIDTH, _HEIGHT), _RGBA(0, 0, 0, 120), BF
                        ELSE
                            _PUTIMAGE , aKDialog(id).background
                        END IF
                    ELSE
                        _PUTIMAGE , aKDialog(id).background
                    END IF
                    aKCreateShadow id
                    _PUTIMAGE (aKDialog(id).Wx, aKDialog(id).Wy - 25), tmp&
                    _FREEIMAGE tmp&
                    _FREEIMAGE tmp2&
                    _DISPLAY
                    EXIT SUB
                END IF
            LOOP
        END IF
    ELSE
        IF RTRIM$(Mouse.icon) = "move" THEN _MOUSESHOW "default": Mouse.icon = "default"
    END IF
    'checking tooltips of labels
    IF aKlabelLength > 0 THEN
        FOR i = 1 TO aKlabelLength
            IF aKHover(id, aKLabel, i) AND aKLabel(i).id = id AND NOT aKLabel(i).hidden THEN
                IF aKLabel(i).tooltip AND aKTooltip(aKLabel(i).tId).id = id THEN
                    IF Mouse.Lclick THEN aKTooltip(aKLabel(i).tId).shown = 0: _PUTIMAGE , tooltipBg: EXIT SUB
                    IF NOT aKTooltip(aKLabel(i).tId).shown THEN tooltipBg = _COPYIMAGE(0)
                    _PUTIMAGE , tooltipBg
                    _PUTIMAGE (Mouse.x + 10, Mouse.y - 3 - _HEIGHT(aKTooltip(aKLabel(i).tId).content)), aKTooltip(aKLabel(i).tId).content
                    aKTooltip(aKLabel(i).tId).shown = -1
                END IF
            ELSE
                IF aKTooltip(aKLabel(i).tId).shown AND aKLabel(i).id = id THEN aKTooltip(aKLabel(i).tId).shown = 0: _PUTIMAGE , tooltipBg&
            END IF
        NEXT
    END IF
    'buttons reactions with user

    FOR i = 1 TO aKButtonLength
        IF aKHover(id, aKButton, i) AND aKButton(i).id = id AND NOT aKButton(i).hidden THEN
            IF NOT aKButton(i).react THEN
                LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 7.5 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(229, 241, 255), BF
                LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 7.5 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(0, 0, 255), B
                COLOR _RGB(0, 0, 0), _RGB(229, 241, 255)
                _PRINTSTRING (aKDialog(id).Wx + aKButton(i).x + 10, aKDialog(id).Wy + aKButton(i).y + 5), RTRIM$(aKButton(i).value)
                aKButton(i).react = -1
            END IF
            'tooltips
            IF aKButton(i).tooltip THEN
                IF Mouse.Lclick THEN aKTooltip(aKButton(i).tId).shown = 0: _PUTIMAGE , tooltipBg: EXIT SUB
                IF NOT aKTooltip(aKButton(i).tId).shown THEN tooltipBg = _COPYIMAGE(0)
                _PUTIMAGE , tooltipBg
                _PUTIMAGE (Mouse.x + 20, Mouse.y - 5), aKTooltip(aKButton(i).tId).content
                aKTooltip(aKButton(i).tId).shown = -1
            END IF
        ELSE
            IF aKButton(i).react < 1 AND aKButton(i).id = id THEN
                LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 7.5 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(180, 180, 180), BF
                LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 7.5 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(0, 0, 0), B
                COLOR _RGB(0, 0, 0), _RGB(180, 180, 180)
                _PRINTSTRING (aKDialog(id).Wx + aKButton(i).x + 10, aKDialog(id).Wy + aKButton(i).y + 5), RTRIM$(aKButton(i).value)
                aKButton(i).react = aKButton(i).react + 1
            END IF
            IF aKTooltip(aKButton(i).tId).shown AND aKButton(i).id = id THEN aKTooltip(aKButton(i).tId).shown = 0: _PUTIMAGE , tooltipBg&
        END IF
    NEXT


    FOR i = 1 TO aKLinklabelLength
        IF aKHover(id, aKLinkLabel, i) AND aKLinkLabel(i).id = id AND NOT aKLinkLabel(i).hidden THEN
            IF NOT RTRIM$(Mouse.icon) = "link" THEN Mouse.icon = "link": _MOUSESHOW "link"
            IF aKClick(id, aKLinkLabel, i) THEN
                COLOR _RGB(255, 0, 0), _RGB(230, 230, 230)
                _PRINTSTRING (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y), RTRIM$(aKLinkLabel(i).text)
                LINE (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y + 14)-(aKDialog(id).Wx + aKLinkLabel(i).x + aKStrLength(aKLinkLabel(i).text) * 8, aKDialog(id).Wy + aKLinkLabel(i).y + 14), _RGB(255, 0, 0)
                _DISPLAY
                _DELAY .1
                COLOR _RGB(0, 0, 255)
                _PRINTSTRING (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y), RTRIM$(aKLinkLabel(i).text)
                LINE (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y + 14)-(aKDialog(id).Wx + aKLinkLabel(i).x + aKStrLength(aKLinkLabel(i).text) * 8, aKDialog(id).Wy + aKLinkLabel(i).y + 14), _RGB(0, 0, 255)
            END IF
            IF aKLinkLabel(i).tooltip THEN
                IF Mouse.Lclick THEN aKTooltip(aKLinkLabel(i).tId).shown = 0: _PUTIMAGE , tooltipBg: EXIT SUB
                IF NOT aKTooltip(aKLinkLabel(i).tId).shown THEN tooltipBg = _COPYIMAGE(0)
                _PUTIMAGE , tooltipBg
                _PUTIMAGE (Mouse.x + 20, Mouse.y - 5), aKTooltip(aKLinkLabel(i).tId).content
                aKTooltip(aKLinkLabel(i).tId).shown = -1
            END IF
        ELSE
            IF RTRIM$(Mouse.icon) = "link" AND NOT aKAnyHover(id, aKLinkLabel) THEN Mouse.icon = "default": _MOUSESHOW "default"
            IF aKTooltip(aKLinkLabel(i).tId).shown AND aKLinkLabel(i).id = id THEN aKTooltip(aKLinkLabel(i).tId).shown = 0: _PUTIMAGE , tooltipBg
        END IF
    NEXT

    FOR i = 1 TO aKPictureLength
        IF aKHover(id, aKPicture, i) AND aKPicture(i).id = id AND NOT aKPicture(i).hidden THEN
            IF aKPicture(i).tooltip THEN
                IF Mouse.Lclick THEN aKTooltip(aKPicture(i).tid).shown = 0: _PUTIMAGE , tooltipBg: EXIT SUB
                IF NOT aKTooltip(aKPicture(i).tid).shown THEN tooltipBg = _COPYIMAGE(0)
                _PUTIMAGE , tooltipBg
                _PUTIMAGE (Mouse.x + 20, Mouse.y - 5), aKTooltip(aKPicture(i).tid).content
                aKTooltip(aKPicture(i).tid).shown = -1
            END IF
        ELSE
            IF aKTooltip(aKPicture(i).tid).shown AND aKPicture(i).id = id THEN aKTooltip(aKPicture(i).tid).shown = 0: _PUTIMAGE , tooltipBg
        END IF
    NEXT

    FOR i = 1 TO aKCheckBoxLength
        IF aKHover(id, aKCheckBox, i) AND aKCheckBox(i).id = id AND NOT aKCheckBox(i).hidden THEN
            IF Mouse.Lclick THEN
                IF aKCheckBox(i).checked THEN aKCheckBox(i).checked = 0: LINE (aKCheckBox(i).x + aKDialog(id).Wx + 3, aKCheckBox(i).y + aKDialog(id).Wy + 3)-(aKCheckBox(i).x + aKDialog(id).Wx + 9, aKCheckBox(i).y + aKDialog(id).Wy + 9), _RGB(255, 255, 255), BF ELSE aKCheckBox(i).checked = -1: LINE (aKCheckBox(i).x + aKDialog(id).Wx + 3, aKCheckBox(i).y + aKDialog(id).Wy + 3)-(aKCheckBox(i).x + aKDialog(id).Wx + 9, aKCheckBox(i).y + aKDialog(id).Wy + 9), _RGB(0, 0, 0), BF
            END IF
            IF NOT aKCheckBox(i).react THEN LINE (aKDialog(id).Wx + aKCheckBox(i).x, aKDialog(id).Wy + aKCheckBox(i).y)-(aKDialog(id).Wx + aKCheckBox(i).x + 12, aKDialog(id).Wy + aKCheckBox(i).y + 12), _RGB(0, 0, 255), B: aKCheckBox(i).react = -1
        ELSE
            IF aKCheckBox(i).react THEN LINE (aKDialog(id).Wx + aKCheckBox(i).x, aKDialog(id).Wy + aKCheckBox(i).y)-(aKDialog(id).Wx + aKCheckBox(i).x + 12, aKDialog(id).Wy + aKCheckBox(i).y + 12), _RGB(0, 0, 0), B: aKCheckBox(i).react = 0
        END IF
    NEXT


    FOR i = 1 TO aKRadioLength
        IF aKHover(id, aKRadioButton, i) AND aKRadioButton(i).id = id AND NOT aKRadioButton(i).hidden THEN
            IF Mouse.Lclick AND NOT aKRadioButton(i).checked THEN
                FOR n = 1 TO aKRadioLength
                    IF aKRadioButton(i).groupId = aKRadioButton(n).groupId AND aKRadioButton(n).checked AND aKRadioButton(n).id = id THEN
                        IF NOT aKRadioButton(n).hidden THEN
                            PAINT (aKDialog(id).Wx + aKRadioButton(n).x + 5, aKDialog(id).Wy + aKRadioButton(n).y + 7), _RGB(255, 255, 255), _RGB(0, 0, 0)
                            CIRCLE (aKDialog(id).Wx + aKRadioButton(n).x + 5, aKDialog(id).Wy + aKRadioButton(n).y + 7), 5, _RGB(0, 0, 0)
                            PAINT (aKDialog(id).Wx + aKRadioButton(n).x + 5, aKDialog(id).Wy + aKRadioButton(n).y + 7), _RGB(255, 255, 255), _RGB(0, 0, 0)
                        END IF
                        aKRadioButton(n).checked = 0
                    END IF
                NEXT
                CIRCLE (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), 3, _RGB(8, 8, 8)
                PAINT (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), _RGB(8, 8, 8), _RGB(8, 8, 8)
                aKRadioButton(i).checked = -1
            END IF
            IF NOT aKRadioButton(i).react THEN CIRCLE (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), 5, _RGB(0, 0, 255): aKRadioButton(i).react = -1
        ELSE
            IF aKRadioButton(i).react THEN CIRCLE (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), 5, _RGB(0, 0, 0): aKRadioButton(i).react = 0
        END IF
    NEXT


    FOR i = 1 TO aKNumericUDLength
        IF aKHover(id, aKNumericUpDown, i) AND aKNumericUpDown(i).id = id AND NOT aKNumericUpDown(i).hidden THEN
            IF NOT aKNumericUpDown(i).react THEN
                LINE (aKDialog(id).Wx + aKNumericUpDown(i).x, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(0, 0, 255), B
                LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 10, aKNumericUpDown(i).y + aKDialog(id).Wy)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 30, aKNumericUpDown(i).y + aKDialog(id).Wy + 13), _RGB(0, 0, 255), B
                LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 10, aKNumericUpDown(i).y + aKDialog(id).Wy + 13)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 30, aKNumericUpDown(i).y + aKDialog(id).Wy + 25), _RGB(0, 0, 255), B
                aKNumericUpDown(i).react = -1
            END IF
            IF Mouse.x > aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 10 AND Mouse.y > aKNumericUpDown(i).y + aKDialog(id).Wy AND Mouse.x < aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 30 AND Mouse.y < aKNumericUpDown(i).y + aKDialog(id).Wy + 13 THEN
                IF Mouse.Lclick THEN
                    aKNumericUpDown(i).value = aKNumericUpDown(i).value + 1
                    COLOR _RGB(0, 0, 0), _RGBA(255, 255, 255, 255)
                    n = INT(aKNumericUpDown(i).width / 8)
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + 5, aKDialog(id).Wy + aKNumericUpDown(i).y + 6), STRING$(n, " ")
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + 5, aKDialog(id).Wy + aKNumericUpDown(i).y + 6), LTRIM$(RTRIM$(STR$(aKNumericUpDown(i).value)))
                END IF
                IF NOT aKNumericUpDown(i).react1 THEN
                    LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 11, aKNumericUpDown(i).y + aKDialog(id).Wy + 1)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 29, aKNumericUpDown(i).y + aKDialog(id).Wy + 12), _RGB(229, 241, 255), BF
                    COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y - 1), CHR$(30)
                    aKNumericUpDown(i).react1 = -1
                END IF
            ELSE
                IF aKNumericUpDown(i).react1 THEN
                    LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 11, aKNumericUpDown(i).y + aKDialog(id).Wy + 1)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 29, aKNumericUpDown(i).y + aKDialog(id).Wy + 12), _RGB(180, 180, 180), BF
                    COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y - 1), CHR$(30)
                    aKNumericUpDown(i).react1 = 0
                END IF
            END IF
            IF Mouse.x > aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 10 AND Mouse.y > aKNumericUpDown(i).y + aKDialog(id).Wy + 13 AND Mouse.x < aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 30 AND Mouse.y < aKNumericUpDown(i).y + aKDialog(id).Wy + 25 THEN
                IF Mouse.Lclick THEN
                    aKNumericUpDown(i).value = aKNumericUpDown(i).value - 1
                    COLOR _RGB(0, 0, 0), _RGBA(255, 255, 255, 255)
                    n = INT(aKNumericUpDown(i).width / 8)
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + 5, aKDialog(id).Wy + aKNumericUpDown(i).y + 6), STRING$(n, " ")
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + 5, aKDialog(id).Wy + aKNumericUpDown(i).y + 6), LTRIM$(RTRIM$(STR$(aKNumericUpDown(i).value)))
                END IF
                IF NOT aKNumericUpDown(i).react2 THEN
                    LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 11, aKNumericUpDown(i).y + aKDialog(id).Wy + 14)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 29, aKNumericUpDown(i).y + aKDialog(id).Wy + 24), _RGB(229, 241, 255), BF
                    COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y + 13), CHR$(31)
                    aKNumericUpDown(i).react2 = -1
                END IF
            ELSE
                IF aKNumericUpDown(i).react2 THEN
                    LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 11, aKNumericUpDown(i).y + aKDialog(id).Wy + 14)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 29, aKNumericUpDown(i).y + aKDialog(id).Wy + 24), _RGB(180, 180, 180), BF
                    COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                    _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y + 13), CHR$(31)
                    aKNumericUpDown(i).react2 = 0
                END IF
            END IF
        ELSE
            IF aKNumericUpDown(i).react THEN
                LINE (aKDialog(id).Wx + aKNumericUpDown(i).x, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(0, 0, 0), B
                LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 10, aKNumericUpDown(i).y + aKDialog(id).Wy)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 30, aKNumericUpDown(i).y + aKDialog(id).Wy + 13), _RGB(0, 0, 0), B
                LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 10, aKNumericUpDown(i).y + aKDialog(id).Wy + 13)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 30, aKNumericUpDown(i).y + aKDialog(id).Wy + 25), _RGB(0, 0, 0), B
                aKNumericUpDown(i).react = 0
            END IF
            IF aKNumericUpDown(i).react1 THEN
                LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 11, aKNumericUpDown(i).y + aKDialog(id).Wy + 1)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 29, aKNumericUpDown(i).y + aKDialog(id).Wy + 12), _RGB(180, 180, 180), BF
                COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y - 1), CHR$(30)
                aKNumericUpDown(i).react1 = 0
            END IF
            IF aKNumericUpDown(i).react2 THEN
                LINE (aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 11, aKNumericUpDown(i).y + aKDialog(id).Wy + 14)-(aKNumericUpDown(i).x + aKDialog(id).Wx + aKNumericUpDown(i).width + 29, aKNumericUpDown(i).y + aKDialog(id).Wy + 24), _RGB(180, 180, 180), BF
                COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y + 13), CHR$(31)
                aKNumericUpDown(i).react2 = 0
            END IF
        END IF
    NEXT
    'multi-tasking input textbox
    'by Ashish v1.002
    FOR i = 1 TO aKTextBoxLength
        IF aKHover(id, aKTextBox, i) AND aKTextBox(i).id = id AND NOT aKTextBox(i).hidden THEN
            IF NOT RTRIM$(Mouse.icon) = "text" THEN Mouse.icon = "text": _MOUSESHOW "text"
            IF Mouse.Lclick THEN
                aKTextBox(i).active = -1
                Mouse.icon = "default": _MOUSESHOW "default"
                cursorX = 4: cursorY = aKDialog(id).Wy + aKTextBox(i).y + 3
                limit = INT(aKTextBox(i).width - 20) / 8
                IF aKStrLength(aKTextBox(i).value) > limit THEN
                    cursorX = limit * 8
                    StrPos = aKStrLength(aKTextBox(i).value)
                    StrLen = StrPos
                    tmpstr$ = RIGHT$(RTRIM$(aKTextBox(i).value), limit)
                    aKDrawObject id, aKTextBox, i
                    COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
                    _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, cursorY + 3), tmpstr$
                END IF
                IF aKStrLength(aKTextBox(i).value) > 0 AND NOT aKStrLength(aKTextBox(i).value) > limit THEN
                    cursorX = cursorX + aKStrLength(aKTextBox(i).value) * 8: StrPos = (cursorX - 4) / 8
                END IF
                IF RTRIM$(aKTextBox(i).value) <> "" THEN
                    tmpstr2$ = RTRIM$(aKTextBox(i).value)
                END IF
                StrLen = aKStrLength(aKTextBox(i).value)
                s1 = limit: s2 = 0
                DO
                    k$ = INKEY$
                    Mouse.movement = _MOUSEINPUT
                    IF Mouse.movement THEN
                        Mouse.x = _MOUSEX: Mouse.y = _MOUSEY: Mouse.Lclick = _MOUSEBUTTON(1): Mouse.Rclick = _MOUSEBUTTON(2)
                        IF NOT aKHover(id, aKTextBox, i) AND Mouse.Lclick THEN
                            aKTextBox(i).active = 0
                            aKDrawObject id, aKTextBox, i
                            IF NOT RTRIM$(aKTextBox(i).value) = "" THEN
                                COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
                                IF NOT aKTextBox(i).typ = aKPassword THEN _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, cursorY + 3), LEFT$(aKTextBox(i).value, limit) ELSE _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, cursorY + 3), LEFT$(tmpstr$, limit)
                            END IF
                            EXIT SUB
                        END IF
                    END IF
                    IF k$ <> "" THEN
                        SELECT CASE k$
                            CASE CHR$(0) + CHR$(75)
                                IF StrPos > 0 THEN
                                    IF NOT StrLen > limit THEN
                                        aKDrawObject id, aKTextBox, i
                                        StrPos = StrPos - 1
                                        cursorX = cursorX - 8
                                    END IF
                                END IF
                            CASE CHR$(0) + CHR$(77)
                                IF StrPos < StrLen THEN
                                    IF NOT StrPos > limit THEN
                                        aKDrawObject id, aKTextBox, i
                                        StrPos = StrPos + 1
                                        cursorX = cursorX + 8
                                    END IF
                                END IF
                            CASE CHR$(13)
                                aKTextBox(i).active = 0
                                aKDrawObject id, aKTextBox, i
                                _DISPLAY
                                EXIT FOR
                            CASE CHR$(8)
                                IF StrPos = StrLen AND StrPos > 0 THEN
                                    tmpstr$ = LEFT$(tmpstr2$, LEN(tmpstr2$) - 1)
                                    tmpstr2$ = tmpstr$
                                    aKTextBox(i).value = tmpstr2$
                                    aKDrawObject id, aKTextBox, i
                                    cursorX = cursorX - 8
                                    StrPos = StrPos - 1
                                    StrLen = StrLen - 1
                                    IF StrLen > limit - 1 THEN tmpstr$ = RIGHT$(tmpstr2$, limit): cursorX = cursorX + 8
                                ELSEIF StrPos > 0 AND StrPos < StrLen THEN
                                    tmpstr$ = LEFT$(tmpstr2$, StrPos - 1) + MID$(tmpstr2$, StrPos + 1, StrLen - StrPos)
                                    tmpstr2$ = tmpstr$
                                    aKTextBox(i).value = tmpstr2$
                                    aKDrawObject id, aKTextBox, i
                                    cursorX = cursorX - 8
                                    StrPos = StrPos - 1
                                    StrLen = StrLen - 1
                                END IF
                            CASE ELSE
                                IF StrPos = StrLen THEN
                                    tmpstr$ = tmpstr2$ + k$
                                    tmpstr2$ = tmpstr$
                                    aKTextBox(i).value = tmpstr2$
                                    aKDrawObject id, aKTextBox, i
                                    cursorX = cursorX + 8
                                    StrPos = StrPos + 1
                                    StrLen = StrLen + 1
                                    IF StrLen > limit THEN tmpstr$ = RIGHT$(tmpstr$, limit): cursorX = cursorX - 8: s1 = s1 + 1
                                ELSEIF StrPos = 0 THEN
                                    tmpstr$ = k$ + tmpstr2$
                                    tmpstr2$ = tmpstr$
                                    aKTextBox(i).value = tmpstr2$
                                    aKDrawObject id, aKTextBox, i
                                    cursorX = cursorX + 8
                                    StrPos = StrPos + 1
                                    StrLen = StrLen + 1
                                ELSE
                                    tmpstr$ = LEFT$(tmpstr2$, StrPos) + k$ + MID$(tmpstr2$, StrPos + 1, StrLen - StrPos)
                                    tmpstr2$ = tmpstr$
                                    aKTextBox(i).value = tmpstr2$
                                    aKDrawObject id, aKTextBox, i
                                    cursorX = cursorX + 8
                                    StrPos = StrPos + 1
                                    StrLen = StrLen + 1
                                    IF StrLen > limit THEN tmpstr$ = MID$(tmpstr2$, LEN(tmpstr2$) - limit, s2)
                                END IF
                        END SELECT
                        COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
                        IF aKTextBox(i).typ = aKPassword THEN tmpstr$ = STRING$(LEN(tmpstr$), "*")
                        _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, cursorY + 3), tmpstr$
                    END IF

                    LINE (aKDialog(id).Wx + aKTextBox(i).x + cursorX, cursorY)-(aKDialog(id).Wx + aKTextBox(i).x + cursorX, cursorY + 18), cursor&

                    IF TIMER > start! + .3 THEN
                        start! = TIMER
                        IF cursor& = _RGB(255, 255, 255) THEN cursor& = _RGB(0, 0, 0) ELSE cursor& = _RGB(255, 255, 255)
                    END IF
                    _DISPLAY
                LOOP
            END IF
            IF NOT aKTextBox(i).react THEN LINE (aKDialog(id).Wx + aKTextBox(i).x, aKDialog(id).Wy + aKTextBox(i).y)-(aKDialog(id).Wx + aKTextBox(i).x + aKTextBox(i).width, aKDialog(id).Wy + aKTextBox(i).y + 25), _RGB(0, 0, 255), B: aKTextBox(i).react = -1
        ELSE
            IF RTRIM$(Mouse.icon) = "text" AND NOT aKAnyHover(id, aKTextBox) AND aKTextBox(i).id = id THEN Mouse.icon = "default": _MOUSESHOW "default"
            IF aKTextBox(i).react THEN LINE (aKDialog(id).Wx + aKTextBox(i).x, aKDialog(id).Wy + aKTextBox(i).y)-(aKDialog(id).Wx + aKTextBox(i).x + aKTextBox(i).width, aKDialog(id).Wy + aKTextBox(i).y + 25), _RGB(0, 0, 0), B: aKTextBox(i).react = 0
        END IF
    NEXT

    'displaying options when user click combo box
    FOR i = 1 TO aKComboBoxLength
        IF aKHover(id, aKComboBox, i) AND aKComboBox(i).id = id AND NOT aKComboBox(i).hidden THEN
            IF aKClick(id, aKComboBox, i) THEN
                IF aKComboBox(i).active THEN aKComboBox(i).active = 0: EXIT FOR
                aKComboBox(i).active = -1
                o$ = RTRIM$(aKComboBox(i).options)
                l = 1 ' this loop will calculate dropdown menu height and width in l and g variable
                'use commas to separate your options
                optionsBg = _COPYIMAGE(0)
                FOR n = 1 TO LEN(o$)
                    ca$ = MID$(o$, n, 1)
                    c = c + 1
                    IF ca$ = "," THEN l = l + 1: c = 0
                    IF g < c THEN g = c
                NEXT
                dx = (g * 8 + 10) / 2 'dropdown width
                dy = l * 15 + 10 'dropdown height
                'holding options into array
                c = 0: o = 1: p = 1: a = 0
                DIM options(l) AS STRING, optionsY(l)
                FOR n = 1 TO LEN(o$)
                    ca$ = MID$(o$, n, 1)
                    IF ca$ = "," THEN o = o + 1: ca$ = ""
                    options(o) = options(o) + ca$
                NEXT
                FOR n = 1 TO l
                    optionsY(n) = aKDialog(id).Wy + aKComboBox(i).y + a + 28
                    a = a + 15
                NEXT
                FOR n = 1 TO dy
                    LINE (aKComboBox(i).x + aKDialog(id).Wx, aKComboBox(i).y + aKDialog(id).Wy + 23)-(aKComboBox(i).x + aKDialog(id).Wx + dx + aKStrLength(aKComboBox(i).value) * 8 + 30, aKComboBox(i).y + aKDialog(id).Wy + n + 23), _RGB(255, 255, 255), BF
                    LINE (aKComboBox(i).x + aKDialog(id).Wx, aKComboBox(i).y + aKDialog(id).Wy + 23)-(aKComboBox(i).x + aKDialog(id).Wx + dx + aKStrLength(aKComboBox(i).value) * 8 + 30, aKComboBox(i).y + aKDialog(id).Wy + n + 23), _RGB(0, 0, 0), B
                    _DISPLAY
                NEXT
                FOR n = 1 TO l
                    COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
                    _PRINTSTRING (aKComboBox(i).x + aKDialog(id).Wx + 5, optionsY(n)), options(n)
                NEXT
                DO
                    aKCheck id
                    aKUpdate id
                    IF aKDialog(id).closed THEN EXIT DO
                    IF NOT aKComboBox(i).active THEN _PUTIMAGE , optionsBg: EXIT DO
                    IF Mouse.x < aKComboBox(i).x + aKDialog(id).Wx AND Mouse.Lclick OR Mouse.x > aKComboBox(i).x + aKDialog(id).Wx + aKStrLength(aKComboBox(i).value) * 8 + 30 AND Mouse.Lclick AND Mouse.y < aKComboBox(i).y + aKDialog(id).Wy + 23 OR Mouse.y < aKComboBox(i).y + aKDialog(id).Wy AND Mouse.Lclick OR Mouse.y > aKComboBox(i).y + aKDialog(id).Wy + dy + 23 AND Mouse.Lclick OR Mouse.x > aKComboBox(i).x + aKDialog(id).Wx + dx + aKStrLength(aKComboBox(i).value) * 8 + 30 AND Mouse.y > aKComboBox(i).y + aKDialog(id).Wy + 23 AND Mouse.Lclick THEN _PUTIMAGE , optionsBg: aKComboBox(i).active = 0: EXIT DO
                    FOR n = 1 TO l
                        IF Mouse.x > aKComboBox(i).x + aKDialog(id).Wx AND Mouse.y > optionsY(n) AND Mouse.x < aKComboBox(i).x + aKDialog(id).Wx + dx + aKStrLength(aKComboBox(i).value) * 8 + 30 AND Mouse.y < optionsY(n) + 15 THEN
                            IF Mouse.Lclick THEN
                                _PUTIMAGE , optionsBg: aKComboBox(i).active = 0
                                COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
                                LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(230, 230, 230), BF
                                aKComboBox(i).value = options(n)
                                LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(255, 255, 255), BF
                                LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 0), B
                                LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(180, 180, 180), BF
                                LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 0), B
                                _PRINTSTRING (aKDialog(id).Wx + aKComboBox(i).x + 5, aKDialog(id).Wy + aKComboBox(i).y + 5), RTRIM$(aKComboBox(i).value)
                                COLOR , _RGBA(0, 0, 0, 0)
                                _PRINTSTRING (aKDialog(id).Wx + aKComboBox(i).x + 19 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 6), CHR$(31)
                                optionsBg = _COPYIMAGE(0)
                                _PUTIMAGE , optionsBg
                                EXIT DO
                            END IF
                            LINE (aKComboBox(i).x + aKDialog(id).Wx + 1, optionsY(n))-(aKComboBox(i).x + aKDialog(id).Wx + dx + aKStrLength(aKComboBox(i).value) * 8 + 30 - 1, optionsY(n) + 15), _RGB(0, 0, 255), BF
                            COLOR _RGB(255, 255, 255), _RGB(0, 0, 255)
                            _PRINTSTRING (aKComboBox(i).x + aKDialog(id).Wx + 5, optionsY(n)), options(n)
                        ELSE
                            LINE (aKComboBox(i).x + aKDialog(id).Wx + 1, optionsY(n))-(aKComboBox(i).x + aKDialog(id).Wx + dx + aKStrLength(aKComboBox(i).value) * 8 + 30 - 1, optionsY(n) + 15), _RGB(255, 255, 255), BF
                            COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
                            _PRINTSTRING (aKComboBox(i).x + aKDialog(id).Wx + 5, optionsY(n)), options(n)
                        END IF
                    NEXT
                    _DISPLAY
                LOOP
            END IF
            IF NOT aKComboBox(i).react THEN
                LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 255), B
                LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(229, 241, 255), BF
                LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 255), B
                COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                _PRINTSTRING (aKDialog(id).Wx + aKComboBox(i).x + 19 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 6), CHR$(31)
                aKComboBox(i).react = -1
            END IF
        ELSE
            IF aKComboBox(i).react THEN
                LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 0), B
                LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(180, 180, 180), BF
                LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 0), B
                COLOR _RGB(0, 0, 0), _RGBA(0, 0, 0, 0)
                _PRINTSTRING (aKDialog(id).Wx + aKComboBox(i).x + 19 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 6), CHR$(31)
                aKComboBox(i).react = 0
            END IF
        END IF
    NEXT
END IF


END SUB

SUB aKHideDialog (id)

_PUTIMAGE , aKDialog(id).background
aKDialog(id).shown = 0: aKDialog(id).closed = -1
END SUB

FUNCTION aKClick (id, typ, object)

SELECT CASE typ
    CASE aKLabel
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKButton
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKCheckBox
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKRadioButton
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKLinkLabel
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKComboBox
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKNumericUpDown
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKTextBox
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE aKPicture
        IF aKHover(id, typ, object) AND Mouse.Lclick THEN aKClick = -1
    CASE ELSE
        aKError "aKClick", 254
END SELECT
END FUNCTION

FUNCTION aKHover (id, typ, object)

SELECT CASE typ
    CASE aKLabel
        IF Mouse.x > aKLabel(object).x + aKDialog(id).Wx AND Mouse.y > aKLabel(object).y + aKDialog(id).Wy AND Mouse.x < aKLabel(object).x + aKDialog(id).Wx + aKStrLength(aKLabel(object).text) * 8 AND Mouse.y < aKLabel(object).y + aKDialog(id).Wy + 15 THEN aKHover = -1
    CASE aKButton
        IF Mouse.x > aKButton(object).x + aKDialog(id).Wx AND Mouse.y > aKButton(object).y + aKDialog(id).Wy AND Mouse.x < aKButton(object).x + aKDialog(id).Wx + aKStrLength(aKButton(object).value) * 7.5 + 20 AND Mouse.y < aKButton(object).y + aKDialog(id).Wy + 23 THEN aKHover = -1
    CASE aKCheckBox
        IF Mouse.x > aKCheckBox(object).x + aKDialog(id).Wx AND Mouse.y > aKCheckBox(object).y + aKDialog(id).Wy AND Mouse.x < aKCheckBox(object).x + aKDialog(id).Wx + aKStrLength(aKCheckBox(object).text) * 8 + 20 AND Mouse.y < aKCheckBox(object).y + aKDialog(id).Wy + 15 THEN aKHover = -1
    CASE aKRadioButton
        IF Mouse.x > aKRadioButton(object).x + aKDialog(id).Wx AND Mouse.y > aKRadioButton(object).y + aKDialog(id).Wy AND Mouse.x < aKRadioButton(object).x + aKDialog(id).Wx + aKStrLength(aKRadioButton(object).text) * 8 + 20 AND Mouse.y < aKRadioButton(object).y + aKDialog(id).Wy + 15 THEN aKHover = -1
    CASE aKLinkLabel
        IF Mouse.x > aKLinkLabel(object).x + aKDialog(id).Wx AND Mouse.y > aKLinkLabel(object).y + aKDialog(id).Wy AND Mouse.x < aKLinkLabel(object).x + aKDialog(id).Wx + aKStrLength(aKLinkLabel(object).text) * 8 AND Mouse.y < aKLinkLabel(object).y + aKDialog(id).Wy + 18 THEN aKHover = -1
    CASE aKComboBox
        IF Mouse.x > aKComboBox(object).x + aKDialog(id).Wx AND Mouse.y > aKComboBox(object).y + aKDialog(id).Wy AND Mouse.x < aKComboBox(object).x + aKDialog(id).Wx + aKStrLength(aKComboBox(object).value) * 8 + 30 AND Mouse.y < aKComboBox(object).y + aKDialog(id).Wy + 23 THEN aKHover = -1
    CASE aKTextBox
        IF Mouse.x > aKTextBox(object).x + aKDialog(id).Wx AND Mouse.y > aKTextBox(object).y + aKDialog(id).Wy AND Mouse.x < aKTextBox(object).x + aKDialog(id).Wx + aKTextBox(object).width AND Mouse.y < aKTextBox(object).y + aKDialog(id).Wy + 25 THEN aKHover = -1
    CASE aKNumericUpDown
        IF Mouse.x > aKNumericUpDown(object).x + aKDialog(id).Wx AND Mouse.y > aKNumericUpDown(object).y + aKDialog(id).Wy AND Mouse.x < aKNumericUpDown(object).x + aKDialog(id).Wx + aKNumericUpDown(object).width + 30 AND Mouse.y < aKNumericUpDown(object).y + aKDialog(id).Wy + 25 THEN aKHover = -1
    CASE aKPicture
        IF Mouse.x > aKPicture(object).x + aKDialog(id).Wx AND Mouse.x < aKPicture(object).x + aKPicture(object).width + aKDialog(id).Wx AND Mouse.y > aKPicture(object).y + aKDialog(id).Wy AND Mouse.y < aKPicture(object).y + aKPicture(object).height + aKDialog(id).Wy THEN aKHover = -1
    CASE ELSE
        aKError "aKHover", 254
END SELECT
END FUNCTION


SUB akUpdateProgress (object, value)
aKProgressBar(object).value = value
aKProgressBar(object).active = True
END SUB



FUNCTION aKAnyHover (id, typ)
SELECT CASE typ
    CASE aKLabel
        FOR i = 1 TO aKlabelLength
            IF aKHover(id, typ, i) AND aKLabel(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKLinkLabel
        FOR i = 1 TO aKLinklabelLength
            IF aKHover(id, typ, i) AND aKLinkLabel(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKTextBox
        FOR i = 1 TO aKTextBoxLength
            IF aKHover(id, typ, i) AND aKTextBox(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKPicture
        FOR i = 1 TO aKPictureLength
            IF aKHover(id, typ, i) AND aKPicture(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKComboBox
        FOR i = 1 TO aKComboBoxLength
            IF aKHover(id, typ, i) AND aKComboBox(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKRadioButton
        FOR i = 1 TO aKRadioLength
            IF aKHover(id, typ, i) AND aKRadioButton(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKCheckBox
        FOR i = 1 TO aKCheckBoxLength
            IF aKHover(id, typ, i) AND aKCheckBox(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKNumericUpDown
        FOR i = 1 TO aKNumericUDLength
            IF aKHover(id, typ, i) AND aKNumericUpDown(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE aKPicture
        FOR i = 1 TO aKPictureLength
            IF aKHover(id, typ, i) AND aKPicture(i).id = id THEN aKAnyHover = -1
        NEXT
    CASE ELSE
        aKError "aKAnyHover", 254
END SELECT
END FUNCTION

FUNCTION aKDialogClose (id)
IF aKDialog(id).closed OR NOT aKDialog(id).shown THEN aKDialogClose = -1 ELSE aKDialogClose = 0
END FUNCTION

FUNCTION aKGetValue$ (typ, object)
i = object
SELECT CASE typ
    CASE aKTextBox
        aKGetValue = RTRIM$(aKTextBox(i).value)
    CASE aKCheckBox
        IF aKCheckBox(i).checked THEN aKGetValue$ = RTRIM$(aKCheckBox(i).text) ELSE aKGetValue = ""
    CASE aKComboBox
        aKGetValue = RTRIM$(aKComboBox(i).value)
    CASE aKNumericUpDown
        aKGetValue = LTRIM$(RTRIM$(STR$(aKNumericUpDown(i).value)))
    CASE aKButton
        aKGetValue = LTRIM$(RTRIM$(aKButton(i).value))
    CASE aKLabel
        aKGetValue = LTRIM$(RTRIM$(aKLabel(i).text))
    CASE aKLinkLabel
        aKGetValue = LTRIM$(RTRIM$(aKLinkLabel(i).text))
    CASE ELSE
        aKError "aKGetValue$", 254
END SELECT
END FUNCTION

FUNCTION aKGetRadioValue$ (id, GroupId)
g = GroupId
FOR i = 1 TO aKRadioLength
    IF aKRadioButton(i).id = id AND aKRadioButton(i).groupId = g AND aKRadioButton(i).checked THEN aKGetRadioValue = RTRIM$(aKRadioButton(i).text)
NEXT
END FUNCTION

SUB aKEraseObject (id, typ, object)
i = object
IF aKDialogClose(id) THEN aKError "aKEraseObject()", 256
IF tooltipBg THEN _PUTIMAGE , tooltipBg
SELECT CASE typ
    CASE aKLabel
        LINE (aKDialog(id).Wx + aKLabel(i).x, aKDialog(id).Wy + aKLabel(i).y)-(aKDialog(id).Wx + aKLabel(i).x + aKStrLength(aKLabel(i).text) * 8, aKDialog(id).Wy + aKLabel(i).y + 20), _RGB(230, 230, 230), BF
        aKLabel(i).hidden = -1
    CASE aKButton
        LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 8 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(230, 230, 230), BF
        aKButton(i).hidden = -1
    CASE aKCheckBox
        LINE (aKDialog(id).Wx + aKCheckBox(i).x, aKDialog(id).Wy + aKCheckBox(i).y)-(aKDialog(id).Wx + aKCheckBox(i).x + aKStrLength(aKCheckBox(i).text) * 8 + 20, aKDialog(id).Wy + aKCheckBox(i).y + 20), _RGB(230, 230, 230), BF
        aKCheckBox(i).hidden = -1
    CASE aKRadioButton
        LINE (aKDialog(id).Wx + aKRadioButton(i).x, aKDialog(id).Wy + aKRadioButton(i).y)-(aKDialog(id).Wx + aKRadioButton(i).x + aKStrLength(aKRadioButton(i).text) * 8 + 20, aKDialog(id).Wy + aKRadioButton(i).y + 20), _RGB(230, 230, 230), BF
        aKRadioButton(i).hidden = -1
    CASE aKLinkLabel
        LINE (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y)-(aKDialog(id).Wx + aKLinkLabel(i).x + aKStrLength(aKLinkLabel(i).text) * 8, aKDialog(id).Wy + aKLinkLabel(i).y + 20), _RGB(230, 230, 230), BF
        aKLinkLabel(i).hidden = -1
    CASE aKComboBox
        LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + aKStrLength(aKComboBox(i).value) * 8 + 30, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(230, 230, 230), BF
        aKComboBox(i).hidden = -1
    CASE aKTextBox
        LINE (aKDialog(id).Wx + aKTextBox(i).x, aKDialog(id).Wy + aKTextBox(i).y)-(aKDialog(id).Wx + aKTextBox(i).x + aKTextBox(i).width, aKDialog(id).Wy + aKTextBox(i).y + 25), _RGB(230, 230, 230), BF
        aKTextBox(i).hidden = -1
    CASE aKNumericUpDown
        LINE (aKDialog(id).Wx + aKNumericUpDown(i).x, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(230, 230, 230), BF
        aKNumericUpDown(i).hidden = -1
    CASE aKProgressBar
        LINE (aKDialog(id).Wx + aKProgressBar(i).x, aKDialog(id).Wy + aKProgressBar(i).y)-(aKDialog(id).Wx + aKProgressBar(i).x + aKProgressBar(i).width, aKDialog(id).Wy + aKProgressBar(i).y + 20), _RGB(230, 230, 230), BF
        aKProgressBar(i).hidden = -1
    CASE aKPicture
        LINE (aKDialog(id).Wx + aKPicture(i).x - 1, aKDialog(id).Wy + aKPicture(i).y - 1)-(aKDialog(id).Wx + aKPicture(i).x + aKPicture(i).width + 1, aKDialog(id).Wy + aKPicture(i).y + aKPicture(i).height + 1), _RGB(230, 230, 230), BF
        aKPicture(i).hidden = -1
    CASE aKDivider
        IF aKDivider(i).typ = aKVertical THEN
            LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).x + aKDivider(i).size, aKDialog(id).Wy + aKDivider(i).y + 1), _RGB(230, 230, 230), BF
        ELSEIF aKDivider(i).typ = aKHorizontal THEN
            LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).x + 1, aKDialog(id).Wy + aKDivider(i).y + aKDivider(i).size), _RGB(230, 230, 230), BF
        END IF
        aKDivider(i).hidden = -1
    CASE aKPanel
        LINE (aKDialog(id).Wx + aKPanel(i).x, aKDialog(id).Wy + aKPanel(i).y - 6)-(aKDialog(id).Wx + aKPanel(i).x + aKPanel(i).width + 1, aKDialog(id).Wy + aKPanel(i).y + aKPanel(i).height + 1), _RGB(230, 230, 230), BF
        aKPanel(i).hidden = -1
    CASE ELSE
        aKError "aKEraseObject", 254
END SELECT
IF tooltipBg THEN tooltipBg = _COPYIMAGE(0)
END SUB

SUB aKDrawObject (id, typ, object)
i = object
IF aKDialog(id).closed THEN aKError "aKDrawObject()", 256

SELECT CASE typ
    CASE aKLabel
        COLOR _RGB(0, 0, 0), _RGB(230, 230, 230)
        _PRINTSTRING (aKDialog(id).Wx + aKLabel(i).x, aKDialog(id).Wy + aKLabel(i).y), RTRIM$(aKLabel(i).text)
        IF aKLabel(i).hidden THEN aKLabel(i).hidden = 0
    CASE aKButton
        COLOR _RGB(0, 0, 0), _RGB(180, 180, 180)
        LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 7.5 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(180, 180, 180), BF
        LINE (aKDialog(id).Wx + aKButton(i).x, aKDialog(id).Wy + aKButton(i).y)-(aKDialog(id).Wx + aKButton(i).x + aKStrLength(aKButton(i).value) * 7.5 + 20, aKDialog(id).Wy + aKButton(i).y + 23), _RGB(0, 0, 0), B
        _PRINTSTRING (aKDialog(id).Wx + aKButton(i).x + 10, aKDialog(id).Wy + aKButton(i).y + 5), RTRIM$(aKButton(i).value)
        IF aKButton(i).hidden THEN aKButton(i).hidden = 0
    CASE aKCheckBox
        COLOR _RGB(0, 0, 0), _RGB(230, 230, 230)
        LINE (aKDialog(id).Wx + aKCheckBox(i).x, aKDialog(id).Wy + aKCheckBox(i).y)-(aKDialog(id).Wx + aKCheckBox(i).x + 12, aKDialog(id).Wy + aKCheckBox(i).y + 12), _RGB(255, 255, 255), BF
        LINE (aKDialog(id).Wx + aKCheckBox(i).x, aKDialog(id).Wy + aKCheckBox(i).y)-(aKDialog(id).Wx + aKCheckBox(i).x + 12, aKDialog(id).Wy + aKCheckBox(i).y + 12), _RGB(0, 0, 0), B
        _PRINTSTRING (aKDialog(id).Wx + aKCheckBox(i).x + 20, aKDialog(id).Wy + aKCheckBox(i).y), RTRIM$(aKCheckBox(i).text)
        IF aKCheckBox(i).checked THEN LINE (aKCheckBox(i).x + aKDialog(id).Wx + 3, aKCheckBox(i).y + aKDialog(id).Wy + 3)-(aKCheckBox(i).x + aKDialog(id).Wx + 9, aKCheckBox(i).y + aKDialog(id).Wy + 9), _RGB(0, 0, 0), BF
        IF aKCheckBox(i).hidden THEN aKCheckBox(i).hidden = 0
    CASE aKRadioButton
        COLOR _RGB(0, 0, 0), _RGB(230, 230, 230)
        CIRCLE (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), 5, _RGB(0, 0, 0)
        PAINT (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), _RGB(255, 255, 255), _RGB(0, 0, 0)
        _PRINTSTRING (aKDialog(id).Wx + aKRadioButton(i).x + 18, aKDialog(id).Wy + aKRadioButton(i).y), RTRIM$(aKRadioButton(i).text)
        IF aKRadioButton(i).checked THEN CIRCLE (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), 3, _RGB(8, 8, 8): PAINT (aKDialog(id).Wx + aKRadioButton(i).x + 5, aKDialog(id).Wy + aKRadioButton(i).y + 7), _RGB(8, 8, 8), _RGB(8, 8, 8)
        IF aKRadioButton(i).hidden THEN aKRadioButton(i).hidden = 0
    CASE aKLinkLabel
        COLOR _RGB(0, 0, 255), _RGB(230, 230, 230)
        _PRINTSTRING (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y), RTRIM$(aKLinkLabel(i).text)
        LINE (aKDialog(id).Wx + aKLinkLabel(i).x, aKDialog(id).Wy + aKLinkLabel(i).y + 14)-(aKDialog(id).Wx + aKLinkLabel(i).x + aKStrLength(aKLinkLabel(i).text) * 8, aKDialog(id).Wy + aKLinkLabel(i).y + 14), _RGB(0, 0, 255)
        IF aKLinkLabel(i).hidden THEN aKLinkLabel(i).hidden = 0
    CASE aKNumericUpDown
        COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
        LINE (aKDialog(id).Wx + aKNumericUpDown(i).x, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(255, 255, 255), BF
        LINE (aKDialog(id).Wx + aKNumericUpDown(i).x, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(0, 0, 0), B
        _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + 5, aKDialog(id).Wy + aKNumericUpDown(i).y + 6), LTRIM$(RTRIM$(STR$(aKNumericUpDown(i).value)))
        LINE (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 10, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(180, 180, 180), BF
        LINE (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 10, aKDialog(id).Wy + aKNumericUpDown(i).y)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 25), _RGB(0, 0, 0), B
        LINE (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 10, aKDialog(id).Wy + aKNumericUpDown(i).y + 13)-(aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 30, aKDialog(id).Wy + aKNumericUpDown(i).y + 13)
        COLOR , _RGBA(0, 0, 0, 0)
        _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y - 1), CHR$(30)
        _PRINTSTRING (aKDialog(id).Wx + aKNumericUpDown(i).x + aKNumericUpDown(i).width + 17, aKDialog(id).Wy + aKNumericUpDown(i).y + 13), CHR$(31)
        IF aKNumericUpDown(i).hidden THEN aKNumericUpDown(i).hidden = 0
    CASE aKComboBox
        COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
        LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(255, 255, 255), BF
        LINE (aKDialog(id).Wx + aKComboBox(i).x, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 0), B
        LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(180, 180, 180), BF
        LINE (aKDialog(id).Wx + aKComboBox(i).x + 15 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y)-(aKDialog(id).Wx + aKComboBox(i).x + 30 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 23), _RGB(0, 0, 0), B
        _PRINTSTRING (aKDialog(id).Wx + aKComboBox(i).x + 5, aKDialog(id).Wy + aKComboBox(i).y + 5), RTRIM$(aKComboBox(i).value)
        COLOR , _RGBA(0, 0, 0, 0)
        _PRINTSTRING (aKDialog(id).Wx + aKComboBox(i).x + 19 + aKStrLength(aKComboBox(i).value) * 8, aKDialog(id).Wy + aKComboBox(i).y + 6), CHR$(31)
        IF aKComboBox(i).hidden THEN aKComboBox(i).hidden = 0
    CASE aKPicture
        _PUTIMAGE (aKDialog(id).Wx + aKPicture(i).x, aKDialog(id).Wy + aKPicture(i).y)-(aKDialog(id).Wx + aKPicture(i).x + aKPicture(i).width, aKDialog(id).Wy + aKPicture(i).y + aKPicture(i).height), aKPicture(i).img
        LINE (aKDialog(id).Wx + aKPicture(i).x - 1, aKDialog(id).Wy + aKPicture(i).y - 1)-(aKDialog(id).Wx + aKPicture(i).x + aKPicture(i).width + 1, aKDialog(id).Wy + aKPicture(i).y + aKPicture(i).height + 1), _RGB(0, 0, 0), B
        IF aKPicture(i).hidden THEN aKPicture(i).hidden = 0
    CASE aKPanel
        COLOR _RGB(0, 0, 0), _RGB(230, 230, 230)
        LINE (aKDialog(id).Wx + aKPanel(i).x + 1, aKDialog(id).Wy + aKPanel(i).y + 1)-(aKDialog(id).Wx + aKPanel(i).x + aKPanel(i).width + 1, aKDialog(id).Wy + aKPanel(i).y + aKPanel(i).height + 1), _RGB(255, 255, 255), B
        LINE (aKDialog(id).Wx + aKPanel(i).x, aKDialog(id).Wy + aKPanel(i).y)-(aKDialog(id).Wx + aKPanel(i).x + aKPanel(i).width, aKDialog(id).Wy + aKPanel(i).y + aKPanel(i).height), _RGB(150, 150, 150), B
        _PRINTSTRING (aKDialog(id).Wx + aKPanel(i).x + 10, aKDialog(id).Wy + aKPanel(i).y - 6), RTRIM$(aKPanel(i).title)
        IF aKPanel(i).hidden THEN aKPanel(i).hidden = 0
    CASE aKProgressBar
        LINE (aKDialog(id).Wx + aKProgressBar(i).x, aKDialog(id).Wy + aKProgressBar(i).y)-(aKDialog(id).Wx + aKProgressBar(i).x + aKProgressBar(i).width, aKDialog(id).Wy + aKProgressBar(i).y + 20), _RGB(210, 210, 210), BF
        LINE (aKDialog(id).Wx + aKProgressBar(i).x, aKDialog(id).Wy + aKProgressBar(i).y)-(aKDialog(id).Wx + aKProgressBar(i).x + aKProgressBar(i).width, aKDialog(id).Wy + aKProgressBar(i).y + 20), _RGB(0, 0, 0), B
        px = aKProgressBar(i).width - 2
        ps& = _NEWIMAGE(px, 19, 32)
        _DEST ps&
        LINE (0, 0)-(px, 19), _RGB(0, 155, 0), BF
        FOR n = -px TO px STEP 10
            LINE (n, 0)-(n + px, 400), _RGB(0, 255, 0)
        NEXT

        FOR n = -px TO px STEP 20
            PAINT (n + 2, 1), _RGB(0, 255, 0), _RGB(0, 255, 0)
            PAINT (n + 5, 18), _RGB(0, 255, 0), _RGB(0, 255, 0)
        NEXT
        aKProgressBar(i).bar = ps&
        IF aKProgressBar(i).hidden THEN aKProgressBar(i).hidden = 0
    CASE aKDivider
        IF aKDivider(i).typ = aKVertical THEN
            IF aKDialog(id).Wx + aKDivider(i).x + aKDivider(i).size >= aKDialog(id).Wx + aKDialog(i).width THEN
                LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDialog(id).width - 1, aKDialog(id).Wy + aKDivider(i).y), _RGB(150, 150, 150)
                LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y + 1)-(aKDialog(id).Wx + aKDialog(id).width - 1, aKDialog(id).Wy + aKDivider(i).y + 1), _RGB(255, 255, 255)
            ELSE
                LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).size, aKDialog(id).Wy + aKDivider(i).y), _RGB(150, 150, 150)
                LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y + 1)-(aKDialog(id).Wx + aKDivider(i).size, aKDialog(id).Wy + aKDivider(i).y + 1), _RGB(255, 255, 155)
            END IF
        ELSEIF aKDivider(i).typ = aKHorizontal THEN
            IF aKDialog(id).Wy + aKDivider(i).y + aKDivider(i).size >= aKDialog(id).Wy + aKDialog(i).height - 20 THEN
                LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDialog(i).height - 26), _RGB(170, 170, 170)
                LINE (aKDialog(id).Wx + aKDivider(i).x + 1, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).x + 1, aKDialog(id).Wy + aKDialog(i).height - 26), _RGB(255, 255, 255)
            ELSE
                LINE (aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).x, aKDialog(id).Wy + aKDivider(i).size), _RGB(150, 150, 150)
                LINE (aKDialog(id).Wx + aKDivider(i).x + 1, aKDialog(id).Wy + aKDivider(i).y)-(aKDialog(id).Wx + aKDivider(i).x + 1, aKDialog(id).Wy + aKDivider(i).size), _RGB(255, 255, 255)
            END IF
        END IF
        IF aKDivider(i).hidden THEN aKDivider(i).hidden = 0
    CASE aKTooltip
        g = 0: c = 0: ca$ = "": l = 1
        FOR n = 1 TO aKStrLength(aKTooltip(i).text)
            c = c + 1
            ca$ = MID$(aKTooltip(i).text, n, 1)
            IF ca$ = "\" AND UCASE$(MID$(aKTooltip(i).text, n + 1, 1)) = "N" THEN l = l + 1: c = 0
            IF g < c THEN g = c
        NEXT
        ty = l * 15 + 18
        tx = g * 8 + 16
        ts& = _NEWIMAGE(tx, ty, 32) 'saving tooltip as image
        _DEST ts&
        LINE (0, 0)-(tx, ty), _RGB(200, 0, 0), BF
        roundBox 6, 3, tx - 12, ty - 6, 3, _RGB(255, 255, 255)
        PAINT (8, 5), _RGB(0, 0, 0), _RGB(255, 255, 255)
        COLOR _RGB(255, 255, 255), _RGB(0, 0, 0)
        yy = 10: xx = 10
        FOR n = 1 TO aKStrLength(aKTooltip(i).text)
            ca$ = MID$(aKTooltip(i).text, n, 1)
            IF c > 50 THEN yy = yy + 10
            IF ca$ = "\" AND UCASE$(MID$(aKTooltip(i).text, n + 1, 1)) = "N" THEN yy = yy + 15: xx = 10: ca$ = "": xx = xx - 8
            IF UCASE$(ca$) = "N" AND MID$(aKTooltip(i).text, n - 1, 1) = "\" THEN ca$ = "": xx = xx - 8
            _PRINTSTRING (xx, yy), ca$
            xx = xx + 8
        NEXT
        _CLEARCOLOR _RGB(200, 0, 0), ts&
        aKTooltip(i).content = _COPYIMAGE(ts&)
        _FREEIMAGE ts&
    CASE aKTextBox
        COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
        IF aKTextBox(i).active THEN col& = _RGB(0, 0, 255) ELSE col& = _RGB(0, 0, 0)
        LINE (aKDialog(id).Wx + aKTextBox(i).x, aKDialog(id).Wy + aKTextBox(i).y)-(aKDialog(id).Wx + aKTextBox(i).x + aKTextBox(i).width, aKDialog(id).Wy + aKTextBox(i).y + 25), _RGB(255, 255, 255), BF
        LINE (aKDialog(id).Wx + aKTextBox(i).x, aKDialog(id).Wy + aKTextBox(i).y)-(aKDialog(id).Wx + aKTextBox(i).x + aKTextBox(i).width, aKDialog(id).Wy + aKTextBox(i).y + 25), col&, B
        IF RTRIM$(aKTextBox(i).value) = "" THEN COLOR _RGB(150, 150, 150): _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, aKDialog(id).Wy + aKTextBox(i).y + 6), RTRIM$(aKTextBox(i).placeholder)
        IF aKTextBox(i).active = 0 AND RTRIM$(aKTextBox(i).value) <> "" THEN
            COLOR _RGB(0, 0, 0), _RGB(255, 255, 255)
            _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, aKDialog(id).Wy + aKTextBox(i).y + 6), SPACE$(LEN(RTRIM$(aKTextBox(i).placeholder)))
            IF aKTextBox(i).typ = aKPassword THEN
                _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, aKDialog(id).Wy + aKTextBox(i).y + 6), STRING$(LEN(RTRIM$(aKTextBox(i).value)), "*")
            ELSE
                _PRINTSTRING (aKDialog(id).Wx + aKTextBox(i).x + 5, aKDialog(id).Wy + aKTextBox(i).y + 6), RTRIM$(aKTextBox(i).value)
            END IF
        END IF
        IF aKTextBox(i).hidden THEN aKTextBox(i).hidden = 0
    CASE ELSE
        aKError "aKDrawObject", 254
END SELECT
_DEST 0: _SOURCE 0
IF tooltipBg THEN tooltipBg = _COPYIMAGE(0)
END SUB

SUB aKEraseAll ()
ERASE aKDialog, aKLabel, aKButton, aKCheckBox, aKRadioButton, aKLinkLabel, aKComboBox
ERASE aKTextBox, aKNumericUpDown, aKTooltip, aKProgressBar, aKDivider, aKPanel, aKPicture

REDIM aKDialog(1) AS aKdialogType, aKDialogLength
REDIM aKLabel(1) AS aKlabelType, aKlabelLength AS INTEGER
REDIM aKButton(1) AS aKButtonType, aKButtonLength AS INTEGER
REDIM aKCheckBox(1) AS akCheckBoxType, aKCheckBoxLength AS INTEGER
REDIM aKRadioButton(1) AS akRadioButtonType, aKRadioLength AS INTEGER
REDIM aKLinkLabel(1) AS aKLinklabelType, aKLinklabelLength AS INTEGER
REDIM aKComboBox(1) AS aKComboBoxType, aKComboBoxLength AS INTEGER
REDIM aKTextBox(1) AS aKTextboxType, aKTextBoxLength AS INTEGER
REDIM aKNumericUpDown(1) AS aKNumericUpDownType, aKNumericUDLength AS INTEGER
REDIM aKProgressBar(1) AS aKProgressBarType, aKProgressBarLength AS INTEGER
REDIM aKTooltip(1) AS aKTooltipType, aKTooltipLength AS INTEGER
REDIM aKDivider(1) AS aKDividerType, aKDividerLength AS INTEGER
REDIM aKPicture(1) AS aKPictureType, aKPictureLength AS INTEGER
REDIM aKPanel(1) AS aKPanelType, aKPanelLength AS INTEGER
REDIM Mouse AS mousetype, tooltipBg AS LONG, optionsBg AS LONG

aKDialogLength = 1: aKlabelLength = 1: aKButtonLength = 1
aKCheckBoxLength = 1: aKRadioLength = 1: aKLinklabelLength = 1
aKComboBoxLength = 1: aKTextBoxLength = 1: aKNumericUDLength = 1
aKProgressBarLength = 1: aKTooltipLength = 1: aKDividerLength = 1
aKPictureLength = 1: aKPanelLength = 1

END SUB

SUB aKSetValue (typ, object, v$)
i = object
SELECT CASE typ
    CASE aKLabel
        aKLabel(i).text = v$
    CASE aKButton
        aKButton(i).value = v$
    CASE aKCheckBox
        IF UCASE$(v$) = "Y" THEN
            aKCheckBox(i).checked = -1
        ELSEIF UCASE$(v$) = "N" THEN
            aKCheckBox(i).checked = 0
        END IF
    CASE aKPanel
        aKPanel(i).title = v$
    CASE aKNumericUpDown
        aKNumericUpDown(i).value = VAL(v$)
    CASE aKTextBox
        aKTextBox(i).value = v$
    CASE aKComboBox
        aKComboBox(i).value = v$
    CASE aKLinkLabel
        aKLinkLabel(i).text = v$
    CASE ELSE
        aKError "aKSetValue", 254
END SELECT
END SUB

SUB aKSetRadioValue (id, GroupId, object)
FOR i = 1 TO aKRadioLength
    IF aKRadioButton(i).id = id AND aKRadioButton(i).groupId = GroupId AND aKRadioButton(i).checked THEN aKRadioButton(i).checked = 0
NEXT
FOR i = 1 TO aKRadioLength
    IF aKRadioButton(i).id = id AND aKRadioButton(i).groupId = GroupId AND i = object THEN aKRadioButton(i).checked = -1
NEXT
END SUB

FUNCTION aKAnyClick (id, typ)
SELECT CASE typ
    CASE aKLabel
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKLinkLabel
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKTextBox
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKPicture
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKComboBox
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKRadioButton
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKCheckBox
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKNumericUpDown
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE aKPicture
        IF aKAnyHover(id, typ) AND Mouse.Lclick THEN aKAnyClick = -1
    CASE ELSE
        aKError "aKAnyClick", 254
END SELECT
END FUNCTION



SUB aKAddTransition (id, typ$)
IF id > aKDialogLength THEN aKError "aKAddTransition", 253
aKDialog(id).transition = typ$
aKDialog(id).hasAnimation = -1
END SUB

SUB aKRunAnimation (id)
IF UCASE$(RTRIM$(aKDialog(id).transition)) = "FADEBLACK" THEN
    'uses an image in fading screen by changing its opacity
    tmpImg& = _NEWIMAGE(_WIDTH, _HEIGHT, 32)
    _DEST tmpImg&: LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB(0, 0, 0), BF: _DEST 0
    _SETALPHA 0, , tmpImg&
    FOR i = 0 TO 125
        _PUTIMAGE , aKDialog(id).background
        _PUTIMAGE , tmpImg&
        _SETALPHA i, , tmpImg&
        _DISPLAY
    NEXT
    _FREEIMAGE tmpImg&
ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "FADEWHITE" THEN
    'uses an image in fading screen by changing its opacity
    tmpImg& = _NEWIMAGE(_WIDTH, _HEIGHT, 32)
    _DEST tmpImg&: LINE (0, 0)-(_WIDTH, _HEIGHT), _RGB(255, 255, 255), BF: _DEST 0
    _SETALPHA 0, , tmpImg&
    FOR i = 0 TO 125
        _PUTIMAGE , aKDialog(id).background
        _PUTIMAGE , tmpImg&
        _SETALPHA i, , tmpImg&
        _DISPLAY
    NEXT
    _FREEIMAGE tmpImg&
ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "FOCUS" THEN
    LINE (0, 0)-(_WIDTH(0), _HEIGHT(0)), _RGBA(0, 0, 0, 120), BF
ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "SLIDE" THEN
    'new method.
    h = aKDialog(id).height
    tmpImg& = _COPYIMAGE(aKDialog(id).content)
    _SOURCE tmpImg&
    DO
        _DEST tmpImg&
        _PUTIMAGE , aKDialog(id).content
        LINE (0, i)-(_WIDTH, _HEIGHT), _RGB(255, 0, 0), BF
        _CLEARCOLOR _RGB(255, 0, 0), tmpImg&
        _DEST 0
        _PUTIMAGE (aKDialog(id).Wx, aKDialog(id).Wy - 25), tmpImg&
        _DISPLAY
        i = i + 1
    LOOP UNTIL i >= h
    _DEST 0: _SOURCE 0
ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "CROSFADE" THEN
    FOR i = 0 TO 255 STEP 4
        _SETALPHA i, , aKDialog(id).content
        _PUTIMAGE , aKDialog(id).background
        _PUTIMAGE (aKDialog(id).Wx, aKDialog(id).Wy - 25), aKDialog(id).content
        _DISPLAY
    NEXT
ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "SHAPEOUT" THEN
    tmpImg& = _COPYIMAGE(aKDialog(id).content)
    cx = aKDialog(id).width / 2: cy = aKDialog(id).height / 2
    r = aKDialog(id).width / 2 + 30
    DO
        _DEST tmpImg&
        _PUTIMAGE , aKDialog(id).content
        CIRCLE (cx, cy), r, _RGB(255, 0, 0)
        PAINT (cx, cy), _RGB(255, 0, 0), _RGB(255, 0, 0)
        _CLEARCOLOR _RGB(255, 0, 0), tmpImg&
        _DEST 0
        _PUTIMAGE (aKDialog(id).Wx, aKDialog(id).Wy - 25), tmpImg&
        _DISPLAY
        r = r - 1
    LOOP UNTIL r <= 0
    _SOURCE 0: _DEST 0
ELSEIF UCASE$(RTRIM$(aKDialog(id).transition)) = "BLINDS" THEN
    tmpImg& = _COPYIMAGE(aKDialog(id).content)
    _SOURCE tmpImg&
    s% = _WIDTH / 50: h = _HEIGHT: f% = 50
    DO
        _DEST tmpImg&
        _PUTIMAGE , aKDialog(id).content
        FOR i = 0 TO s%
            LINE (i * 50, 0)-(i * 50 + f%, h), _RGB(255, 0, 0), BF
        NEXT
        _CLEARCOLOR _RGB(255, 0, 0), tmpImg&
        _DEST 0
        _PUTIMAGE (aKDialog(id).Wx, aKDialog(id).Wy - 25), tmpImg&
        _DISPLAY
        f% = f% - 1
    LOOP UNTIL f% <= 0
    _DEST 0: _SOURCE 0
END IF
END SUB

SUB aKSetPicture (object, newImage&)
i = object
_FREEIMAGE aKPicture(i).img
aKPicture(i).img = _COPYIMAGE(newImage&)
END SUB

SUB aKFreeDialog (id)
aKDialog(id).closed = 0
aKDialog(id).shown = 0
aKDialog(id).save = 0
END SUB

SUB aKCreateShadow (id)
'shadow
IF aKDialog(id).noShadow THEN GOTO skipshadow
i = 21: a = i
DO WHILE i > 0
    LINE (aKDialog(id).Wx - 21 + i, aKDialog(id).Wy - 25 - 21 + i)-(aKDialog(id).Wx - 21 + i, aKDialog(id).Wy + aKDialog(id).height - 25 + 21 - i), _RGBA(0, 0, 0, a * 6)
    LINE (aKDialog(id).Wx + aKDialog(id).width + 21 - i, aKDialog(id).Wy - 25 - 21 + i)-(aKDialog(id).Wx + aKDialog(id).width + 21 - i, aKDialog(id).Wy + aKDialog(id).height - 25 + 21 - i), _RGBA(0, 0, 0, a * 6)
    LINE (aKDialog(id).Wx - 20 + i, aKDialog(id).Wy - 25 - 21 + i)-(aKDialog(id).Wx + aKDialog(id).width + 20 + -i, aKDialog(id).Wy - 25 - 21 + i), _RGBA(0, 0, 0, a * 6)
    LINE (aKDialog(id).Wx - 20 + i, aKDialog(id).Wy + aKDialog(id).height - 25 + 21 - i)-(aKDialog(id).Wx + aKDialog(id).width + 20 + -i, aKDialog(id).Wy + aKDialog(id).height - 25 + 21 - i), _RGBA(0, 0, 0, a * 6)
    i = i - 1: a = a - 3
LOOP
skipshadow:

END SUB


