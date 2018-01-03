//
//  DateModel.m
//  demo
//
//  Created by 吴斌清 on 2018/1/3.
//  Copyright © 2018年 winphonesoftware. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel


//@"2018-01-03"  YYYY-MM-dd
/*
 字符串转时间，有时间差   GTM 0
 */
+(NSInteger)totalDaysInMonthFromStr:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    return [self totalDaysInMonthFromDate:date];
}

+(NSInteger)totalDaysInMonthFromDate:(NSDate *)date{
    /*
    - (NSRange)rangeOfUnit:(NSCalendarUnit)smaller inUnit:(NSCalendarUnit)larger forDate:(NSDate *)date
    返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围，比如:
    . 要取得2008/11/12在所在月份的日期范围则可以这样调用该方法:
    [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate:fDate];
    则返回1-31。注: fDate存放了2008/11/12
    . 要取得2008/02/20在所在月份的日期范围则可以这样调用该方法:
    [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:fDate];
    则返回1-29。注: fDate存放了2008/11/12
    */
    NSRange dayRange = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return dayRange.length;
}


+(NSInteger)weekDayMonthOfFirstDayFromDateStr:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    return [self weekDayMonthOfFirstDayFromDate:date];
}

+(NSInteger)weekDayMonthOfFirstDayFromDate:(NSDate *)date{
    NSInteger firstDayMonthInt = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    return firstDayMonthInt - 1;
}

@end
