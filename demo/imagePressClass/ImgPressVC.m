//
//  ImgPressVC.m
//  demo
//
//  Created by 吴斌清 on 2018/1/4.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "ImgPressVC.h"

@interface ImgPressVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImage *_albumImage;
}

@end

@implementation ImgPressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"图片压缩";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(openAlbum)];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //内存会暴涨
    //2018-01-04 11:20:29.882085+0800 demo[7590:183880] png::4Mb746
    //2018-01-04 11:20:29.882294+0800 demo[7590:183880] jpg::1Mb661
    //_albumImage = [UIImage imageNamed:@"1.jpg"];
    
    //用上下文绘制 图片大小
    //2018-01-04 11:17:05.547356+0800 demo[7540:178415] png::237KB
    //2018-01-04 11:17:05.547587+0800 demo[7540:178415] jpg::134KB
    _albumImage = [self scaleImage:[UIImage imageNamed:@"1.jpg"] size:_pngImageV.frame.size];
    
    if (_albumImage) {
        [self imageDataLoad];
    }
}

- (void)imageDataLoad{
    //png
    NSData *pngImageData = UIImagePNGRepresentation(_albumImage);
    _pngImageV.image = [UIImage imageWithData:pngImageData];
    //jpg
    NSData *jpgImageData = UIImageJPEGRepresentation(_albumImage, 1);
    _jpgImageV.image = [UIImage imageWithData:jpgImageData];
    
    NSLog(@"png::%@",[self length:pngImageData.length]);
    NSLog(@"jpg::%@",[self length:jpgImageData.length]);
}


//bitmap
- (UIImage *)scaleImage:(UIImage*)image size:(CGSize )imageSize{
    
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return newImage;
}

- (NSString *)length:(NSInteger)length{
    if (length > 1024 * 1024) {
        
        int mb = length/(1024*1024);
        int kb = (length%(1024*1024))/1024;
        return [NSString stringWithFormat:@"%dMb%d",mb,kb];
    }else{
        return [NSString stringWithFormat:@"%dKB",length/1024];
    }
}

- (void)saveImgToLocal:(NSString *)fileName fromData:(NSData *)data{
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [filePath stringByAppendingPathComponent:filePath];
    if ([data writeToFile:filePath atomically:YES]) {
        NSLog(@"success");
    }
}


- (void)openAlbum{
    UIImagePickerController *imagePickerCtrl = [[UIImagePickerController alloc]init];
    imagePickerCtrl.delegate = self;
    imagePickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerCtrl animated:YES completion:nil];
}

#pragma mark -- UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{



}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%s",__func__);
    _albumImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
}

@end
