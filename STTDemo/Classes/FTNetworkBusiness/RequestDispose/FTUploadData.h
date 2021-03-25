//
//  FTUploadData.h
//  RiceBall
//
//  Created by QMY on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "FTStreamDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTUploadData : NSObject<FTStreamDataProtocol>

- (void)insert:(FTHttpUploadConfig *)config;

@end

NS_ASSUME_NONNULL_END
