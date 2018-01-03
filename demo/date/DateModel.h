//
//  DateModel.h
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

+(NSInteger)totalDaysInMonthFromStr:(NSString *)dateStr;
+(NSInteger)totalDaysInMonthFromDate:(NSDate *)date;

+(NSInteger)weekDayMonthOfFirstDayFromDateStr:(NSString *)dateStr;
+(NSInteger)weekDayMonthOfFirstDayFromDate:(NSDate *)date;

@end
