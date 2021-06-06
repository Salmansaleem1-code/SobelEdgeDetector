// C++ prgroam to generate Gaussian filter
#include <cmath>
#include <iomanip>
#include <iostream>
#include <opencv2/opencv.hpp>


////You have to download opencv2 to run this program
using namespace std;
using namespace cv;


 // Computes the x component of the gradient vector
// at a given point in a image.
// returns gradient in the x direction

//// Gx=[-1 0 1; -2 0 2; -1 0 1];
 //   ;////
int xGradient(Mat image, int x, int y)
{
    return image.at<uchar>1*(y-1, x-1) +
                2*image.at<uchar>(y, x-1) +
                 image.at<uchar>(y+1, x-1) -
                  image.at<uchar>(y-1, x+1) -
                   2*image.at<uchar>(y, x+1) -
                    image.at<uchar>(y+1, x+1);
}

// Computes the y component of the gradient vector
// at a given point in a image
// returns gradient in the y direction
//Gy=[-1 -2 -1; 0 0 0; 1 2 1]
int yGradient(Mat image, int x, int y)
{
    return image.at<uchar>(y-1, x-1) +
                2*image.at<uchar>(y-1, x) +
                 image.at<uchar>(y-1, x+1) -
                  image.at<uchar>(y+1, x-1) -
                   2*image.at<uchar>(y+1, x) -
                    image.at<uchar>(y+1, x+1);
}




int reflect(int M, int x)
{
    if(x < 0)
    {
        return -x - 1;
    }
    if(x >= M)
    {
        return 2*M - x - 1;
    }
   return x;
}


int circular(int M, int x)
{
    if (x<0)
        return x+M;
    if(x >= M)
        return x-M;
   return x;
}


void noBorderProcessing(Mat src, Mat dst, float Kernel[][3])
{

    float sum;
    for(int y = 1; y < src.rows - 1; y++){
        for(int x = 1; x < src.cols - 1; x++){
            sum = 0.0;
            for(int k = -1; k <= 1;k++){
                for(int j = -1; j <=1; j++){
                    sum = sum + Kernel[j+1][k+1]*src.at<uchar>(y - j, x - k);
                }
            }
            dst.at<uchar>(y,x) = sum;
        }
    }
}

void refletedIndexing(Mat src, Mat dst, float Kernel[][3])
{
    float sum, x1, y1;
    for(int y = 0; y < src.rows; y++){
        for(int x = 0; x < src.cols; x++){
            sum = 0.0;
            for(int k = -1;k <= 1; k++){
                for(int j = -1;j <= 1; j++ ){
                    x1 = reflect(src.cols, x - j);
                    y1 = reflect(src.rows, y - k);
                    sum = sum + Kernel[j+1][k+1]*src.at<uchar>(y1,x1);
                }
            }
            dst.at<uchar>(y,x) = sum;
        }
    }
}

void circularIndexing(Mat src, Mat dst, float Kernel[][3])
{
    float sum, x1, y1;
    for(int y = 0; y < src.rows; y++){
        for(int x = 0; x < src.cols; x++){
            sum = 0.0;
            for(int k = -1;k <= 1; k++){
                for(int j = -1;j <= 1; j++ ){
                    x1 = circular(src.cols, x - j);
                    y1 = circular(src.rows, y - k);
                    sum = sum + Kernel[j+1][k+1]*src.at<uchar>(y1,x1);
                }
            }
            dst.at<uchar>(y,x) = sum;
        }
    }
}
// Function to create Gaussian filter
void FilterCreation(double GKernel[][5])
{
    double sigma;

	cout<<"Enter sigma value"<<endl;
	cin>>sigma;

	double r, s = 2.0 * sigma * sigma;

	// sum is for normalization
	double sum = 0.0;

	// generating 5x5 kernel
	for (int x = -2; x <= 2; x++) {
		for (int y = -2; y <= 2; y++) {
			r = sqrt(x * x + y * y);
			GKernel[x + 2][y + 2] = (exp(-(r * r) / s)) / (M_PI * s);
			sum += GKernel[x + 2][y + 2];
		}
	}

	// normalising the Kernel
	for (int i = 0; i < 5; ++i)
		for (int j = 0; j < 5; ++j)
			GKernel[i][j] /= sum;
}

// Driver program to test above function
int main()
{

	double GKernel_3x3[3][3];
	double Gkernel_5x5[3][3];



	FilterCreation(GKernel_3x3);
	FilterCreation(Gkernel_5x5);

	for (int i = 0; i < 3; ++i) {
		for (int j = 0; j < 3; ++j)
			cout << GKernel_3x3[i][j] << "\t";
		cout << endl;
	}
	for (int i = 0; i < 5; ++i) {
		for (int j = 0; j < 5; ++j)
			cout << GKernel_5x5[i][j] << "\t";
		cout << endl;
	}
	Mat src, dst;

      char str[100];
      /// Load an image
      cout<<"Enter path of image"<<endl;
      cin>>str;
      src = imread(str, CV_LOAD_IMAGE_GRAYSCALE);

      if( !src.data )
      { return -1; }




        dst = src.clone();
        for(int y = 0; y < src.rows; y++)
            for(int x = 0; x < src.cols; x++)
                dst.at<uchar>(y,x) = 0.0;

        circularIndexing(src, dst, GKernel_3x3);



        namedWindow("final");
        imshow("3x3 gaussian_blur", dst);

        namedWindow("initial");
        imshow("initial", src);

        circularIndexing(src, dst, GKernel_5x5);



        namedWindow("final");
        imshow("5x5 gaussian_blur", dst);

        namedWindow("initial");
        imshow("initial", src);

      waitKey();

////////////////////Sobel edge detection

      int gx, gy, sum;


      dst = src.clone();
      if( !src.data )
      { return -1; }


        for(int y = 0; y < src.rows; y++)
            for(int x = 0; x < src.cols; x++)
                dst.at<uchar>(y,x) = 0.0;
//Sending guassian blur image to sobel edge detector
        for(int y = 1; y < src.rows - 1; y++){
            for(int x = 1; x < src.cols - 1; x++){
                gx = xGradient(src, x, y);
                gy = yGradient(src, x, y);
                sum = abs(gx) + abs(gy);
                sum = sum > 255 ? 255:sum;
                sum = sum < 0 ? 0 : sum;
                dst.at<uchar>(y,x) = sum;
            }
        }

        namedWindow("final");
        imshow("final", dst);

        namedWindow("initial");
        imshow("initial", src);

      waitKey();


    return 0;
}

