//
//  FlashGoodsTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/8.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashGoods.h"
@interface FlashGoodsTableViewController : UITableViewController
@property(retain,nonatomic)FlashGoods *fgoods;
@property(retain,nonatomic)NSMutableArray *goodsArray;
@end
