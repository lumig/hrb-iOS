/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}


+ (NSString *)constellationForDate:(NSString *)date
{
    
    NSString *constellation = @"白羊座";
    
    if ([date length] >= 10)
    {
        int moth = [[date substringWithRange:NSMakeRange(5, 2)]intValue];
        int day = [[date substringWithRange:NSMakeRange(8, 2)]intValue];
        
        switch (moth)
        {
            case 1:
                if (day <= 19)
                {
                    constellation = @"魔蝎座";
                }else
                {
                    constellation = @"水瓶座";
                }
                break;
            case 2:
                if (day <= 18)
                {
                    constellation = @"水瓶座";
                }else
                {
                    constellation = @"双鱼座";
                }
                break;
            case 3:
                if (day <= 20)
                {
                    constellation = @"双鱼座";
                }else
                {
                    constellation = @"白羊座";
                }
                break;
            case 4:
                if (day <= 19)
                {
                    constellation = @"白羊座";
                }else
                {
                    constellation = @"金牛座";
                }
                break;
            case 5:
                if (day <= 20)
                {
                    constellation = @"金牛座";
                }else
                {
                    constellation = @"双子座";
                }
                break;
            case 6:
                if (day <= 21)
                {
                    constellation = @"双子座";
                }else
                {
                    constellation = @"巨蟹座";
                }
                break;
            case 7:
                if (day <= 22)
                {
                    constellation = @"巨蟹座";
                }else
                {
                    constellation = @"狮子座";
                }
                break;
            case 8:
                if (day <= 22)
                {
                    constellation = @"狮子座";
                }else
                {
                    constellation = @"处女座";
                }
                break;
            case 9:
                if (day <= 22)
                {
                    constellation = @"处女座";
                }else
                {
                    constellation = @"天秤座";
                }
                break;
            case 10:
                if (day <= 23)
                {
                    constellation = @"天秤座";
                }else
                {
                    constellation = @"天蝎座";
                }
                break;
            case 11:
                if (day <= 22)
                {
                    constellation = @"天蝎座";
                }else
                {
                    constellation = @"射手座";
                }
                break;
            case 12:
                if (day <= 21)
                {
                    constellation = @"射手座";
                }else
                {
                    constellation = @"魔蝎座";
                }
                break;
                
            default:
                break;
        }
    }

    return constellation;
}



@end
