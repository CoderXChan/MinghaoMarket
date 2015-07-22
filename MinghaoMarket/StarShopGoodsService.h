//
//  StarShopGoodsService.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/2.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StarShopGoodsService : NSObject

//查看明星店铺商品
-(BOOL)showStarShopGoods:(NSString *)shopID;


//查看明星店铺商品详情
-(BOOL)showStarShopGOODSMsg:(NSString *)goodsID;

@end
