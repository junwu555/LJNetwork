//
//  FTResponseHandle.h
//  RiceBall
//
//  Created by QMY on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import "FTBusinessResponse.h"
#import "FTBusinessMacro.h"
#import "FTHttpBaseMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface FTResponseHandle : NSObject

+ (FTBusinessResponse *)handleResponse:(id  _Nullable)responseObject
                                  date:(NSDate *)date
                                  path:(NSString *)path method:(ENUM_REQUEST_METHOD)method
                        responseHeader:(NSDictionary *)header
                              language:(FTLanguageInterfaceType)language;

@end

NS_ASSUME_NONNULL_END
