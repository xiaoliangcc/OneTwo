//
//  XLPhotoManager.h
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/12.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLalbumModel.h"
#import "XLAssetModel.h"
@interface XLPhotoManager : NSObject

//单例
+ (instancetype)sharePhotoManager;

//检查APP相册授权
+ (void)checkAuthorizationStatusWithSourceType:(XLImagePickerSourceType)type callBack:(void(^)(XLImagePickerSourceType sourceType, XLAuthorizationStatus status)) callBackBlock;

/**
 读取『相机胶卷』的信息
 
 @param isDesc          是否为倒序
 @param isShowEmpty     是否显示为空的情况
 @param isOnlyShowImage 是否只显示图片
 @param completionBlock 返回数组<XLTAlbumModel>
 */
- (void)loadCameraRollInfoisDesc:(BOOL)isDesc isShowEmpty:(BOOL)isShowEmpty isOnlyShowImage:(BOOL)isOnlyShowImage CompletionBlock:(void (^)(XLAlbumModel *result))completionBlock;

/**
 读取所有相册的信息
 
 @param isShowEmpty     是否显示空相册
 @param isDesc          是否为倒序
 @param isOnlyShowImage 是否只显示图片
 @param completionBlock 返回数组<XLTAlbumModel>
 */
- (void)loadAlbumInfoIsShowEmpty:(BOOL)isShowEmpty isDesc:(BOOL)isDesc isOnlyShowImage:(BOOL)isOnlyShowImage CompletionBlock:(void(^)(PHFetchResult *customAlbum, NSArray *albumModelArray)) completionBlock;

/**
 保存图片到系统相册
 
 @param image           待保存图片
 @param completionBlock 回调
 */
- (void)saveImageToSystemAlbumWithImage:(UIImage *)image completionBlock:(void(^)(PHAsset *asset, NSString *error))completionBlock;

@end
