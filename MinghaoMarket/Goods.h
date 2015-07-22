//
//  Goods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/5.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@interface Goods : NSObject

@property(copy,nonatomic)NSString *goodsName;
@property(copy,nonatomic)NSString *goodsImage;
@property(copy,nonatomic)NSString *goodsDiscount;
@property(copy,nonatomic)NSString *goodsDiscountTime;
@property (copy,nonatomic) NSString *link;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *goodsPrice;
@property (copy,nonatomic) NSString *goodsID;
@property (copy,nonatomic) NSString *goodsBrand;//pinpai
@property (copy,nonatomic) NSString *goodsStyle;
@property (copy,nonatomic) NSString *goodsPlace;
@property (copy,nonatomic) NSString *goodsDesc;
@property (copy,nonatomic) NSString *goodsNum;
@property (copy,nonatomic) NSString *goodsPoints;





@property(copy,nonatomic)NSString *starShopName;
@property(copy,nonatomic)NSString *shopName;
@property(copy,nonatomic)NSString *shopLevelId;
@property(copy,nonatomic)NSString *shopDetail;
@property(copy,nonatomic)NSString *starShopId;






@property (strong,nonatomic) Picture *thumbPicture;
@property (strong,nonatomic) Picture *focusPicture;  //焦点图片
@property (strong,nonatomic) NSArray *thumbPictures;
@property (nonatomic) NSInteger totalThumbPictures;






@end
