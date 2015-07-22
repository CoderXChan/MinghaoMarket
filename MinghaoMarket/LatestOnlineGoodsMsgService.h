//
//  LatestOnlineGoodsMsgService.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"
@interface LatestOnlineGoodsMsgService : NSObject

//查看最新上线商品详情订单
-(BOOL)showLatestOnlineGoodsMsg:(NSString *)goodsID;


//查看限时活动商品
-(BOOL)showFlashGoods:(NSString *)goodsID;


//搜索商品
-(BOOL)searchGoods:(NSString *)goodsName;



//搜索店铺
-(BOOL)searchShops:(NSString *)shopsName;



@end
