//
//  LatestOnlineGoodsMsgService.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "LatestOnlineGoodsMsgService.h"
#import "MingHaoApiService.h"
Goods *good;
MingHaoApiService *mhApi;
@implementation LatestOnlineGoodsMsgService


//查看最新上线商品详情订单

-(BOOL)showLatestOnlineGoodsMsg:(NSString *)goodsID{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi showLatestOnlineGoodsMsg:goodsID]) {
        return NO;
    }
    return YES;
    


}


//查看限时活动商品
-(BOOL)showFlashGoods:(NSString *)goodsID{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi showFlashGoods:goodsID]) {
        return NO;
    }
    return YES;

}



//搜索商品
-(BOOL)searchGoods:(NSString *)goodsName{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi showSearchGoods:goodsName]) {
        return NO;
    }
    return YES;

}


//搜索店铺
-(BOOL)searchShops:(NSString *)shopsName{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi showSearchShops:shopsName]) {
        return NO;
    }
    return YES;


}


@end
