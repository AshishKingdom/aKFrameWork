'#######################
' aKFrameWork v1.000
'  A Qb64 Framework
'      library
'#######################
'Copyright © 2016-17 by Ashish Kushwaha
'Last Update on 12:47 PM 8/25/2016
'Any suggestion or bug about this library are always welcome
'find me at http://www.qb64.net/forum

DECLARE LIBRARY
    SUB glutSetCursor (BYVAL style&)
END DECLARE

TYPE akFrameWorkType
    version AS STRING * 5
END TYPE
TYPE mousetype
    x AS INTEGER
    y AS INTEGER
    Lclick AS INTEGER
    Rclick AS INTEGER
    movement AS INTEGER
    icon AS STRING * 10
END TYPE
TYPE aKdialogType
    title AS STRING * 256
    height AS INTEGER
    width AS INTEGER
    background AS LONG
    shown AS INTEGER
    closed AS INTEGER
    Wx AS SINGLE
    Wy AS SINGLE
    Cx AS SINGLE
    Cy AS SINGLE
    Cx2 AS SINGLE
    Cy2 AS SINGLE
    content AS LONG
    hasAnimation AS LONG
    transition AS STRING * 128
    noShadow AS INTEGER
    save AS INTEGER
END TYPE
TYPE aKlabelType
    x AS INTEGER
    y AS INTEGER
    text AS STRING * 256
    tooltip AS INTEGER
    id AS INTEGER
    tId AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE aKButtonType
    x AS INTEGER
    y AS INTEGER
    value AS STRING * 256
    tooltip AS INTEGER
    react AS INTEGER
    tId AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE akCheckBoxType
    x AS INTEGER
    y AS INTEGER
    text AS STRING * 256
    tooltip AS INTEGER
    checked AS INTEGER
    tId AS INTEGER
    react AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE akRadioButtonType
    x AS INTEGER
    y AS INTEGER
    text AS STRING * 256
    tooltip AS INTEGER
    checked AS INTEGER
    groupId AS INTEGER
    react AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE aKLinklabelType
    x AS INTEGER
    y AS INTEGER
    text AS STRING * 256
    tooltip AS INTEGER
    tId AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE aKComboBoxType
    x AS INTEGER
    y AS INTEGER
    value AS STRING * 256
    options AS STRING * 512
    react AS INTEGER
    active AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE aKTextboxType
    x AS INTEGER
    y AS INTEGER
    width AS INTEGER
    value AS STRING * 256
    placeholder AS STRING * 256
    active AS INTEGER
    react AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
    typ AS INTEGER
END TYPE
TYPE aKNumericUpDownType
    x AS INTEGER
    y AS INTEGER
    value AS LONG
    width AS INTEGER
    react AS INTEGER
    react1 AS INTEGER
    react2 AS INTEGER
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE aKProgressBarType
    x AS INTEGER
    y AS INTEGER
    width AS INTEGER
    active AS INTEGER
    value AS INTEGER
    oldValue AS INTEGER
    bar AS LONG
    id AS INTEGER
    hidden AS INTEGER
END TYPE
TYPE aKTooltipType
    text AS STRING * 512
    shown AS INTEGER
    content AS LONG
    id AS INTEGER
END TYPE
TYPE aKPictureType
    x AS INTEGER
    y AS INTEGER
    width AS INTEGER
    height AS INTEGER
    img AS LONG
    hidden AS INTEGER
    id AS INTEGER
    tooltip AS INTEGER
    tid AS INTEGER
END TYPE
TYPE aKDividerType
    x AS INTEGER
    y AS INTEGER
    size AS INTEGER
    typ AS INTEGER
    hidden AS INTEGER
    id AS INTEGER
END TYPE
TYPE aKPanelType
    x AS INTEGER
    y AS INTEGER
    width AS INTEGER
    height AS INTEGER
    hidden AS INTEGER
    title AS STRING * 256
    id AS INTEGER
END TYPE

CONST True = -1, False = NOT True
CONST aKLabel = 0, aKButton = 1, aKCheckBox = 2, aKRadioButton = 4, aKLinkLabel = 5, aKComboBox = 6, aKTextBox = 7, aKNumericUpDown = 8, aKProgressBar = 9
CONST aKPicture = 10, aKDivider = 11, aKPanel = 12, aKVertical = 13, aKHorizontal = 14, aKPassword = 15, aKTooltip = 16

DIM SHARED aKFrameWork AS akFrameWorkType
REDIM SHARED aKDialog(1) AS aKdialogType, aKDialogLength
REDIM SHARED aKLabel(1) AS aKlabelType, aKlabelLength AS INTEGER
REDIM SHARED aKButton(1) AS aKButtonType, aKButtonLength AS INTEGER
REDIM SHARED aKCheckBox(1) AS akCheckBoxType, aKCheckBoxLength AS INTEGER
REDIM SHARED aKRadioButton(1) AS akRadioButtonType, aKRadioLength AS INTEGER
REDIM SHARED aKLinkLabel(1) AS aKLinklabelType, aKLinklabelLength AS INTEGER
REDIM SHARED aKComboBox(1) AS aKComboBoxType, aKComboBoxLength AS INTEGER
REDIM SHARED aKTextBox(1) AS aKTextboxType, aKTextBoxLength AS INTEGER
REDIM SHARED aKNumericUpDown(1) AS aKNumericUpDownType, aKNumericUDLength AS INTEGER
REDIM SHARED aKProgressBar(1) AS aKProgressBarType, aKProgressBarLength AS INTEGER
REDIM SHARED aKTooltip(1) AS aKTooltipType, aKTooltipLength AS INTEGER
REDIM SHARED aKDivider(1) AS aKDividerType, aKDividerLength AS INTEGER
REDIM SHARED aKPicture(1) AS aKPictureType, aKPictureLength AS INTEGER
REDIM SHARED aKPanel(1) AS aKPanelType, aKPanelLength AS INTEGER
DIM SHARED Mouse AS mousetype, tooltipBg AS LONG, optionsBg AS LONG

aKDialogLength = 1
aKlabelLength = 1
aKButtonLength = 1
aKCheckBoxLength = 1
aKRadioLength = 1
aKLinklabelLength = 1
aKComboBoxLength = 1
aKTextBoxLength = 1
aKNumericUDLength = 1
aKProgressBarLength = 1
aKTooltipLength = 1
aKDividerLength = 1
aKPictureLength = 1
aKPanelLength = 1

aKFrameWork.version = "1.012"

