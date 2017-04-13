//
//  YNImageSize.h
//  AgentSsales
//
//  Created by innofive on 17/2/21.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNImageSize : NSObject

+(CGSize)downloadImageSizeWithURL:(id)imageURL;

+(CGSize)calculateImageSizeWithURL:(id)imageURL;

@end
