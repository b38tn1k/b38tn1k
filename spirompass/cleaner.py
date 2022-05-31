import sys
from PIL import Image
import numpy as np



def main(argv):
    for arg in argv:
        if '.png' in arg:
            print(arg)
            im = Image.open(arg)
            im = im.convert('RGBA')
            data = np.array(im)
            # data = np.rot90(data)
            # data = np.rot90(data)
            red, green, blue, alpha = data.T
            mag = (red == 0) & (blue == 0) & (green ==0)
            data[..., :][mag.T] = (0, 0, 0, 0)

            red, green, blue, alpha = data.T
            mag = (red == 255) & (blue == 255) & (green ==0)
            data[..., :][mag.T] = (0, 0, 0, 0)

            im2 = Image.fromarray(data)
            im2.save('cleaned-'+arg)


if __name__ == "__main__":
   main(sys.argv[1:])
