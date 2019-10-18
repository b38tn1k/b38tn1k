import cv2
import numpy as np
import time
import pyautogui
pyautogui.FAILSAFE = False

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
    output[0] += 103.939
    output[1] += 116.779
    output[2] += 123.68
    output /= 255
    output = output.transpose(1, 2, 0)
    output = cv2.resize(output, None, fx=upscale, fy=upscale, interpolation = cv2.INTER_LINEAR)
    output = np.interp(output, (output.min(),output.max()),(0.0, 1.0))
    output *= 255.0
    return output.astype('uint8')


# Initialize webcam, cap is the object provided by VideoCapture
# cap = cv2.VideoCapture(i)
i = 0
counter = 0
strings = [ 'la_muse', 'feathers', 'composition_vii', 'mosaic', 'the_scream', 'udnie', 'starry_night', 'candy', 'the_wave']
for video in ['IMG_0131.TRIM.MOV', 'IMG_0137.TRIM.MOV']:#, 'IMG_9979.MOV', 'IMG_9980.MOV', 'IMG_9981.MOV', 'IMG_9982.MOV', 'IMG_9983.MOV', 'IMG_9984.MOV']:
    for style in [ 'mosaic','la_muse', 'udnie', 'candy']:
        name = video
        print(name)
        print (style)
        cap = cv2.VideoCapture(name)
        out = cv2.VideoWriter(style + name + '.mp4',cv2.VideoWriter_fourcc(*'MP4V'), 5, (4552,2560))
        ret = True
        i = 0
        start = time.time()
        while ret is True:
            stay_awake = True
            ret, frame = cap.read()
            i += 1
            # print(i)
            if i % 30 == 0:
                print('frame' + str(i))
                print(time.time() - start)
                start = time.time()
            # print(frame.dtype)
            if frame is None:
                break
            if i % 12 == 0:
                if stay_awake is True: pyautogui.moveTo(1,1)
                # frame = cv2.GaussianBlur(frame,(51, 51),0)
                nframe = NeuralStyleTransfer(frame, style, 1280, 2)
                # if stay_awake is True: pyautogui.moveTo(10,10)
                # print(nframe.shape)
                out.write(nframe)

        # Release camera and close windows\n",
        cap.release()
        out.release()
        cv2.destroyAllWindows()
