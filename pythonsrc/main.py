import cv2 as cv
import numpy as np
from PIL import Image
import math
if __name__ == '__main__':
    # Grayscale Image
    input1 = input("Enter image path")
    image = Image.open(input1)
    img_arr = np.array(image)
    sigma = float(input("Enter sigma value :"))

    x = np.array([[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]])
    y = np.array([[-1, -1, -1], [0, 0, 0], [-1, -1, -1]])

    Exp_comp = np.array(-(np.square(x) + np.square(y))) / (2 * sigma * sigma)
    Gaussian_Kernel = np.array(math.e**Exp_comp) / (2 * math.pi * sigma * sigma)
    kernel = np.flipud(np.fliplr(Gaussian_Kernel))
    # Convolve and Save Output

    dst = cv.filter2D(np.uint8(image), -1, Gaussian_Kernel)

    img = Image.fromarray(dst, 'RGB')
    img.save('3x3 Gaussian_blur.png')
    img.show()

    x = np.array([[-1, 0, 1,  -1, 1], [-1, 0, 1,  -1, 1], [-1, 0, 1,  -1, 1], [-1, 0, 1,  -1, 1], [-1, 0, 1,  -1, 1]])
    y = np.array([[-1, -1, -1, -1, -1], [0, 0, 0, 0, 0], [-1, -1, -1, -1, -1], [-1, -1, -1, -1, -1], [-1, -1, -1, -1, -1]])

    Exp_comp = np.array(-(np.square(x) + np.square(y))) / (2 * sigma * sigma)
    Gaussian_Kernel = np.array(math.e ** Exp_comp) / (2 * math.pi * sigma * sigma)
    kernel = np.flipud(np.fliplr(Gaussian_Kernel))
    # Convolve and Save Output

    dst = cv.filter2D(np.uint8(image), -1, Gaussian_Kernel)

    img = Image.fromarray(dst, 'RGB')
    img.save('5x5 Gaussian_blur.png')
    img.show()

    # sobel operator

    Gx = [[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]]
    Gy = [[-1, -2, -1], [0, 0, 0], [1, 2, 1]]

    Gx = cv.filter2D(np.double(img), -1, np.array(Gx))
    Gy = cv.filter2D(np.double(img), -1, np.array(Gy))
    square = np.array(np.square(Gx)+np.square(Gy))
    sobel_img = np.array(np.sqrt(np.array(square)))

    img2 = Image.fromarray(np.uint8(sobel_img), 'RGB')
    img2.save('3x3 sobel.png')
    img2.show()
    # 5x5 kernel
    gx = [[-1, 0, 1, -1, 1], [-2, 0, 2, -2, 2], [-1, 0, 1, -1, 1], [-2, 0, 2, -2, 2], [-1, 0, 1, -1, 1]]
    gy = [[-1, -2, -1, -1, -2], [0, 0, 0, 0, 0], [1, 2, 1, 1, 2], [-1, -2, -1, -1, -2], [1, 2, 1, 1, 2]]

    gx = cv.filter2D(np.double(img), -1, np.array(gx))
    gy = cv.filter2D(np.double(img), -1, np.array(gy))
    square = np.array(np.square(gx) + np.square(gy))
    sobel_img = np.array(np.sqrt(np.array(square)))
    img3 = Image.fromarray(np.uint8(sobel_img), 'RGB')
    img3.save('5x5 sobel.png')
    img3.show()