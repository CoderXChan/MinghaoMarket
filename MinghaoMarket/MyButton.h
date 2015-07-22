//
//  MyButton.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "StarShopGoods.h"
#import "ShoppingCarGoods.h"
#import "MenuGoods.h"
#import "FlashGoods.h"
@interface MyButton : UIButton
@property(retain,nonatomic)Goods *goods;
@property(retain,nonatomic)FlashGoods *flashGoods;
@property(retain,nonatomic)Goods *starGoods;
@property(retain,nonatomic)StarShopGoods *trueStarGoods;
@property(retain,nonatomic)ShoppingCarGoods *shoppingCarGoods;
@property(retain,nonatomic)MenuGoods *menuGoods;
@end
