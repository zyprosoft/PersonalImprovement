//
//  DateTool.m
//  MiniPC
//
//  Created by xiongyoudou on 16/5/27.
//  Copyright © 2016年 xiongyoudou. All rights reserved.
//

#import "DateTool.h"
#import "solarOrLunar.h"
#import "LunarSolarConverter.h"

#define D_MINUTE	60
#define D_HOUR	3600
#define D_DAY	86400
#define D_WEEK	604800
#define D_YEAR	31556926

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation DateTool

+ (long)yearOnDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:date];
    return [components year];
}


+ (long)monthOnDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:date];
    return [components month];
}

+ (long)dayOnDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:date];
    return [components day];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

+ (NSInteger)weekdayOnDate:(NSDate *)date
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    
    //在公历中，星期天默认是1，则星期一就是2，为了转化为程序中处理，减去
    NSInteger weekday = components.weekday;
    if (weekday == 1) {
        weekday = 7;
    }else {
        weekday = weekday - 1;
    }
    return weekday;
}

#pragma mark 时间转字符串
+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//HH大写，表明希望转成24小时制的时间
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

#pragma mark 字符串转时间
+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

#pragma mark 只显示日期的天数，截取到天为止
+(NSString *)getDateStrJustToTheDay:(NSString *)dateStr {
    return [MyTool getStrByDeleteSuffix:dateStr andDeleteStr:@" "];
}


//获取某个日期属于第几个星期
+ (NSInteger)nthWeekdayOnDate:(NSDate *)date // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    return components.weekdayOrdinal;
}

//获取某个日期属于第几个星期
+ (NSInteger)nthWeekdayOfYearOnDate:(NSDate *)date
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    return components.weekOfYear;
}

//获取两个时间相距天
+ (NSInteger)daysAfterDate1:(NSDate *)date1 date2:(NSDate *)date2
{
    NSTimeInterval ti = [date1 timeIntervalSinceDate:date2];
    return (NSInteger) (ti / D_DAY);
}

