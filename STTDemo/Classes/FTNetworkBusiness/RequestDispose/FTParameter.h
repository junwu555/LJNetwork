//
//  FTParameter.h
//  RiceBall
//
//  Created by QMY on 2021/3/5.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface FTParameter : NSObject

/**Request path Calibration*/
+ (NSString *)calibrationPath:(NSString *)path
                     portType:(NSString *)portType urlType:(NetworkURLType)networkUrlType;

/**Request param Calibration*/
+ (NSDictionary *)calibrationParam:(NSDictionary *)param;

/**Put Image URL*/
+ (NSString *)getPutUploadPath;
@end

NS_ASSUME_NONNULL_END
