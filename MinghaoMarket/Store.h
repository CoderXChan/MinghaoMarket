//
//  Store.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/25.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@interface Store : NSObject{
    NSString *storeName;
    NSString *storeImage;
}

@property(nonatomic,retain)NSString *storeName;
@property(nonatomic,retain)NSString *storeImage;

@property(copy,nonatomic)NSString *moneyGiveYesOrNo;

@property(copy,nonatomic)NSString *myStoreName;
@property (strong,nonatomic) Picture *myStorePicture;

@property(copy,nonatomic)NSString *storeId;

@property(copy,nonatomic)NSString *storePay;

//@property(copy,nonatomic)NSString *storeImg;
//店铺上下架的商品
@property(copy,nonatomic)NSString *storeGoodsName;
@property(copy,nonatomic)NSString *storeGoodsPrice;
@property(strong,nonatomic)Picture *storeGoodsImage;
@property(copy,nonatomic)NSString *storeGoodsDesc;
@property(copy,nonatomic)NSString *storeGoodsSellIngTopast;//上下架判断字段



-(id)initWithShopId:(NSString *)shopId withShopName:(NSString *)shopName withShopPay:(NSString *)shopPay withShopImg:(NSString *)shopImg;


+(void)setShopId:(NSString *)shopId;
+(NSString *)getShopId;



@end
