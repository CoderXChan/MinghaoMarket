//
//  GoodFoodsDescTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/7/1.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodFoods.h"
#import "Goods.h"
@interface GoodFoodsDescTableViewController : UITableViewController

@property(retain,nonatomic)Goods *goods;


@property(retain,nonatomic)GoodFoods *goodFoods;


@property(retain,nonatomic)NSMutableArray *goodFoodsDetails;
@end
