//
//  YNCodeImageOperation.h
//  AgentSsales
//
//  Created by innofive on 17/2/22.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNCodeImageOperation : NSObject

+(UIImage*)getCodeImageWithContent:(NSString*)content width:(CGFloat)width;

@end
