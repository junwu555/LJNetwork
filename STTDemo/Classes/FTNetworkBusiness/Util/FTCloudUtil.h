//
//  FTCloudUtil.h
//  RiceBall
//
//  Created by QMY on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "FTBusinessMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTCloudUtil : NSObject

/** 输出接口请求时间
 * @param date 请求时间
 * @param path 接口域名
 */
+ (void)showSynsDate:(NSDate *)date
                path:(NSString *)path;

/** 网络环境判断
 * @param isTine 网络toast提示 YES:提示 NO:不提示
 */
+ (BOOL)linkToNetWorkShowTint:(BOOL)isTine;


/** 处理portType(单独放在Util中处理的目的在于，与回调处理类和网络接口类解耦，避免后期此字段改动或删除，造成接口大面积改动)
* @param portType 上层定义参数类型portType
* @param networkUrlType http method
* @param header 响应头
* @param error 网络接口回调error对象
* @param language 语言
 */
+ (void)disposePortType:(NSString *)portType
             networType:(NetworkURLType)networkUrlType
         responseHeader:(nullable NSDictionary *)header
                  error:(NSError *)error
              langruage:(FTLanguageInterfaceType)language;

/**加载Loading视图
 * @param baseView Loading视图载体
 */
+ (void)creatNetwrokLoading:(UIView *)baseView;

/**移除Loding视图*/
+ (void)dismissLoading;

@end

NS_ASSUME_NONNULL_END
