//
//  FlashGoods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/1.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"

@interface FlashGoods : NSObject
@property(copy,nonatomic)NSString *flashGoodsName;
@property(copy,nonatomic)NSString *flashGoodsDiscountTime;
@property(copy,nonatomic)NSString *flashGoodsID;
@property(copy,nonatomic)NSString *flashGoodsDiscount;
@property(copy,nonatomic)NSString *flashGoodsPrice;
@property (strong,nonatomic) NSArray *thumbPictures;
@property (strong,nonatomic) Picture *thumbPicture;
@end
