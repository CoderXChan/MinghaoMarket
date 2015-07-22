//
//  UserServices.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "UserServices.h"
#import "User.h"
#import "MingHaoApiService.h"

User *user;
MingHaoApiService *mhApi;
@implementation UserServices


//用户注册
-(BOOL)registed:(User *)user{
    mhApi=[[MingHaoApiService alloc] init];
    if (![mhApi registed:user]) {
        return NO;
    }
    return YES;
}



//用户登录
-(BOOL)login:(User *)user{
    mhApi=[[MingHaoApiService alloc]init];
    if (![mhApi login:user]) {
        return NO;
    }
    return YES;
}


//用户兑换物品
-(BOOL)userGetPointGoods:(NSString *)userID withPointGoodsId:(NSString *)goodsId withNum:(NSString *)num{
    mhApi=[[MingHaoApiService alloc]init];
    if (![mhApi login:user]) {
        return NO;
    }
    return YES;
}




@end
