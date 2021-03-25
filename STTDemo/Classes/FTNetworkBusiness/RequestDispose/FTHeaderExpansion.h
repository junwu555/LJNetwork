//
//  FTHeaderExpansion.h
//  RiceBall
//
//  Created by QMY on 2021/3/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTHeaderExpansion : NSObject

+ (NSDictionary *)getCustomHeaderWithUrl:(NSString *)url
isClearNetworkHeaderBool:(BOOL)needLocationInfo;
@end

NS_ASSUME_NONNULL_END
