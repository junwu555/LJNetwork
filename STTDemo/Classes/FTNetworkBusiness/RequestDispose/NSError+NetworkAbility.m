//
//  NSError+NetworkAbility.m
//  RiceBall
//
//  Created by QMY on 2021/3/16.
//

#import "NSError+NetworkAbility.h"
#import "FTBusinessMacro.h"
@implementation NSError (NetworkAbility)

+ (instancetype)getNetworkAbilityError
{
    return [NSError errorWithDomain:networkAbilityErrorMsg code:networkAbilityErrorCode userInfo:NULL];
}
@end
