//
//  XLAssetBaseModel.h
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/13.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//

#import <Foundation/Foundation.h>

//媒体类型
typedef NS_ENUM(NSUInteger, XLAssetModelMediaType) {
    XLAssetModelMediaTypeImage,
    XLAssetModelMediaTypeLivePhoto,
    XLAssetModelMediaTypeGIF,
    XLAssetModelMediaTypeVideo,
    XLAssetModelMediaTypeAudio,
    XLAssetModelMediaTypeUnkown
};
@interface XLAssetBaseModel : NSObject
@property (copy, nonatomic) NSString *identifier;

@property (assign, nonatomic) XLAssetModelMediaType type;

//只有当 type 为 video 时有值
@property (assign, nonatomic) NSTimeInterval videoDuration;
@end
