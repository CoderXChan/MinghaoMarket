//
//  LoadPictureModel.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/26.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Picture;
@protocol  LoadPictureModelDelegate<NSObject>
@optional



@end


@interface LoadPictureModel : NSObject
- (instancetype)initWithImageName:(NSString *) name;


@property(weak,nonatomic)id <LoadPictureModelDelegate>delegate;

@property (copy,nonatomic) NSString *name;
@property(readonly)NSMutableArray *flashGoods;
//
-(void)loadImage;


//块  的方式回调取值
-(void)loadPicture:(Picture *)picture putOffLoadHandler:(void(^)(NSData *data))handler;
@end
