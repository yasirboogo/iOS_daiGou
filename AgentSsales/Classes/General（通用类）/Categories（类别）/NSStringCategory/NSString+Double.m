//
//  NSString+Double.m
//  AgentSsales
//
//  Created by innofive on 17/4/7.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "NSString+Double.h"

@implementation NSString (Double)

/** 直接传入精度丢失有问题的Double类型*/
+(NSString *)decimalNumberWithDouble:(NSString*)conversionValue{
    
    NSString *doubleString = [NSString stringWithFormat:@"%lf", [conversionValue doubleValue]];
    
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    NSString *decimalString = [decNumber stringValue];
    
    NSRange range = [decimalString rangeOfString:@"."];
    
    if (range.length && decimalString.length - range.location>=4) {
        decimalString = [decimalString substringToIndex:range.location+3];
    }
    
    return decimalString;
    
}

@end
