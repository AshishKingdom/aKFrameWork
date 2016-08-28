IF _DIREXISTS("akframework") THEN
    CHDIR "akframework\demo"
ELSEIF _DIREXISTS("demo") THEN
    CHDIR "demo"
END IF
'$include:'akframework\akframework_global.bi'

SCREEN _NEWIMAGE(800, 700, 32)
'setting background
_PUTIMAGE , _LOADIMAGE("bg.jpg")
'setting title
_TITLE "ProgressBar Demo"

'creating a dialog handle
progressDialog = aKNewdialog("Progress Bar Demo", 380, 150)
'creating a label
label1 = aKAddlabel(progressDialog, "Click the button below to see a", 10, 10)
label2 = aKAddlabel(progressDialog, "beautiful progressbar running.", 10, 30)
'creating a run button which we'll use to run progress bar
'No matter if you are using it directly or not.
runBtn = aKAddButton(progressDialog, "Run Progress", 10, 90)
progress = aKAddProgressBar(progressDialog, 10, 50, 340, 1, -1)
'#####################################
'How shall I create progress bar   ?
'Answer:
'Read aKFramework.pdf in doc folder or see it below
'progress% = aKAddProgressBar(handle%,xpos%,ypos%,width%,value%,active%)
'handle% : the handle of your dialog.
'xpos% : the x-position of the progress bar inside the dialog.
'ypos% : the y-position of the progress bar inside the dialog.
'width% : the width of the progress bar in pixel. Should not be greater than the
'width of the dialog. If greater than the progress bar will be placed outside.
' Minimum width is 340, if provided less than it, then strips will made properly.
'value% : value can between 0 to 100. It represents how much portion of the
'progress bar will have green strip.
'active% :  It defines whether the progress bar is active or not. if given -1 then
'it is active
'###################################
'How shall I update the value of the progress bar ?
'Answer:
'Use aKUpdateProgress sub to update the value of the progress bar.
'Here's its syntax -
'aKUpdateProgress progressHandle%,newValue%
'progressHandle% : the handle of the progress bar.
'newValue% : the new value to be updated. Whether it is more than old value
'or less, the green stripp covering portion of progress bar will be
'updated.
DO
    'always use these two subs at the top of a loop with your dialog handle.
    aKCheck progressDialog
    aKUpdate progressDialog
    'checking if the user click run button
    IF aKClick(progressDialog, aKButton, runBtn) THEN
        'to prevent user next click we'll erase this object
        aKEraseObject progressDialog, aKButton, runBtn
        'and add progress bar
        start = -1
    END IF
    'updating our progress bar
    IF start AND p < 100 THEN
        p = p + 10
        akUpdateProgress progress, p
        'some delay. not neccessary
        _DELAY .2
    END IF
    _DISPLAY
    'checking if our dialog is closed by the user.
    IF aKDialogClose(progressDialog) THEN EXIT DO
LOOP

'$include:'akframework\akframework_method.bi'
