//
//  HouseServiceTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/27.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodFoods.h"
@interface HouseServiceTableViewController : UITableViewController
@property(retain,nonatomic)NSMutableArray *goodFoodsArray;
@property(retain,nonatomic)NSMutableArray *messageGoodsArray;

@property(retain,nonatomic)GoodFoods *goodFoods;


@property(retain,nonatomic)NSMutableArray *myStoreMsg;

@end
