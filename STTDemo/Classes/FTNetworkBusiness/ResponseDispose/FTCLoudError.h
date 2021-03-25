//
//  FTCLoudError.h
//  RiceBall
//
//  Created by QMY on 2021/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTCLoudError : NSObject

/// 接口错误提示
/// @param error error
/// @param path 域名
/// @param showTosk 错误处理的标记
+ (NSString *)netWorkTostInputStr:(NSError *)error portPath:(NSString *)path showTosk:(NSString *)showTosk;

+ (void)handlePutImageError:(NSError *)error
                       name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
