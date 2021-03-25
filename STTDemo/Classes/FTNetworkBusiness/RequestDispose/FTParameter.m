//
//  FTParameter.m
//  RiceBall
//
//  Created by QMY on 2021/3/5.
//

#import "FTParameter.h"
#import "NetworkURL.h"
#import "RBDeviceInfo.h"
#import "FTHttpBaseMacro.h"

@implementation FTParameter

/// 接口域名和参数
/// @param path 接口名
/// @param portType 接口的类型
/// @param networkUrlType 请求方式枚举
+ (NSString *)calibrationPath:(NSString *)path
                     portType:(NSString *)portType urlType:(NetworkURLType)networkUrlType {
    
    if ([path containsString:@"https://"]||[path containsString:@"http://"]) {
        path = path;
//        if (![portType isEqualToString:@"city"]) {
//
//            parameters = [NSMutableDictionary new];
//        }
    }
    else if (networkUrlType == NetworkURLGET ) {
        // 所有get 请求
        path= [NSString stringWithFormat:@"%@/%@",[ViewUtil getPort],path];
    }else if (networkUrlType == NetworkURLPOST){
        // post 请求
        path = [NSString stringWithFormat:@"%@/%@/",[ViewUtil getPort],path];
    }else if (networkUrlType == NetworkURLDELETE){
        // DELETE 请求
        path = [NSString stringWithFormat:@"%@/%@",[ViewUtil getPort],path];
    }else if (networkUrlType == NetworkURLPUT){
        // PUT 请求
        path = [NSString stringWithFormat:@"%@/%@/",[ViewUtil getPort],path];
    }else{
        if (![path rangeOfString:@"http"].length) {
            path = [NSString stringWithFormat:@"%@%@?",[NetworkURL nowURL],path];
        }
    }

    // 根据判断对接口url空格的处理
    path = [NSString replaceSpaceWithPath:path portType:portType];
    return path;
}

+ (NSDictionary *)calibrationParam:(NSDictionary *)param
{
    NSString *metaJson = [self getMetaParameters];
    if (!kStringIsEmpty(metaJson)) {
        if (param == nil) {
            param = [NSMutableDictionary dictionary];
        }
         [param setValue:metaJson forKey:@"meta"];
    }
    return param;
}

+ (NSString *)getPutUploadPath
{
    NSString *portStr = [NSString stringWithFormat:@"%@%@/",[ViewUtil getPort],@"/wechat_v2"];
    NSString * uploadURL = [NSString stringWithFormat:@"%@/%@%@",portStr,@"users/",[RBUserInfo login_id]];
    return uploadURL;
}
#pragma mark - 返回meta公参数

+ (NSString *)getMetaParameters {
    
    NSMutableDictionary *metaDic = [NSMutableDictionary dictionary];
    
    // wechatId
    NSString *weChatId = [NSString toJudgeEmpty:[RB_ConfigCache getWechat_ID]];
    [metaDic setValue:weChatId forKey:@"wechatId"];
    
    // deviceId
    NSString *deviceId = [RBDeviceInfo getDeviceId];
    [metaDic setValue:deviceId forKey:@"deviceId"];
    
    NSString *metaJson;
    if (metaDic && metaDic.allKeys.count > 0) {
        metaJson = [metaDic mj_JSONString];
    }

    return metaJson;
    
}


@end
