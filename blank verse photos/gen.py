import cv2
import numpy as np
import sys
import math

images = []

def showTilShut(img, name='test'):
    cv2.imshow(name,img)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

if __name__=="__main__":
    for arg in sys.argv:
        if '.jpg' in arg.lower() or '.png' in arg.lower() or '.jpeg' in arg.lower() and not "warped" in arg.lower():
            images.append(arg)
    print(images)
    width = 600
    height = 600
    mycanvas = np.zeros([height, width, 3])
    cell_height = int(200)
    cell_width = int(200)
    photo = cover = cv2.imread(images[3])
    for xoff in range(0, width, cell_width):
        for yoff in range ( 0, height, cell_height):
            samplex = 100
            sampley = 100
            samplex_fin = samplex+cell_width
            sampley_fin = sampley+cell_height
            xoff_fin = xoff+cell_width
            yoff_fin = yoff+cell_height
            subimage = photo[samplex:samplex_fin, sampley:sampley_fin]
            mycanvas[xoff:xoff_fin, yoff:yoff_fin] = subimage

    showTilShut(mycanvas)
