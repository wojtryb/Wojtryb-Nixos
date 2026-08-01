#!/usr/bin/env python3

import cv2 as cv
import os
import glob
import numpy as np

directory = "/mnt/dane/2020_08_Tokarnia/Droga_mleczna_PNG/"
directoryOut = "/mnt/dane/2020_08_Tokarnia/Droga_mleczna_PNG_out/"
data_path = os.path.join(directory,'*g') 
files = glob.glob(data_path)
files = sorted(files)
img = cv.imread(directory + 'dumb.jpg', cv.IMREAD_UNCHANGED)
i = 0
for file in files:
    img = cv.imread(file)
    blank_image = np.zeros((3000,4000,3), np.uint8)
    #blank_image.paste(img)
    blank_image[:,:3999,:] = img[:,:,:]
    number = str(i)
    if i < 10:
        number = "0" + number
    if i < 100:
        number = "0" + number
    if i < 1000:
        number = "0" + number
    print(os.path.join(directory, number + ".png"))
    cv.imwrite(os.path.join(directoryOut, number + ".png"), blank_image)
    i+=1
    
