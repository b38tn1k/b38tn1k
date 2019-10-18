import cv2
import numpy as np
import time
from skimage import img_as_ubyte

# Our sketch generating function
def NeuralStyleTransfer(img, model, size = 320, upscale = 1):

    model_file_path = "./models/"
    # style = cv2.imread("./art/"+str(model)[:-3]+".jpg")
    # loading our neural style transfer model
    neuralStyleModel = cv2.dnn.readNetFromTorch(model_file_path+ model+".t7")

    # Let's resize to a fixed height of 640 (feel free to change)
    height, width = int(img.shape[0]), int(img.shape[1])
    newWidth = int((size / height) * width)
    resizedImg = cv2.resize(img, (newWidth, size), interpolation = cv2.INTER_AREA)

    # Create our blob from the image and then perform a forward pass run of the network
    inpBlob = cv2.dnn.blobFromImage(resizedImg, 1.0, (newWidth, size),
                               (103.939, 116.779, 123.68), swapRB=False, crop=False)

    neuralStyleModel.setInput(inpBlob)
    output = neuralStyleModel.forward()

    # Reshaping the output tensor, adding back  the mean subtraction
    # and re-ordering the channels
    output = output.reshape(3, output.shape[2], output.shape[3])
    # output[0] += 103.939
    # output[1] += 116.779
    # output[2] += 123.68
    output /= 255
    output = output.transpose(1, 2, 0)
    output = cv2.resize(output, None, fx=upscale, fy=upscale, interpolation = cv2.INTER_LINEAR)
    # return img_as_ubyte(output)
    # output = output/output.max()
    output = np.interp(output, (output.min(),output.max()),(0.0, 1.0))
    # return img_as_ubyte(output)
    # print (output.max())
    # print (output.min())
    output = output * 255.0
    # # # print(output[100][100])
    return output.astype('uint8')


# Initialize webcam, cap is the object provided by VideoCapture
# cap = cv2.VideoCapture(i)
i = 0
counter = 0
strings = [ 'la_muse', 'feathers', 'composition_vii', 'mosaic', 'the_scream', 'udnie', 'starry_night', 'candy', 'the_wave']
# Initialize webcam, cap is the object provided by VideoCapture\n

photos = ['test.jpg']
for img in photos:
    frame = cv2.imread(img)
    for style in strings:
            nframe = NeuralStyleTransfer(frame, style, 1280, 2)
            cv2.imwrite(img+style + '.png',  nframe)
