//
//  YNClearCache.m
//  AgentSsales
//
//  Created by innofive on 17/1/11.
//  Copyright © 2017年 英诺. All rights reserved.
//

#import "YNClearCache.h"

@implementation YNClearCache

// 显示缓存大小
+(CGFloat)cacheSize
{
    
    NSString * cachePath = [ NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    
    return [self folderSizeAtPath :cachePath];
    
}
//1:首先我们计算一下 单个文件的大小

+ (NSInteger) cacheSizeAtPath:( NSString *) cachePath{

    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :cachePath]){
        
        return [[manager attributesOfItemAtPath :cachePath error : nil ] fileSize];
    }
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
+( float ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self cacheSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}

// 清理缓存
+(BOOL)clearCacheFile
{
    NSString * cachePath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachePath];
    
    for ( NSString * file in files) {
        
        NSString * path = [cachePath stringByAppendingPathComponent :file];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :nil];
        }
    }
    return YES;
//    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
@end
