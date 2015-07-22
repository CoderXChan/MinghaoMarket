//
//  StarShopGoods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/2.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@interface StarShopGoods : NSObject

@property (copy,nonatomic) NSString *starShopGoodsDescription;
@property (copy,nonatomic) NSString *starShopGoodsId;//商品id
@property (copy,nonatomic) NSString *starShopGoodsPrice;
@property (copy,nonatomic) NSString *starShopGoodsPid;//商品编号
@property (copy,nonatomic) NSString *starShopGoodsName;
@property (copy,nonatomic) NSString *starShopGoodsBrand;
@property (copy,nonatomic) NSString *starShopGoodsStyle;
@property (copy,nonatomic) NSString *starShopGoodsPlace;
@property (copy,nonatomic) NSString *starShopGoodsDiscount;
@property (copy,nonatomic) NSString *starShopGoodsDiscountTime;

@property (strong,nonatomic) NSMutableArray *starShopGoodsImage;


@property (strong,nonatomic) Picture *thumbPicture;


@property (strong,nonatomic) NSMutableArray *thumbPicture2;
@end
