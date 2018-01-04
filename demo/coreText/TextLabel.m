//
//  TextLabel.m
//  demo
//
//  Created by 吴斌清 on 2018/1/4.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "TextLabel.h"
#import <CoreText/CoreText.h>

#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
@implementation TextLabel{
    
    NSRange sepRange;
    CGRect  sepRect;
}

-(void)drawRect:(CGRect)rect{
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:NSFontAttributeName,[UIFont systemFontOfSize:16], nil];
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:self.text attributes:nil];//infoDict
    
    [attriStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, self.text.length)];
    
    sepRange = NSMakeRange(25, 5);
    [attriStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:sepRange];
    
    //生成CTFrame
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CTFramesetterRef frameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriStr);
    
    CGPathRef pathRef = CGPathCreateWithRect(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), &CGAffineTransformIdentity);
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), pathRef, nil);
    
    //调整坐标 CoreFoundation中坐标系  (0,0)在屏幕左下角
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    CGContextTranslateCTM(contextRef, 0, self.frame.size.height);//把坐标系上升self的高度   (-self.frame.size.height,0)  按(0,0)坐标系在屏幕左上角
    CGContextScaleCTM(contextRef, 1, -1);//将Y轴翻转 (0,0) 按(0,0)坐标系在屏幕的左上角
    //绘制
    CTFrameDraw(frameRef, contextRef);
#pragma mark -- 获取特殊字符
    //获取信息
    NSArray *lineAry = (__bridge NSArray*) CTFrameGetLines(frameRef);
    
    CGPoint pointAry[lineAry.count];
    memset(pointAry, 0, sizeof(pointAry));
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), pointAry);//由于坐标系的关系  不直接通过这种方式拿行(CTLine)的起始位置
    double heightAddup = 0;// Y
    //CTLine信息
    for (int i=0; i<lineAry.count; i++) {
        
        CTLineRef lineRef = (__bridge CTLineRef) lineAry[i];
        NSArray *runArray = (__bridge NSArray *) CTLineGetGlyphRuns(lineRef);
        
        CGFloat ascent = 0;//上行高度
        CGFloat descent = 0;//下行高度
        CGFloat lineGap = 0;//字高度
        CTLineGetTypographicBounds(lineRef, &ascent, &descent, &lineGap);
        
        double startX = 0;
        //字的高度
        double runHeight = ascent + descent + lineGap;
        //CTRun信息
        for (int j=0; j<runArray.count; j++) {
            
            CTRunRef runRef = (__bridge CTRunRef) runArray[j];
            CFRange runRange = CTRunGetStringRange(runRef);
            double runWidth = CTRunGetTypographicBounds(runRef, CFRangeMake(0, 0), 0, 0, 0);
            if (runRange.location == sepRange.location && runRange.length == sepRange.length) {
                NSLog(@"确定到了位置"); //计算需要的位置和size, rect
                NSLog(@"%f, %f, %f, %f",startX,heightAddup,runWidth,runHeight);
                sepRect = CGRectMake(startX + runWidth*2/5, heightAddup, runWidth/5, runHeight);
            }
            startX += runWidth;
        }
        //字的高度叠加
        heightAddup += runHeight;
//        NSLog(@"%f===%f",pointAry[i].y,heightAddup);
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(sepRect, point)) {
        NSLog(@"点中了");
    }
    
}









@end
