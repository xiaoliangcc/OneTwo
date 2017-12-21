//
//  XLTalbumModel.h
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/13.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//
#import <Photos/Photos.h>
#import <Foundation/Foundation.h>
#import "XLAssetModel.h"
@interface XLAlbumModel : NSObject
/**
 相册名
 */
@property (copy  , nonatomic) NSString *albumName;

/**
 是否是『相机胶卷』
 */
@property (assign, nonatomic) BOOL isCameraRoll;

/**
 图片个数
 */
@property (assign, nonatomic, readonly) NSUInteger count;

/**
 相册内容
 */
@property (strong, nonatomic) PHFetchResult *content;

@property (strong, nonatomic) NSArray <XLAssetModel *>*models;
@end
