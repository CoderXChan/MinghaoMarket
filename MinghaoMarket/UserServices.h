//
//  UserServices.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserServices : NSObject

//用户注册
-(BOOL)registed:(User *)user;

//用户登录
-(BOOL)login:(User *)user;


//用户兑换物品
-(BOOL)userGetPointGoods:(NSString *)userID withPointGoodsId:(NSString *)goodsId withNum:(NSString *)num;



@end
