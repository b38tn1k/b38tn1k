import numpy as np
import cv2

cap = cv2.VideoCapture('test.MOV')

fgbg = cv2.createBackgroundSubtractorMOG2()
fgbg2 = cv2.createBackgroundSubtractorKNN()
out = cv2.VideoWriter('outmask.avi',cv2.VideoWriter_fourcc('M','J','P','G'), 30, (1920,1080))
i = 0
while(1):
  ret, frame = cap.read()
  i += 1
  if (i == 133):
      break
  fgmask = fgbg2.apply(frame)
  fr = cv2.bitwise_and(frame, frame, mask = fgmask)
  cv2.imshow('frame',fr)
  out.write(fr)
  k = cv2.waitKey(30) & 0xff
  if k == 27:
    break

out.release()
cap.release()
cv2.destroyAllWindows()
