//
//  MenuGoods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/5.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuGoods : NSObject

@property(copy,nonatomic)NSString *menuGoodsDescription;

@property(copy,nonatomic)NSString *menuGoodsProductID;

@property(copy,nonatomic)NSString *menuGoodsProductPrice;

@property(copy,nonatomic)NSString *menuGoodsPId;

@property(copy,nonatomic)NSString *menuGoodsSellIngTopast;

@property(copy,nonatomic)NSString *menuGoodsPname;

@property(copy,nonatomic)NSString *menuGoodsProductBrand;

@property(copy,nonatomic)NSString *menuGoodsProductStyle;

@property(copy,nonatomic)NSString *menuGoodsProductPlace;

@property(copy,nonatomic)NSMutableArray *menuGoodsProductimageslist;

@property(copy,nonatomic)NSString *menuGoodsProductDiscount;

@property(copy,nonatomic)NSString *menuGoodsProductSelected;

@property(copy,nonatomic)NSString *menuGoodsDiscountTime;

@end
