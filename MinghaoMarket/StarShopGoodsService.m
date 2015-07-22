//
//  StarShopGoodsService.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/2.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "StarShopGoodsService.h"
#import "MingHaoApiService.h"
MingHaoApiService *mhApi;
@implementation StarShopGoodsService

-(BOOL)showStarShopGoods:(NSString *)shopID{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi showStarShopGoods:shopID]) {
        return NO;
    }
    return YES;

}



//查看明星店铺商品详情
-(BOOL)showStarShopGOODSMsg:(NSString *)goodsID{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi showStarShopGoodsMsg:goodsID]) {
        return NO;
    }
    return YES;

}


@end
