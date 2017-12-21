//
//  XLAssetModel.h
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/13.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "XLAssetBaseModel.h"

@interface XLAssetModel : XLAssetBaseModel
@property (strong, nonatomic) PHAsset *asset;

@property (assign, nonatomic, getter=isSelected) BOOL selected;

+ (instancetype)modelWithAsset:(PHAsset *)asset;

@end
