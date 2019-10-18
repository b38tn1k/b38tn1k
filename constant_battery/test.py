import cv2
import numpy as np
import time


photos = ["battery_0.png","battery_1.png","battery_10.png","battery_100.png","battery_101.png","battery_11.png","battery_12.png","battery_13.png","battery_14.png","battery_15.png","battery_16.png","battery_17.png","battery_18.png","battery_19.png","battery_2.png","battery_20.png","battery_21.png","battery_22.png","battery_23.png","battery_24.png","battery_25.png","battery_26.png","battery_27.png","battery_28.png","battery_29.png","battery_3.png","battery_30.png","battery_31.png","battery_32.png","battery_33.png","battery_34.png","battery_35.png","battery_36.png","battery_37.png","battery_38.png","battery_39.png","battery_4.png","battery_40.png","battery_41.png","battery_42.png","battery_43.png","battery_44.png","battery_45.png","battery_46.png","battery_47.png","battery_48.png","battery_49.png","battery_5.png","battery_50.png","battery_51.png","battery_52.png","battery_53.png","battery_54.png","battery_55.png","battery_56.png","battery_57.png","battery_58.png","battery_59.png","battery_6.png","battery_60.png","battery_61.png","battery_62.png","battery_63.png","battery_64.png","battery_65.png","battery_66.png","battery_67.png","battery_68.png","battery_69.png","battery_7.png","battery_70.png","battery_71.png","battery_72.png","battery_73.png","battery_74.png","battery_75.png","battery_76.png","battery_77.png","battery_78.png","battery_79.png","battery_8.png","battery_80.png","battery_81.png","battery_82.png","battery_83.png","battery_84.png","battery_85.png","battery_86.png","battery_87.png","battery_88.png","battery_89.png","battery_9.png","battery_90.png","battery_91.png","battery_92.png","battery_93.png","battery_94.png","battery_95.png","battery_96.png","battery_97.png","battery_98.png","battery_99.png"]

for img in photos:
    print(img)
    frame = cv2.imread(img)
    framea = cv2.cvtColor(frame, cv2.COLOR_RGB2RGBA)
    print(framea.shape)
    for i in range(150):
        for j in range(300):
            pixel = framea[i][j]
            if pixel[0] == pixel[2] and pixel[2] > 50 and not pixel[1] == pixel[0]:
                pixel[3] = 0
                framea[i][j] = pixel
            # print(framea[i][j])
    cv2.imwrite(img, framea)
