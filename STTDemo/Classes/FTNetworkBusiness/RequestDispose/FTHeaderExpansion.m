//
//  FTHeaderExpansion.m
//  RiceBall
//
//  Created by QMY on 2021/3/5.
//

#import "FTHeaderExpansion.h"
#import "RBUserGrowth.h"
@implementation FTHeaderExpansion
+ (NSDictionary *)getCustomHeaderWithUrl:(NSString *)url
                isClearNetworkHeaderBool:(BOOL)needLocationInfo{
    NSMutableDictionary * headerDict = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    // wx_app_id
    [headerDict setValue:[RBEnvironmentManager sharedEnvironmentManager].iponeAPIID forKey:@"appid"];
    
    // 矫正后的时间戳
    id timeData = [[MyCache shareYYCache]getValueObjectKey:DIFFERTIME];
    NSString *differTimeStr = [NSString getNowTimestamp];
    if ([timeData isKindOfClass:[NSString class]] && !kStringIsEmpty(timeData) ) {
        //获取系统当前时间戳
        NSString * currentTimestamp = [NSString getNowTimestamp];
        NSInteger timeX = [currentTimestamp integerValue] + [timeData integerValue];
        differTimeStr = [NSString stringWithFormat:@"%zd",timeX];
        [headerDict setValue:differTimeStr forKey:@"timestamp"];
    }else{
       [headerDict setValue:differTimeStr forKey:@"timestamp"];
    }
    // token
    if (!kStringIsEmpty([RBUserInfo userPhoneNum])&& !kStringIsEmpty([RBUserInfo userPassWord])) {
        NSString * token =[NSString getTokenWithPhoneNum:[RBUserInfo userPhoneNum] passWord:[RBUserInfo userPassWord]resultTimeS:differTimeStr];
        [headerDict setValue:token forKey:@"token"];
    }
    // username
    if (!kStringIsEmpty([RBUserInfo userPhoneNum])) {
        [headerDict setValue:[RBUserInfo userPhoneNum] forKey:@"username"];
    }
    if (!kStringIsEmpty([RBUserInfo login_id])) {
        [headerDict setValue:[RBUserInfo login_id] forKey:@"reservedUserId"];
    }
    if (!kStringIsEmpty([RBUserInfo login_method])) {
        [headerDict setValue:[RBUserInfo login_method] forKey:@"reservedLoginMethod"];
    }
    // 语言
    [headerDict setValue:[LocalizationManager userNetworkLaunguage] forKey:@"appLang"];
    // 推送的deviceToken
    if ([url isEqualToString:@"deviceToken"]) {
        //做了版本的兼容的问题
        id devieceTokenData = USERDEFAULT_value(@"deviceToken");
        if ([devieceTokenData isKindOfClass:[NSString class]]) {
            NSString *deviceTokenStr = [NSString toJudgeEmpty:devieceTokenData];
            if (!kStringIsEmpty(deviceTokenStr)) {
                [headerDict setValue:deviceTokenStr forKey:@"deviceToken"];
            }
        }
    }
    
    // 经纬度 其他传NO
    if (needLocationInfo) {
        id latstr = [RB_ConfigCache getLat];
        if ([latstr isKindOfClass:[NSString class]] && !kStringIsEmpty(LatStr)) {
            [headerDict setValue:latstr forKey:@"lat"];// 纬度(首页左上角地址)
        }
        id lonstr = [RB_ConfigCache getLon];
        if ([lonstr isKindOfClass:[NSString class]] && !kStringIsEmpty(lonstr)) {
            [headerDict setValue:lonstr forKey:@"lng"];// 经度(首页坐上角地址)
        }
    }else{
        [headerDict setValue:@"" forKey:@"lat"];// 纬度(首页左上角地址)
        [headerDict setValue:@"" forKey:@"lng"];// 经度(首页坐上角地址)
    }
    
    // 下载
    NSString *oidownloadStr = [NSString toJudgeEmpty:[RBUserGrowth service].oidownload];
    [headerDict setValue:!kStringIsEmpty(oidownloadStr)?oidownloadStr  : @"N/A" forKey:@"DownloadChannelCode"];
    
    NSString *installstallStr = [NSString toJudgeEmpty:[RBUserGrowth service].datadownload];
    [headerDict setValue:!kStringIsEmpty(installstallStr) ?installstallStr : @"N/A" forKey:@"InstallData"];
    
    // 唤醒
    NSString *wakeChannerCode = [NSString toJudgeEmpty:[RBUserGrowth service].oiopen];
    [headerDict setValue:!kStringIsEmpty(wakeChannerCode) ? wakeChannerCode : @"N/A"  forKey:@"WakeChannelCode"];
    
    NSString *dataOpenStr = [NSString toJudgeEmpty:[RBUserGrowth service].dataopen];
    [headerDict setValue:[NSString stringWithFormat:@"%@",!kStringIsEmpty(dataOpenStr) ? dataOpenStr : @"N/A"] forKey:@"WakeData"];
    
    
    
    return [headerDict copy];
}
@end
