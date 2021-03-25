//
//  FTBusinessMacro.h
//  RiceBall
//
//  Created by QMY on 2021/3/15.
//

#ifndef FTBusinessMacro_h
#define FTBusinessMacro_h

typedef NS_OPTIONS(NSUInteger, FTLanguageInterfaceType)
{
    /**
    *  英文版接口
    */
    RBLanguageInterfaceEng = 1,
    
    /**
    *  非英文版接口
    */
    RBLanguageInterfaceOther   = 2,
    
};

//POST接口上传图片name
static int const networkAbilityErrorCode = 5230;

//POST接口上传图片name
static NSString * const networkAbilityErrorMsg= @"网络连接错误";

//POST接口上传图片name
static NSString * const postUploadImageName = @"images.jpg";

//PUT接口上传图片name
static NSString * const putUploadImageName = @"hi1.jpg";

//接口上传图片类型
static NSString * const uploadImageType = @"image/jpeg";

#endif /* FTBusinessMacro_h */
