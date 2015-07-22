//
//  ShoppingCarGoods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/27.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCarGoods : NSObject
//  商品ID
@property(copy,nonatomic)NSString *shoppingCarGoodsId;
//  商品名称
@property(copy,nonatomic)NSString *shoppingCarGoodsName;
//  商品描述
@property(copy,nonatomic)NSString *shoppingCarGoodsDescribe;
//  商品价格
@property(copy,nonatomic)NSString *shoppingCarGoodsPrice;
//  商品折扣
@property(copy,nonatomic)NSString *shoppingCarGoodsDiscount;
//  商品数量
@property(copy,nonatomic)NSString *shoppingCarGoodsNum;
//  商品图片
@property (strong,nonatomic) NSMutableArray *shoppingCarGoodsImage;

@end
