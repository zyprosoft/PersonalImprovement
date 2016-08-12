//
//  DateTool.h
//  MiniPC
//
//  Created by xiongyoudou on 16/5/27.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
+ (long)yearOnDate:(NSDate *)date;
+ (long)monthOnDate:(NSDate *)date;
+ (long)dayOnDate:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;
+ (NSInteger)weekdayOnDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateString;
+(NSString *)getDateStrJustToTheDay:(NSString *)dateStr;
+ (NSInteger)nthWeekdayOnDate:(NSDate *)date;
+ (NSInteger)nthWeekdayOfYearOnDate:(NSDate *)date;
+ (NSInteger)daysAfterDate1:(NSDate *)date1 date2:(NSDate *)date2;
+ (NSDate *) dateByAddingDays:(NSInteger) dDays fromDate:(NSDate *)fromDate;
+ (NSDate *)getChineseDateFromDate:(NSDate *)date;
+ (NSDictionary *)chineseCalendar:(NSDate *)date;
+ (NSString *)lunarStrWithDate:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter;
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
+ (NSDate *)lastdayOfMonth:(NSDate *)date;
+ (NSDate *)begindayOfMonth:(NSDate *)date;
+ (NSDate *)dateAfterDay:(NSUInteger)day date:(NSDate *)date;
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day;
+ (NSDate *)dateAfterMonth:(NSUInteger)month date:(NSDate *)date;
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month;
+ (BOOL)isLeapYear:(NSDate *)date;
+ (NSDate *)getNormalDateFromDate:(NSDate *)date;
+(NSInteger) calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd;
+(NSComparisonResult)compareDate1:(id)source1 withDate2:(id)source2;
+ (BOOL)isCurrentDay:(NSDate *)aDate otherDay:(NSDate *)bDate;
@end
