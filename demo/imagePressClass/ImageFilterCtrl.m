//
//  ImageFilterCtrl.m
//  demo
//
//  Created by 吴斌清 on 2018/1/4.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "ImageFilterCtrl.h"

@interface ImageFilterCtrl ()

@property(nonatomic,strong)UIImage *image;

@end

@implementation ImageFilterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"图片处理";
    UIBarButtonItem *origImageBt = [[UIBarButtonItem alloc]initWithTitle:@"还原" style:UIBarButtonItemStylePlain target:self action:@selector(originalImage)];
    
    UIBarButtonItem *filterImageBt = [[UIBarButtonItem alloc]initWithTitle:@"过滤" style:UIBarButtonItemStylePlain target:self action:@selector(fiflterImage)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:origImageBt,filterImageBt, nil];
    
    self.image = [UIImage imageNamed:@"3.jpg"];
    _filterImageV.image = self.image;
}


- (void)originalImage{
    _filterImageV.image = self.image;
}

/*
 从图片文件把 图片的数据的像素拿出来(RGBA),对像素进行操作，进行一个转换(bitmap(GPU))
 修改完之后，还原(图片的属性 RGBA,
 RGBA(宽度，高度，色值空间，拿到宽度和高度,每一个画多少个像素，画多少行))
 */

- (void)fiflterImage{
    
    CGImageRef imageRef = self.image.CGImage;
    //1个字节 = 8bit  每行有7680 每行有7680 * 8 位
    size_t width = CGImageGetWidth(imageRef);//1920
    size_t height = CGImageGetHeight(imageRef);//1080
    size_t bits = CGImageGetBitsPerComponent(imageRef);//8
    size_t bitsPerrow = CGImageGetBytesPerRow(imageRef);//width * bits    7680
    
    //颜色空间  RGBA   AGBR  RGB
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    /////demo
//    NSString *testStr = @"1234567890abcde";
//    NSData *data = [testStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //转化bitmap的数据
    CGDataProviderRef providerRef = CGImageGetDataProvider(imageRef);
    CFDataRef bitmapData = CGDataProviderCopyData(providerRef);
    
    NSInteger pixLength = CFDataGetLength(bitmapData);
    Byte *pixbuf = CFDataGetMutableBytePtr(bitmapData);
    
    //RGBA为一个单元
    for (int i=0; i<pixLength; i+=4) {
        
//        int height = (i / (width*4));
//        int pixX = (i / (width*4));
        
        [self imageFilterPixBuf:pixbuf offset:i];
    }
    
    //准备绘制图片
    //通过bitmap 生成一个上下文,再通过上下文生成图片
    CGContextRef contextRef = CGBitmapContextCreate(pixbuf, width, height, bits, bitsPerrow, colorSpace, alphaInfo);
    
    CGImageRef filterImageRef = CGBitmapContextCreateImage(contextRef);
    
    UIImage *filterImage = [UIImage imageWithCGImage:filterImageRef];
    
    _filterImageV.image = filterImage;
}

//RGBA 为一个单元 彩色照片变黑白照
- (void)imageFilterPixBuf:(Byte *)pixBuf offset:(int )offset{
    
    int offsetR = offset;
    int offsetG = offset + 1;
    int offsetB = offset + 2;
    int offsetA = offset + 3;
    
    int red = pixBuf[offsetR];
    int gre = pixBuf[offsetG];
    int blu = pixBuf[offsetB];
    int alp = pixBuf[offsetA];
    
    int gray = (red + gre + blu)/3;
    
    pixBuf[offsetR] = gray;
    pixBuf[offsetG] = gray;
    pixBuf[offsetB] = gray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
