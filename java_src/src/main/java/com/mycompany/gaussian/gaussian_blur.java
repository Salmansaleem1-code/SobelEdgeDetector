package com.mycompany.gaussian;

import java.applet.*;
import java.awt.*;
import java.awt.image.*;
import java.net.*;
import java.util.*;
import java.io.*;
import java.lang.Math.*;
import java.awt.Color.*;
import java.io.File;
import java.io.IOException;
import java.awt.image.BufferedImage;
import java.util.Scanner;
import javax.imageio.ImageIO;


public class gaussian_blur{
    
  static void gaussian_image(BufferedImage img,double sigma) throws IOException{
  int kernelWidth=3;
  int kernelHeight=3;
    
 int x[][] = { {-1,0,1},{-1,0,1},{-1,0,1} }; 
 int y[][]={{-1, -1,-1,},{0,0,0},{-1, -1,-1}};
double Exp_comp[][]= new double[kernelWidth][kernelHeight];
double Gaussian_Kernel[][]=new double[kernelWidth][kernelHeight];
int k=0;
for (int i=0;i<kernelWidth;i++){
    for (int j=0;j<kernelHeight;j++){
         Exp_comp[i][j]=-((x[i][j])^2) +((y[i][j])^2)/2*sigma*sigma;
         Gaussian_Kernel[i][j]=(float)Math.exp(Exp_comp[i][j])/(2*Math.PI*sigma*sigma);
         
    }
}
float[][]floatArray = new float[3][3];
for (int i = 0 ; i < kernelWidth; i++)
{
    for (int j=0;j<kernelHeight;j++){
    floatArray[i][j] = (float) Gaussian_Kernel[i][j];
}
}
 BufferedImage tempImage;
  BufferedImage tempImage2 = new BufferedImage(img.getWidth(), img.getHeight(), img.getType()); 
    int columns = floatArray.length; 
    int  rows= floatArray[0].length; 
    //Unrolls a 2D filter into a 1D filter 
    float[] filter1D = new float[columns*rows]; 
     k = 0;
    for (int i =0; i<floatArray[0].length; i++) {
    for (int j =0; j<floatArray.length; j++) {
      filter1D[k++] = floatArray[i][j];
    }
}
    //creates Kernal and convolution operator 
    Kernel kern = new Kernel(rows, columns, filter1D); 
    ConvolveOp op = new ConvolveOp(kern,
                                ConvolveOp.EDGE_NO_OP,
                                null); 
    //apply filtering  
    tempImage = op.filter(img, null); 
    
File grayscale = new File("C://Users//Dell//Documents//gaussianblur.jpg");
  System.out.println("Gaussian blur at C://Users//Dell//Documents//gaussianblur.jpg");
  ImageIO.write(tempImage,"jpg", grayscale);
    
  

sobel(tempImage);  
  

    

}
  static void sobel(BufferedImage image) throws IOException{
  int x = image.getWidth();
        int y = image.getHeight();
BufferedImage buffer=image;
        int maxGval = 0;
        int[][] edgeColors = new int[x][y];
        int maxGradient = -1;
        for (int i = 1; i < x - 1; i++) {
            for (int j = 1; j < y - 1; j++) {

                int val00 = getGrayScale(image.getRGB(i - 1, j - 1));
                int val01 = getGrayScale(image.getRGB(i - 1, j));
                int val02 = getGrayScale(image.getRGB(i - 1, j + 1));

                int val10 = getGrayScale(image.getRGB(i, j - 1));
                int val11 = getGrayScale(image.getRGB(i, j));
                int val12 = getGrayScale(image.getRGB(i, j + 1));

                int val20 = getGrayScale(image.getRGB(i + 1, j - 1));
                int val21 = getGrayScale(image.getRGB(i + 1, j));
                int val22 = getGrayScale(image.getRGB(i + 1, j + 1));

                int gx =  ((-1 * val00) + (0 * val01) + (1 * val02)) 
                        + ((-2 * val10) + (0 * val11) + (2 * val12))
                        + ((-1 * val20) + (0 * val21) + (1 * val22));

                int gy =  ((-1 * val00) + (-2 * val01) + (-1 * val02))
                        + ((0 * val10) + (0 * val11) + (0 * val12))
                        + ((1 * val20) + (2 * val21) + (1 * val22));

                double gval = Math.sqrt((gx * gx) + (gy * gy));  // sqrt
                int g = (int) gval;

                if(maxGradient < g) {
                    maxGradient = g;
                }
                            edgeColors[i][j]=g;
            
            }
        }
        double scale = 255.0 / maxGradient;

        for (int i = 1; i < x - 1; i++) {
            for (int j = 1; j < y - 1; j++) {
                int edgeColor = edgeColors[i][j];
                edgeColor = (int)(edgeColor * scale);
                edgeColor = 0xff000000 | (edgeColor << 16) | (edgeColor << 8) | edgeColor;

                   buffer.setRGB(i, j, edgeColor);
            }
        }
        
  File sobel= new File("C://Users//Dell//Desktop//sobel2_w.r.t_sigma.jpg");
  System.out.println("Sobel by using sigma value at C://Users//Dell//Documents//sobel2_w.r.t_sigma.jpg");
  ImageIO.write(buffer,"jpg", sobel);
  }
  public static void main(String args[])throws IOException{
 
    File f = null;
    double sigma= 1.2;
    //read image
     try {
     Scanner input2S=new Scanner(System.in);
       System.out.println("Enter image path see File grayscale format below if ur enter path is wrong");
       String str1=input2S.nextLine();  

       
      
  File input = new File(str1);
  BufferedImage image = ImageIO.read(input);
  int width = image.getWidth();
  int height = image.getHeight();
  for(int i=0; i<height; i++) {
   for(int j=0; j<width; j++) {
    Color c = new Color(image.getRGB(j, i));
    int red = (int)(c.getRed() * 0.299);
    int green = (int)(c.getGreen() * 0.587);
    int blue = (int)(c.getBlue() *0.114);
    Color newColor = new Color(red+green+blue,
    red+green+blue,red+green+blue);
    image.setRGB(j,i,newColor.getRGB());
   }
  }
  File grayscale = new File("C://Users//Dell//Documents//chaplin2.jpg");
  System.out.println("Done");
  ImageIO.write(image,"jpg", grayscale);
 BufferedImage gray=ImageIO.read(grayscale);
 
 Scanner input2=new Scanner(System.in);
         System.out.println("Enter value of sigma");
 input2.nextDouble();
 
 ///////////////////////gaussian_blur/////////////////////////////////////////////////////////
          gaussian_image(gray,sigma);
          
///////////////////
//////////////////////Sobel operator////////////////////////////////////////////////////////////////////////
        int x = image.getWidth();
        int y = image.getHeight();

        int maxGval = 0;
        int[][] edgeColors = new int[x][y];
        int maxGradient = -1;

        for (int i = 1; i < x - 1; i++) {
            for (int j = 1; j < y - 1; j++) {

                int val00 = getGrayScale(image.getRGB(i - 1, j - 1));
                int val01 = getGrayScale(image.getRGB(i - 1, j));
                int val02 = getGrayScale(image.getRGB(i - 1, j + 1));

                int val10 = getGrayScale(image.getRGB(i, j - 1));
                int val11 = getGrayScale(image.getRGB(i, j));
                int val12 = getGrayScale(image.getRGB(i, j + 1));

                int val20 = getGrayScale(image.getRGB(i + 1, j - 1));
                int val21 = getGrayScale(image.getRGB(i + 1, j));
                int val22 = getGrayScale(image.getRGB(i + 1, j + 1));

                int gx =  ((-1 * val00) + (0 * val01) + (1 * val02)) 
                        + ((-2 * val10) + (0 * val11) + (2 * val12))
                        + ((-1 * val20) + (0 * val21) + (1 * val22));

                int gy =  ((-1 * val00) + (-2 * val01) + (-1 * val02))
                        + ((0 * val10) + (0 * val11) + (0 * val12))
                        + ((1 * val20) + (2 * val21) + (1 * val22));

                double gval = Math.sqrt((gx * gx) + (gy * gy));  // sqrt
                int g = (int) gval;

                if(maxGradient < g) {
                    maxGradient = g;
                }

                edgeColors[i][j] = g;
            }
        }

        double scale = 255.0 / maxGradient;

        for (int i = 1; i < x - 1; i++) {
            for (int j = 1; j < y - 1; j++) {
                int edgeColor = edgeColors[i][j];
                edgeColor = (int)(edgeColor * scale);
                edgeColor = 0xff000000 | (edgeColor << 16) | (edgeColor << 8) | edgeColor;

                image.setRGB(i, j, edgeColor);
            }
        }

        File outputfile = new File("C://Users//Dell//Documents//sobel_chaplin.jpg");
        ImageIO.write(image, "png", outputfile);

        System.out.println("Sobel image is saved at C://Users//Dell//Documents//sobel_chaplin.jpg" );
   
    }

  catch (Exception e) {
      System.out.println(" file pathnotfound ");
    }

      
    
  }//main() ends here
    public static int  getGrayScale(int rgb) {
        int r = (rgb >> 16) & 0xff;
        int g = (rgb >> 8) & 0xff;
        int b = (rgb) & 0xff;

        // calculating luminance
        int gray = (int)(0.2126 * r + 0.7152 * g + 0.0722 * b);
        //int gray = (r + g + b) / 3;

        return gray;
    }
}//class ends here

