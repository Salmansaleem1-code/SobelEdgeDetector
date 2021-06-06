function [sobel_img] = sobel(img_smooth,Gx,Gy)


%convolving the Gx and Gy with gaussian blur filter
Gx=convn(Gx,img_smooth);
Gy=convn(Gy,img_smooth);


    %finding the magnitude which will give edge of image
       sobel_img=sqrt(Gx.^2+Gy.^2);
    %finding direction
       sobel_direction=atan(Gy./Gx);
 

