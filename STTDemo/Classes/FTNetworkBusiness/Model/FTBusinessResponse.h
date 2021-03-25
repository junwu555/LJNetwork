//
//  FTBusinessResponse.h
//  RiceBall
//
//  Created by QMY on 2021/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTBusinessResponse : NSObject

/**响应code*/
@property(nonatomic ,assign)NSUInteger reponseCode;

/**响应数据*/
@property(nonatomic ,strong)id posts;

/**html first url*/
@property(nonatomic ,copy)NSString * firstLink;

/**html next url*/
@property(nonatomic ,copy)NSString * nextLink;


/**错误日志信息*/
@property(nonatomic ,strong)NSError * error;
@end

NS_ASSUME_NONNULL_END
