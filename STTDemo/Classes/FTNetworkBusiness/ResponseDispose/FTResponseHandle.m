//
//  FTResponseHandle.m
//  RiceBall
//
//  Created by QMY on 2021/3/8.
//

#import "FTResponseHandle.h"
#import "FTCloudUtil.h"
#import "RBEN_LoginViewAdpter.h"
#import "FTBusinessResponse.h"

@implementation FTResponseHandle





+ (FTBusinessResponse *)handleResponse:(id  _Nullable)responseObject
                                  date:(NSDate *)date
                                  path:(NSString *)path method:(ENUM_REQUEST_METHOD)method
                        responseHeader:(NSDictionary *)header
                              language:(FTLanguageInterfaceType)language
{
    
    FTBusinessResponse * ftResponse = [FTBusinessResponse new];
    UIViewController *vc = [ViewUtil jsd_getCurrentViewController];
    // 打印接口数据(控制器 域名 返回数据)
    DLog(@"控制器:%@\n 域名:%@\n responseObject:%@",vc,path,responseObject);
    [FTCloudUtil showSynsDate:date path:path];//输出接口请求时间
        if (language == RBLanguageInterfaceOther) {
            NSString * nextStr = @"";
            NSString *firstStr = @"";
            //如果响应头里包含Link时,说明有分页
            if ([header.allKeys containsObject:@"Link"]) {
                //Link是包含多个url并且有特殊字符且用逗号隔开的字符串
                NSString * linkStr = [header objectForKey:@"Link"];
                NSArray * linkArray = [ViewUtil containsSpecialStr:linkStr];
                //遍历linkArray中的字典,如果有key=next,那么进行分页数据的请求,请求完为止
                @autoreleasepool {
                    for (int i = 0; i < linkArray.count; i++) {
                        NSDictionary *linkDict = [linkArray objectAtIndex:i];
                        if ([linkDict.allKeys containsObject:@"next"]) {
                            nextStr = [linkDict valueForKey:@"next"];
                            
                        }else if ([linkDict.allKeys containsObject:@"first"]){
                            firstStr = [linkDict valueForKey:@"first"];
                        }
                    }
                }
            }
            if (method != REQUEST_TYPE_DELELTE) {
                ftResponse.firstLink = firstStr;
                ftResponse.nextLink = nextStr;
            }
            
            ftResponse.posts = responseObject;
        }
        else {
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && ![responseObject isKindOfClass:[NSNull class]]) {
                NSDictionary * response = [[NSDictionary alloc] initWithDictionary:responseObject];
                NSInteger code = [[response valueForKey:@"code"]integerValue];
                NSString * msg = [NSString toJudgeEmpty:[response valueForKey:@"msg"]];
                id data = [response valueForKey:@"data"];
                if (code == 0) {
                    
                    if (data) ftResponse.posts = data;
                    ftResponse.reponseCode = code;
                }
                else {
                    if (code == 1200) {
                        // 授权失败
                        [RBEN_NSUserDefaults RBEN_NSUserDeleteKey:@"loginInformation"];
                        [RJBadgeController clearBadgeForKeyPath:RB_UNREADCOUT_TABBAR3_LOGININFO];
                        [RBUserInfo userDidLogOut];
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"LoadDataWithCart" object:nil];
                        [RBEN_LoginViewAdpter showLoginViewControllerWithWelcomeRedPaperIDS:nil loginSuccessCallBack:nil];
                    }
                    ftResponse.error = [NSError errorWithDomain:msg code:code userInfo:nil];
                }
            }
        }
        return ftResponse;
}


/// 接口请求数据处理
/// @param responseObject 接口返回数据
/// @param date 请求时间
/// @param path 域名
/// @param networkUrlType 请求方式枚举
+ (FTBusinessResponse *)returnResponseObject:(id  _Nullable)responseObject date:(NSDate *)date path:(NSString *)path UrlType:(NetworkURLType)networkUrlType
 {
    FTBusinessResponse * ftResponse = [FTBusinessResponse new];
    UIViewController *vc = [ViewUtil jsd_getCurrentViewController];
    // 打印接口数据(控制器 域名 返回数据)
    DLog(@"控制器:%@\n 域名:%@\n responseObject:%@",vc,path,responseObject);
    [FTCloudUtil showSynsDate:date path:path];//输出接口请求时间
    @try {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && ![responseObject isKindOfClass:[NSNull class]]) {
            NSDictionary * response = [[NSDictionary alloc] initWithDictionary:responseObject];
            NSInteger code = [[response valueForKey:@"code"]integerValue];
            NSString * msg = [NSString toJudgeEmpty:[response valueForKey:@"msg"]];
            id data = [response valueForKey:@"data"];
            if (code == 0) {
                if (data) ftResponse.posts = data;
            
                ftResponse.reponseCode = code;
            }else if (code == 1){
#warning 上移
//                if (![portType isEqual:NOTine]) {
//
//                    [vc.view rb_showHudWithMessage:msg];
//                }
                ftResponse.error = [NSError errorWithDomain:msg code:code userInfo:nil];
            }else if (code == 1200){
                // 授权失败
                [RBEN_NSUserDefaults RBEN_NSUserDeleteKey:@"loginInformation"];
                [RJBadgeController clearBadgeForKeyPath:RB_UNREADCOUT_TABBAR3_LOGININFO];
                [RBUserInfo userDidLogOut];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"LoadDataWithCart" object:nil];
                [RBEN_LoginViewAdpter showLoginViewControllerWithWelcomeRedPaperIDS:nil loginSuccessCallBack:nil];
                
                ftResponse.error = [NSError errorWithDomain:msg code:code userInfo:nil];
            }
            else{
#warning 上移
//                if (![portType isEqual:NOTine]) {
//
//                    [vc.view rb_showHudWithMessage:[RBBundleUtil localizedStringForKey:@"splash_serverError"]];
//                }
                ftResponse.error = [NSError errorWithDomain:msg code:code userInfo:nil];
            }
        }
    } @catch (NSException *exception) {
        
    }
}

#warning 移除RefreshLoadingView 数据处理类不应处理视图逻辑 此建议逻辑上浮到BaseViewController

@end
