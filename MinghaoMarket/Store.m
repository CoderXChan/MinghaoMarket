//
//  Store.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/25.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "Store.h"
static NSString *sId;
@implementation Store
@synthesize storeName,storeImage;
@synthesize myStoreName,myStorePicture,storeId,storePay;

-(id)initWithShopId:(NSString *)shopId withShopName:(NSString *)shopName withShopPay:(NSString *)shopPay withShopImg:(NSString *)shopImg{
    self=[super init];
    if (self) {
        self.storeId=shopId;
        self.storePay=shopPay;
        self.myStoreName=shopName;
        self.myStorePicture=shopImg;
    }
    return self;
}




+(void)setShopId:(NSString *)shopId{
    sId=shopId;

}
+(NSString *)getShopId{
    return sId;
}

@end