//获取时间往前推n天后的日期
+ (NSDate *) dateByAddingDays:(NSInteger) dDays fromDate:(NSDate *)fromDate
{
    NSTimeInterval aTimeInterval = [fromDate timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark 公历转农历
+ (NSDate *)getChineseDateFromDate:(NSDate *)date {
    int year = (int)[self yearOnDate:date];
    int month = (int)[self monthOnDate:date];
    int day = (int)[self dayOnDate:date];
    
    hjz lunar =solar_to_lunar(year, month, day);/*将当前的公历时间转换为农历*/
    NSString *dateStr = [self stringFromDate:date];
    
    NSString * lunarCalenderStr = [NSString stringWithFormat:@"%4ld-%2d-%2d %@",(long)lunar.year,(int)lunar.month,(int)lunar.day,[dateStr substringWithRange:NSMakeRange(11, 8)]];
    NSDate *chineseDate = [self dateFromString:lunarCalenderStr];
    return chineseDate;
}

#pragma mark - 获取农历日期
+ (NSDictionary *)chineseCalendar:(NSDate *)date {
    //定义农历数据:
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉",
                             @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未",
                             @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳",
                             @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑",
                             @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑",
                             @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥", nil];
    
    NSArray *chineseMonths = [NSArray arrayWithObjects:
                              @"正月", @"二月", @"三月", @"四月", @"五月", @"六月",
                              @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月", nil];
    
    NSArray *chineseDays = [NSArray arrayWithObjects:
                            @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                            @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                            @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    localeCalendar.locale = [NSLocale systemLocale];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    return @{ @"chineseYear" : y_str, @"chineseMonth" : m_str, @"chineseDay" : d_str };
}

+ (NSString *)lunarStrWithDate:(NSDate *)date {
    NSDictionary *dict = [self chineseCalendar:date];
    NSString *month = [dict objectForKey:@"chineseMonth"];
    NSString *day = [dict objectForKey:@"chineseDay"];
    int year = (int)[self yearOnDate:[self getChineseDateFromDate:date]];
    NSString *time = [self stringFromDate:date formatter:@"HH:mm"];
    return [NSString stringWithFormat:@"农历%d年%@%@ %@", year, month, day, time];
}

+ (NSString *)stringFromDate:(NSDate *)date formatter:(NSString *)formatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (![dateFormatter.dateFormat isEqualToString:@"yyyy-MM-dd HH:mm:ss"]) {
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    NSString *time = [dateFormatter stringFromDate:date];
    if ([formatter isEqualToString:@"HH:mm"]) {
        time = [time substringWithRange:NSMakeRange(11, 5)];
    }
    return time;
}

//判断一个日期是否在两个日期之间
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

//获取某个日期的当月的最后一天
+ (NSDate *)lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self begindayOfMonth:date];
    return [self dateAfterDay:-1 date:[self dateAfterMonth:1 date:lastDate]];
}

//获取某个日期的当月的第一天
+ (NSDate *)begindayOfMonth:(NSDate *)date {
    return [self dateAfterDate:date day:-[self dayOnDate:date] + 1];
}

+ (NSDate *)dateAfterDay:(NSUInteger)day date:(NSDate *)date {
    return [self dateAfterDate:date day:day];
}

+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

+ (NSDate *)dateAfterMonth:(NSUInteger)month date:(NSDate *)date {
    return [self dateAfterDate:date month:month];
}

+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

//是否为闰年
+ (BOOL)isLeapYear:(NSDate *)date {
    NSUInteger year = [self yearOnDate:date];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

#pragma mark 农历转公历
+ (NSDate *)getNormalDateFromDate:(NSDate *)date {
    int year = (int)[self yearOnDate:date];
    int month = (int)[self monthOnDate:date];
    int day = (int)[self dayOnDate:date];
    
    /*
     hjz lunar =lunar_to_solar(year, month, day,[self isLeapYear:date] ? 1 :0);
     */
    Lunar *lunar = [[Lunar alloc]init];
    lunar.lunarYear = year;
    lunar.lunarMonth = month;
    lunar.lunarDay = day;
    lunar.isleap = [[self setReservedInt:[NSString stringWithFormat:@"%d",month]] integerValue];
    Solar *solar = [LunarSolarConverter lunarToSolar:lunar];
    
    NSString *dateStr = [self stringFromDate:date];
    
    NSString * lunarCalenderStr = [NSString stringWithFormat:@"%4d-%2d-%2d %@",(int)solar.solarYear,(int)solar.solarMonth,(int)solar.solarDay,[dateStr substringWithRange:NSMakeRange(11, 8)]];
    NSDate *chineseDate = [self dateFromString:lunarCalenderStr];
    return chineseDate;
}

+(NSString *)setReservedInt:(NSString *)Monthstring{
    NSString * strBasePath =[[NSBundle mainBundle] pathForResource:@"month" ofType:@"plist"];
    NSDictionary *dic =[NSDictionary dictionaryWithContentsOfFile:strBasePath];
    
    NSString * strMonth =[[[dic objectForKey:Monthstring] componentsSeparatedByString:@"x"] lastObject];
    return strMonth;
}

#pragma mark 获取两个日期的天数间隔
+(NSInteger) calcDaysFromBegin:(NSDate *)inBegin end:(NSDate *)inEnd {
    NSInteger unitFlags = NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [cal components:unitFlags fromDate:inBegin];
    NSDate *newBegin  = [cal dateFromComponents:comps];
    
    NSCalendar *cal2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps2 = [cal2 components:unitFlags fromDate:inEnd];
    NSDate *newEnd  = [cal2 dateFromComponents:comps2];
    
    NSTimeInterval interval = [newEnd timeIntervalSinceDate:newBegin];
    NSInteger beginDays=((NSInteger)interval)/(3600*24);
    return beginDays;
}

#pragma mark 比较两个时间大小 NSOrderedAscending为source1小于source2
+(NSComparisonResult)compareDate1:(id)source1 withDate2:(id)source2 {
    NSDate *date1,*date2;
    if ([source1 isKindOfClass:[NSDate class]]) {
        date1 = source1;
    }
    if ([source2 isKindOfClass:[NSDate class]]) {
        date2 = source2;
    }
    if ([source1 isKindOfClass:[NSString class]]) {
        date1 = [self dateFromString:source1];
    }
    if ([source2 isKindOfClass:[NSString class]]) {
        date2 = [self dateFromString:source2];
    }
    return [date1 compare:date2];
}

#pragma mark 如何判断两个时间是否是同一天
+ (BOOL)isCurrentDay:(NSDate *)aDate otherDay:(NSDate *)bDate {
    if ((aDate==nil) || (bDate==nil)) return NO;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:bDate];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitYear|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:aDate];
    NSDate *otherDate = [cal dateFromComponents:components];
    if([today isEqualToDate:otherDate])
        return YES;
    return NO;
}

@end
