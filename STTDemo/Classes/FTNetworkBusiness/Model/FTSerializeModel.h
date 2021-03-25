//
//  FTSerializeModel.h
//  RiceBall
//
//  Created by QMY on 2021/3/16.
//

#import <Foundation/Foundation.h>
#import "FTHttpBaseMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTSerializeModel : NSObject

/**请求序列化方式*/
@property(nonatomic ,assign) ENUM_REQUEST_SERIALIZE requestSerialize;

/**响应序列化方式*/
@property(nonatomic ,assign) ENUM_RESPONSE_SERIALIZE responseSerialize;
@end

NS_ASSUME_NONNULL_END
