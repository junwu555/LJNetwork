//
//  RBError.m
//  RiceBall
//
//  Created by QMY on 2021/3/5.
//

#import "FTCLoudError.h"

@implementation FTCLoudError
#warning 业务逻辑错综复杂 后面拆分
+ (NSString *)netWorkTostInputStr:(NSError *)error portPath:(NSString *)path showTosk:(NSString *)showTosk{
    if ([showTosk isEqualToString:@"SHILIANG"]) {
        // 首页APP更新报错不做提示
        return @"";
    }else if ([showTosk isEqualToString:NOTine]){
        return @"";
    }
    NSError *underError = error.userInfo[@"NSUnderlyingError"];
    NSData *data;
    NSString *str = @"";
    NSString *tineStr = @"";
#pragma mark - 所有报错的接口  1.没有红包
    /**
     {"key1":["value1","value2"],"key2":["value3"]}
     {"key1":"value"}
     string
     ***/
    UIViewController *vc = [ViewUtil jsd_getCurrentViewController];
    @try {
        id currentData  = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if ([currentData isKindOfClass:[NSData class]]) {
            str = [[NSString alloc] initWithData:currentData encoding:NSUTF8StringEncoding];
        }else{
            str = [NSString stringWithFormat:@"%@",currentData];
        }
        if (![str isKindOfClass:[NSNull class]]  && str){
            // 转化成数据类型
            if (![str isEqualToString:@"[]"] || ![str isEqualToString:@"{}"]) {
                NSMutableDictionary *errDict = [[NSMutableDictionary alloc]initWithDictionary:[DataToJsonClass stringTojsonData:str]];
                if (errDict.allKeys.count >0) {
                    NSArray *allkeyArr = errDict.allKeys;
                    // 订单中团送的已截单 团送已完成弹框提示
                    if ([allkeyArr containsObject:@"bulk_delivery"]) {
                        return str;
                    }
                    @autoreleasepool {
                        for (int i = 0; i < allkeyArr.count; i++) {
                            NSString *keyStr = [allkeyArr objectAtIndex:i];
                            id data = [errDict valueForKey:keyStr];
                            if ([data isKindOfClass:[NSArray class]]) {
                                // 数组
                                NSArray *valueArr = [[NSArray alloc]initWithArray:data];
                                @autoreleasepool {
                                    for (int j = 0; j < valueArr.count; j++) {
                                        if ([[valueArr objectAtIndex:j] isKindOfClass:[NSDictionary class]]) {
                                            NSDictionary *tempDic = [valueArr objectAtIndex:j];
                                            for (id valueObj in tempDic.allValues) {
                                                if ([valueObj isKindOfClass:[NSArray class]]) {
                                                    for (NSString *newvalueStr in valueObj) {
                                                        tineStr = [tineStr stringByAppendingFormat:@"%@\n",newvalueStr];
                                                    }
                                                }else{
                                                    NSString *newvalueStr = tempDic[valueObj];
                                                    tineStr = [tineStr stringByAppendingFormat:@"%@\n",newvalueStr];
                                                }
                                                
                                            }
                                        }else{
                                            NSString *valueStr = [valueArr objectAtIndex:j];
                                            tineStr = [tineStr stringByAppendingFormat:@"%@\n",valueStr];
                                        }
                                    }
                                }
                            }else if ([data isKindOfClass:[NSString class]]){
                                // 字符串
                                NSString *dataStr = [NSString stringWithFormat:@"%@",data];
                                if (i == 0 || i == allkeyArr.count-1) {
                                    tineStr = [tineStr stringByAppendingFormat:@"%@",dataStr];
                                }else{
                                    tineStr = [tineStr stringByAppendingFormat:@"\n%@",dataStr];
                                }
                            }
                        }
                    }
                }
            }else{
                // 不是一个字典
                //就是一个数组了
                tineStr = str;
            }
            
        }
        if (kStringIsEmpty(tineStr)) {
            data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            str = [[str componentsSeparatedByString:@":"]lastObject];
            str = [ViewUtil replaceInput:str];
            tineStr= str;
        }
        if (kStringIsEmpty(tineStr)){
           data=underError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            tineStr = str;
        }
    }@catch (NSException *exception) {
        tineStr = @"";
        str = @"";
        
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[ _`@#$%^&*()+=|{}':;',\\[\\].<>@#￥%……&*（）——+|{}【】‘；：”“’""。，、？]|\n|\r|\t"];
    tineStr = [tineStr stringByTrimmingCharactersInSet:set];
    tineStr= [tineStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    if ([tineStr containsString:@"</html"]||[tineStr containsString:@"</body>"]||[tineStr containsString:@"</div>"]) {
        tineStr = @"";
    }
    if (error.code == 401) {
        NSMutableDictionary *hdDict = [NSMutableDictionary dictionary];
        [hdDict setValue:@"401" forKey:@"type"];
        if (path) {
            [hdDict setValue:path forKey:@"path"];
        }
//        HDErrorLog(hdDict);
        [RBEN_NSUserDefaults RBEN_NSUserDeleteKey:@"loginInformation"];
//        [[MyCache shareYYCache]removeObjectForKey:@"loginInformation"];
        [RJBadgeController clearBadgeForKeyPath:RB_UNREADCOUT_TABBAR3_LOGININFO];
        [RBUserInfo userDidLogOut];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LoadDataWithCart" object:nil];
        if ([path containsString:@"orders"]){
            return  @"";
        }
    }
    
    if ([showTosk containsString:EVALUATION]) {
        return tineStr;
    }
    
    if ([showTosk isEqualToString:NOTine]) {
    }else if ([showTosk isEqualToString:NOHAVECODENOTINE]){
        id currentData = [DataToJsonClass stringTojsonData:str];
        if ([currentData isKindOfClass:[NSDictionary class]] || [currentData isKindOfClass:[NSMutableDictionary class]]) {
            NSDictionary *currentDict = [[NSDictionary alloc]initWithDictionary:currentData];
            if (currentDict.allKeys.count > 0) {
                NSString *errorCodeStr = [NSString toJudgeEmpty:[currentDict valueForKey:@"error_code"]];
                if (errorCodeStr.intValue != 400) {
                    if (!kStringIsEmpty(tineStr)) {
                        if ([tineStr isEqualToString:@"请校对系统时间"]||
                            [showTosk isEqualToString:NOTineHaveValue]) {
                            
                        }else{
                            [vc.view rb_showHudWithMessage:tineStr];
                        }
                    }
                }else{
                    // code== 400
                    return errorCodeStr;
                }
            }else{
                if (!kStringIsEmpty(tineStr)) {
                    if ([tineStr isEqualToString:@"请校对系统时间"]||
                        [showTosk isEqualToString:NOTineHaveValue]) {
                        
                    }else{
                        [vc.view rb_showHudWithMessage:tineStr];
                    }
                }
            }
        }else{
            if (!kStringIsEmpty(tineStr)) {
                if ([tineStr isEqualToString:@"请校对系统时间"]||
                    [showTosk isEqualToString:NOTineHaveValue]) {
                    
                }else{
                    [vc.view rb_showHudWithMessage:tineStr];
                }
            }
        }
    }else{
        if (!kStringIsEmpty(tineStr)) {
            if ([vc isKindOfClass:[UIViewController class]]) {
                if ([tineStr isEqualToString:@"请校对系统时间"]||
                    [showTosk isEqualToString:NOTineHaveValue]) {
                    
                }else{
                    [vc.view rb_showHudWithMessage:tineStr];
                }
            }else{
                if ([tineStr isEqualToString:@"请校对系统时间"]||
                    [showTosk isEqualToString:NOTineHaveValue]) {
                    
                }else{
                    [vc.view rb_showHudWithMessage:tineStr];
                }
            }
        }
    }
    return str;
}

+ (void)handlePutImageError:(NSError *)error
                       name:(NSString *)name
{
    UIViewController *vc = [ViewUtil jsd_getCurrentViewController];
    NSError *underError = error.userInfo[@"NSUnderlyingError"];
    NSData *data=underError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str containsString:[RBBundleUtil localizedStringForKey:@"splash_authorizationFailure" comment:@"授权失败"]]) {
        // 跳转登录页面forwardLoginWithController
        [ViewUtil forwardLoginWithControllerinput:name];
    }else if ([str containsString:@"红包"]){
        
    }else{
        [vc.view rb_showHudWithMessage:str];
    }
}
@end
