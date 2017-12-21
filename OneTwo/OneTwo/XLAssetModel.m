//
//  XLAssetModel.m
//  OneTwo
//
//  Created by zhangxiaoliang on 2017/12/13.
//  Copyright © 2017年 zhangxiaoliang. All rights reserved.
//

#import "XLAssetModel.h"

@implementation XLAssetModel
+ (instancetype)modelWithAsset:(PHAsset *)asset {
    XLAssetModel *model = [XLAssetModel new];
    
    model.asset = asset;
    
    return model;
}

- (NSString *)identifier {
    return self.asset.localIdentifier;
}

- (XLAssetModelMediaType)type {
    if (self.asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) return XLAssetModelMediaTypeLivePhoto;
    
    if (self.asset.mediaType == PHAssetMediaTypeImage) return XLAssetModelMediaTypeImage;
    
    if (self.asset.mediaType == PHAssetMediaTypeVideo) return XLAssetModelMediaTypeVideo;
    
    if (self.asset.mediaType == PHAssetMediaTypeAudio) return XLAssetModelMediaTypeAudio;
    
    return XLAssetModelMediaTypeUnkown;
}

- (NSTimeInterval)videoDuration {
    if (self.type == XLAssetModelMediaTypeVideo)
        return self.asset.duration;
    else
        return 0.f;
}

- (NSString *)description {
    return self.debugDescription;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p> identifier:%@ | type: %zi", [self class], self, self.identifier, self.type];
}
@end
