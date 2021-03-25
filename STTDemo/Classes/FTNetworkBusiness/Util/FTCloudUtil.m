//
//  FTCloudUtil.m
//  RiceBall
//
//  Created by QMY on 2021/3/8.
//

#import "FTCloudUtil.h"
#import "RB_PortTimeTextView.h"
#import "Reachability.h"
#import "RefreshLoadingView.h"
#import "RBEN_LoginViewAdpter.h"
static const RefreshLoadingView * lodingView = nil;

@implementation FTCloudUtil

+ (void)showSynsDate:(NSDate *)date path:(NSString *)path{
    
    if (RB_ShowNetworkTime) {
        NSDate *currentDate = [NSDate date];
        NSTimeInterval timeInt = [currentDate timeIntervalSinceDate:date];
        NSString *portName;
        NSRange nameRange = [path rangeOfString:@"wechat_v2/"];
        if(nameRange.location != NSNotFound){
            CGFloat location = nameRange.location + nameRange.length;
            portName = [path substringWithRange:NSMakeRange(location, path.length - location - 1)];
        }else{
            portName = path;
        }
        NSString *contentStr = [NSString stringWithFormat:@"名字：%@\n   时间：%.3f",portName,timeInt];
        [[RB_PortTimeTextView share] setContent:contentStr];
    }
}


+ (BOOL)linkToNetWorkShowTint:(BOOL)isTine{
    
    UIViewController *vc = [ViewUtil jsd_getCurrentViewController];
    // isTine yes 是显示 no 是不现实
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];//reachabilityForInternetConnection
    //    [conn startNotifier];
    // 3.判断网络状态
    //    NotReachable = 0,
    //    ReachableViaWiFi,
    //    ReachableViaWWAN
    if ([conn currentReachabilityStatus] == NotReachable) {
        if (isTine) {
            NSString *message = [RBBundleUtil localizedStringForKey:@"splash_netWorking" comment:@"无网络，请检查网络连接"];
            [vc.view rb_showHudWithMessage:message];
        }
        return NO;
        
    } else if([conn currentReachabilityStatus] == ReachableViaWiFi) {
        return YES;
    }else if ([conn currentReachabilityStatus] == ReachableViaWWAN){
        return YES;
    }else{
        if (isTine) {
            NSString *message = [RBBundleUtil localizedStringForKey:@"splash_netFailWorking" comment:@"网络连接失败，请重新检查网络"];
            [vc.view rb_showHudWithMessage:message];
        }
        return NO;
    }
}

+ (void)creatNetwrokLoading:(UIView *)baseView
{
    if(lodingView)[self dismissLoading];
    lodingView = [self addLoadingShowView:baseView];
}

+ (void)dismissLoading
{
    if (lodingView) {
        [lodingView removeFromSuperview];
        lodingView = nil;
    }
}

+ (RefreshLoadingView *)addLoadingShowView:(UIView *)view{
    UIView *currentview;
    if ([view isKindOfClass:[UIView class]]) {
        currentview = view;
    }else{
      currentview = [ViewUtil jsd_getCurrentViewController].view;
    }
    RefreshLoadingView *loadingView  = (RefreshLoadingView *)[[[NSBundle mainBundle]loadNibNamed:@"RefreshLoadingView" owner:self options:nil]firstObject];
    loadingView.frame = currentview.bounds;
    loadingView.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
    [loadingView loadingViewHeartAnimation];
    [currentview addSubview:loadingView];
    [currentview bringSubviewToFront:loadingView];
    return loadingView;
}

+ (void)disposePortType:(NSString *)portType
             networType:(NetworkURLType)networkUrlType
         responseHeader:(nullable NSDictionary *)header
                  error:(NSError *)error
              langruage:(FTLanguageInterfaceType)language
{
    if (language == RBLanguageInterfaceEng) {
        UIViewController *vc = [ViewUtil jsd_getCurrentViewController];
        
        if (error.code == 1){
            if (![portType isEqual:NOTine]) {
                
                [vc.view rb_showHudWithMessage:error.domain];
            }
        }
        else {
            if (![portType isEqual:NOTine]&&error.code != 1200) {
                
                [vc.view rb_showHudWithMessage:[RBBundleUtil localizedStringForKey:@"splash_serverError"]];
            }
        }
    }
    else {
        if (networkUrlType == NetworkURLGET && header) {
            PublicClass *public  = [PublicClass setPublicClass];
            if ([portType isEqualToString:@"resaurantDetailCommentTotalNumber"]) {
                public.resaurantDetailCommentTotalNumberStr = [NSString stringWithFormat:@"%@",[header valueForKey:@"X-Total-Count"]];
            }
            if ([portType isEqualToString:@"couponNumber"]) {
                // 优惠券的个数
                public.couponsNumberIndex = [[NSString toJudgeEmpty:[header valueForKey:@"X-Total-Count"]]intValue];
            }
        }
    }
}
@end
