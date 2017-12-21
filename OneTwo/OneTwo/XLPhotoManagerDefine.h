//
//  XLPhotoManagerDefine.h
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/12.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//

#ifndef XLPhotoManagerDefine_h
#define XLPhotoManagerDefine_h
typedef NS_ENUM(NSUInteger, XLImagePickerAccessType) {
    XLImagePickerAccessTypePhotosWithoutAlbuXL,        //无相册界面，但直接进入相册胶卷
    XLImagePickerAccessTypePhotosWithAlbuXL,           //有相册界面，但直接进入相册胶卷
    XLImagePickerAccessTypeAlbuXL                      //直接进入相册界面
};

typedef NS_ENUM(NSUInteger, XLImagePickerSourceType) {
    XLImagePickerSourceTypePhoto,              //图片
    XLImagePickerSourceTypeCamera,             //相机
    XLImagePickerSourceTypeSound               //声音
};

typedef NS_ENUM(NSUInteger, XLAuthorizationStatus) {
    XLAuthorizationStatusNotDetermined,        //未知
    XLAuthorizationStatusRestricted,           //受限制
    XLAuthorizationStatusDenied,               //拒绝
    XLAuthorizationStatusAuthorized            //授权
};

typedef NS_ENUM(NSUInteger, XLImageMomentGroupType) {
    XLImageMomentGroupTypeNone,          //无分组
    XLImageMomentGroupTypeYear,          //年
    XLImageMomentGroupTypeMonth,         //月
    XLImageMomentGroupTypeDay            //日
};

typedef NS_ENUM(NSUInteger, XLImagePickerStyle) {
    XLImagePickerStyleLight,       //浅色
    XLImagePickerStyleDark         //深色
};

#endif /* XLPhotoManagerDefine_h */
