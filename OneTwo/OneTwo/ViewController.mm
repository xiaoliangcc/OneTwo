//
//  ViewController.m
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/5.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//


#define kImageName @"20161212163518.png"

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UIImageView *originalImageView;

@end

@implementation ViewController
#pragma mark - 获取图像的红绿蓝单色通道
- (void)test6 {
    
    self.originalImageView.image = [UIImage imageNamed:kImageName];
    // Do any additional setup after loading the view, typically from a nib.
    IplImage *src1;
    const char *src1Str = [[[NSBundle mainBundle]pathForResource:kImageName ofType:nil] cStringUsingEncoding:NSUTF8StringEncoding];
    src1 = cvLoadImage(src1Str,-1);
  
    
    
    IplImage *des1  = cvCreateImage(cvSize(src1->width, src1->height), IPL_DEPTH_8U, 1);
    IplImage *des2  = cvCreateImage(cvSize(src1->width, src1->height), IPL_DEPTH_8U, 1);
    IplImage *des3  = cvCreateImage(cvSize(src1->width, src1->height), IPL_DEPTH_8U, 1);
    
    //通道分割
    cvSplit(src1, des1, des2, des3, NULL);

    //绿
    IplImage* grayImagePlus2 = cvCreateImage(cvGetSize(des2), IPL_DEPTH_8U, 3);
    cvCvtColor(des2, grayImagePlus2, CV_GRAY2BGR);
    
    
    
    //注意UIImage只能装在多通道图像
    UIImage *destUIImage = [self UIImageFromIplImage:grayImagePlus2 withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.image = destUIImage;
    
    cvReleaseImage(&src1);
    cvReleaseImage(&des1);
    cvReleaseImage(&des2);
    cvReleaseImage(&grayImagePlus2);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //蒙版抠图
    self.originalImageView.image = [UIImage imageNamed:kImageName];
    // Do any additional setup after loading the view, typically from a nib.
    IplImage *src1;
    ///Users/zhangxiaoliang/Library/Developer/CoreSimulator/Devices/04769A87-7EC0-44EB-89E4-688E669A8C5E/data/Containers/Bundle/Application/C981F39B-9974-4910-B392-761130552874/OneTwo.app/20161212163518.png
    NSString *strOc =@"/Users/zhangxiaoliang/WorkFile/xxx-mmm/OneTwo.app/20161212163518.png";
    //NSString *strOc = @"/Users/zhangxiaoliang/Library/Developer/CoreSimulator/Devices/04769A87-7EC0-44EB-89E4-688E669A8C5E/data/Containers/Bundle/Application/C981F39B-9974-4910-B392-761130552874/OneTwo.app/20161212163518.png";
    //NSString *strOc = [[NSBundle mainBundle]pathForResource:kImageName ofType:nil];
    //strOc = [strOc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    const char *src1Str = [strOc cStringUsingEncoding:NSUTF8StringEncoding];
    src1 = cvLoadImage(src1Str,-1);
    printf("channelsSrc = %d",src1->nChannels);
    
    IplImage *des1  = cvCreateImage(cvSize(src1->width, src1->height), IPL_DEPTH_8U, 1);
    IplImage *des2  = cvCreateImage(cvSize(src1->width, src1->height), IPL_DEPTH_8U, 1);
    IplImage *des3  = cvCreateImage(cvSize(src1->width, src1->height), IPL_DEPTH_8U, 1);
    cvSplit(src1, des1, des2, des3, NULL);
    
    //红
    IplImage* grayImagePlus1 = cvCreateImage(cvGetSize(des1), IPL_DEPTH_8U, 3);
    cvCvtColor(des1, grayImagePlus1, CV_GRAY2BGR);
    
    //绿
    IplImage* grayImagePlus2 = cvCreateImage(cvGetSize(des2), IPL_DEPTH_8U, 3);
    cvCvtColor(des2, grayImagePlus2, CV_GRAY2BGR);
    
    uchar *dataPlus2 = (uchar *)grayImagePlus2->imageData;
    int stepPlus2 = grayImagePlus2->widthStep/sizeof(uchar);
    int channelsPlus2 = grayImagePlus2->nChannels; //图片通道数
    
    uchar *dataSrc = (uchar *)src1->imageData;
    int stepSrc = src1->widthStep/sizeof(uchar);
    int channelsSrc = src1->nChannels; //图片通道数
    
    
    
    uchar r = 0,g = 0,b = 0;
    for (int i = 0; i < grayImagePlus2->height; i++) {
        
        for (int j = 0; j < grayImagePlus2->width; j++) {
           
            if (j > 20 && j<200 ) {
                dataPlus2[i * stepPlus2 + j * channelsPlus2 + 0] = 255;
                dataPlus2[i * stepPlus2 + j * channelsPlus2 + 1] = 255;
                dataPlus2[i * stepPlus2 + j * channelsPlus2 + 2] = 255;
            }
            //蒙版的RGB
            b = dataPlus2[i * stepPlus2 + j * channelsPlus2 + 0];
            g = dataPlus2[i * stepPlus2 + j * channelsPlus2 + 1];
            r = dataPlus2[i * stepPlus2 + j * channelsPlus2 + 2];
            dataSrc[i * stepSrc + j * channelsSrc + 3] = r;
        }
        
        
    }
    //显示一个4通道的图片
    //注意UIImage只能装在多通道图像  //显示红绿通道的颜色
    UIImage *destUIImage = [self UIImageFromIplImage:grayImagePlus2 withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.image = destUIImage;
    
    //下面的原图
    self.originalImageView.image = [self UIImageFromIplImage:src1 withAlpha:YES];
    
    self.originalImageView.contentMode = UIViewContentModeScaleAspectFit;
    cvReleaseImage(&src1);
    cvReleaseImage(&des1);
    cvReleaseImage(&des2);
    cvReleaseImage(&grayImagePlus1);
    cvReleaseImage(&grayImagePlus2);
}



#pragma mark - 图像重复复制平铺
- (void)test5
{
    self.originalImageView.image = [UIImage imageNamed:@"20130820232246_wFTHr.jpeg"];
    // Do any additional setup after loading the view, typically from a nib.
    IplImage *src1;
    const char *src1Str = [[[NSBundle mainBundle]pathForResource:@"20130820232246_wFTHr.jpeg" ofType:nil] cStringUsingEncoding:NSUTF8StringEncoding];
    src1 = cvLoadImage(src1Str,-1);
    
    IplImage *des  = cvCreateImage(cvSize(src1->width * 4, src1->height * 4), src1->depth, src1->nChannels);
    
    
    cvRepeat(src1, des);
    
    UIImage *destUIImage = [self UIImageFromIplImage:des withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.image = destUIImage;
    cvReleaseImage(&src1);
    cvReleaseImage(&des);
}



#pragma mark - 图像截取 - 获取子图像
- (void)test4
{
    IplImage *src1;
    const char *src1Str = [[[NSBundle mainBundle]pathForResource:kImageName ofType:nil] cStringUsingEncoding:NSUTF8StringEncoding];
    src1 = cvLoadImage(src1Str,-1);
    //设置选区
    cvSetImageROI(src1, cvRect(200, 0, 200, 200));
    IplImage *resultChild = cvCreateImage(cvSize(200, 200), src1->depth, src1->nChannels);
    cvCopy(src1, resultChild);//拷贝要尺寸一致
    cvResetImageROI(src1);
    UIImage *destUIImage = [self UIImageFromIplImage:resultChild withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeCenter;
    self.showImageView.image = destUIImage;
}
#pragma mark - 多图像合成
- (void)test3
{
    IplImage *src1,*src2;
    const char *src1Str = [[[NSBundle mainBundle]pathForResource:@"20161212163518.jpg" ofType:nil] cStringUsingEncoding:NSUTF8StringEncoding];
    const char *src2Str = [[[NSBundle mainBundle]pathForResource:@"Snip20171206_1.jpg" ofType:nil] cStringUsingEncoding:NSUTF8StringEncoding];
    src1 = cvLoadImage(src1Str,-1);
    src2 = cvLoadImage(src2Str,-1);
    IplImage* dst = cvCreateImage(
                                  cvSize(src1->width, src1->height),
                                  src1->depth,
                                  3);
    double alpha = 0.5; double beta;
    
    beta = 1.0 - alpha;
    //图层叠加
    cvAddWeighted(src1, alpha, src2, beta, 0.0, dst);
    //报错信息是 Sizes of input arguments do not match (The operation is neither 'array op array' (where arrays have the same size and the same number of channels 则表示需要用一样的通道数 相同的图片尺寸 两个矩阵布局要一样才能计算
    
    UIImage *destUIImage = [self UIImageFromIplImage:dst withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeScaleToFill;
    self.showImageView.image = destUIImage;
   
    
    cvReleaseImage(&src1);
    cvReleaseImage(&src2);
    cvReleaseImage(&dst);
}

#pragma mark - 设置灰度图的三种方式
- (void)test2
{
    UIImage *imageDemo = [UIImage imageNamed:@"20161212163518.jpg"];
    IplImage *cvimage = [self CreateIplImageFromUIImage:imageDemo];
    
    uchar *data = (uchar *)cvimage->imageData;
    
    int step = cvimage->widthStep/sizeof(uchar);
    int channels = cvimage->nChannels; //图片通道数
    
    uchar r = 0,g = 0,b = 0;
    
    for (int i = 0; i < cvimage->height; i++) {
        
        for (int j = 0; j < cvimage->width; j++) {
            b = data[i * step + j * channels + 0];
            g = data[i * step + j * channels + 1];
            r = data[i * step + j * channels + 2];
            
            //设置灰度的三种算法
            //CGFloat gray = r * 0.299+ g * 0.587+ 0.144 * b;  //1
            CGFloat gray = (r+g+b)/3.0; //2
            //CGFloat gray = g; //3
            
            data[i * step + j * channels + 0] = gray;
            data[i * step + j * channels + 1] = gray;
            data[i * step + j * channels + 2] = gray;
        }
        
        
    }
    UIImage *destUIImage = [self UIImageFromIplImage:cvimage withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeScaleToFill;
    self.showImageView.image = destUIImage;
    
    cvReleaseImage(&cvimage);
}

#pragma mark - 更改HSV  中的SV 数据
- (void)test1
{
    UIImage *imageDemo = [UIImage imageNamed:@"201708041925331.jpg"];
    IplImage *cvimage = [self CreateIplImageFromUIImage:imageDemo];
    
    
    for (int y = 0; y < cvimage->height ; y++) {
        
        uchar *ptr  = (uchar *)(cvimage->imageData + y * cvimage->widthStep);
        
        for (int x = 0; x<cvimage->width; x++) {
            //ptr[3 * x + 0] = 50;  //色相
            //如果把所有的颜色的色相都改了 就没有层次了 图就毁了
            ptr[3 * x + 1] = 100;  //饱和度
            ptr[3 * x + 2] = 255; //亮度
        }
        for (int x = 0; x<cvimage->width * 0.5; x++) {
            ptr[3 * x + 0] = 255;  //色相
        }
    }
    
    UIImage *destUIImage = [self UIImageFromIplImage:cvimage withAlpha:NO];
    self.showImageView.contentMode = UIViewContentModeScaleToFill;
    self.showImageView.image =  destUIImage;
    
    cvReleaseImage(&cvimage);
}

#pragma mark - UIImage转成IplImage
- (IplImage *)CreateIplImageFromUIImage:(UIImage *)image {
    
    // Getting CGImage from UIImage
    
    CGImageRef imageRef = image.CGImage;
    
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Creating temporal IplImage for drawing
    
    IplImage *iplimage = cvCreateImage(
                                       
                                       cvSize(image.size.width,image.size.height), IPL_DEPTH_8U, 4
                                       
                                       );
    
    // Creating CGContext for temporal IplImage
    
    CGContextRef contextRef = CGBitmapContextCreate(
                                                    
                                                    iplimage->imageData, iplimage->width, iplimage->height,
                                                    
                                                    iplimage->depth, iplimage->widthStep,
                                                    
                                                    colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault
                                                    
                                                    );
    
    // Drawing CGImage to CGContext
    
    CGContextDrawImage(
                       
                       contextRef,
                       
                       CGRectMake(0, 0, image.size.width, image.size.height),
                       
                       imageRef
                       
                       );
    
    CGContextRelease(contextRef);
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    // Creating result IplImage
    
    IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);
    
    cvCvtColor(iplimage, ret, CV_RGBA2BGR);
    
    cvReleaseImage(&iplimage);
    
    
    
    return ret;
    
}
#pragma mark - IplImage转成UIImage
- (UIImage *)UIImageFromIplImage:(IplImage *)image withAlpha:(BOOL)alpha {
    
    //IplImage 矩阵是 BGR 排列的 转换成UIImage之后是以RGB排列的所以需要手动调换一下b 和 r 的数据
    uchar *dataIplImage = (uchar *)image->imageData;
    for (int i = 0; i < image->height; i++) {
        for (int j = 0; j < image->width; j++) {
            CGFloat  b = dataIplImage[i * image->widthStep + j * image->nChannels + 0];
            CGFloat  r = dataIplImage[i * image->widthStep + j * image->nChannels + 2];
            
            dataIplImage[i * image->widthStep + j * image->nChannels + 0] = r;
            dataIplImage[i * image->widthStep + j * image->nChannels + 2] = b;
        }
    }
    
    
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Allocating the buffer for CGImage
    
    NSData *data =
    
    [NSData dataWithBytes:image->imageData length:image->imageSize];
    
    CGDataProviderRef provider =
    
    CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from chunk of IplImage
    int enumMy = kCGImageAlphaLast|kCGBitmapByteOrderDefault;
    if (!alpha) {
        enumMy = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    }else{
        enumMy = kCGImageAlphaLast|kCGBitmapByteOrderDefault;
    }
    CGImageRef imageRef = CGImageCreate(
                                        
                                        image->width, image->height,
                                        
                                        image->depth, image->depth * image->nChannels, image->widthStep,
                                        
                                        colorSpace, enumMy,
                                        
                                        provider, NULL, false, kCGRenderingIntentDefault
                                        
                                        );
    
    // Getting UIImage from CGImage
    
    UIImage *ret = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    CGDataProviderRelease(provider);
    
    CGColorSpaceRelease(colorSpace);
    
    return ret;
    
}

#pragma mark - CvMat转成UIImage
-(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                            //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}

#pragma mark - UIImage to cvMat
- (cv::Mat)cvMatFromUIImage:(UIImage *)image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    return cvMat;
}
@end
