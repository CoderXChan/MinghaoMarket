//
//  LatestOnlineGoods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestOnlineGoods : NSObject
@property(copy,nonatomic)NSString *latestOnlineGoodsName;
@property(copy,nonatomic)NSString *latestOnlineGoodsDiscount;
@property(copy,nonatomic)NSString *latestOnlineGoodsDiscountTime;
@property (copy,nonatomic) NSString *latestOnlineGoodsPrice;
@property (copy,nonatomic) NSString *latestOnlineGoodsID;
@property (copy,nonatomic) NSString *latestOnlineGoodsBrand;//pinpai
@property (copy,nonatomic) NSString *latestOnlineGoodsStyle;
@property (copy,nonatomic) NSString *latestOnlineGoodsPlace;


@property (strong,nonatomic) NSMutableArray *thumbPictures;


@property (strong,nonatomic) NSMutableArray *thumbPictures2;
@end
