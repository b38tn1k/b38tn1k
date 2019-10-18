import pyautogui
pyautogui.FAILSAFE = False
while(True):
    for i in range(0,20):
        pyautogui.moveTo(i*4,i*4)
    pyautogui.moveTo(1,1)
