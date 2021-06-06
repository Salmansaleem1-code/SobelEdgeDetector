function [gblur_img] = gaussian(sigma,x,y)
img=imread('chaplin.jpg');



Exp_comp = -(x.^2+y.^2)/(2*sigma*sigma);
Gaussian_Kernel= exp(Exp_comp)/(2*pi*sigma*sigma);

gblur_img=convn(double(img),Gaussian_Kernel);
