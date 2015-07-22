//
//  StarGoodsDetailsTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/3.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarShopGoods.h"
@interface StarGoodsDetailsTableViewController : UITableViewController
@property(retain,nonatomic)StarShopGoods *starGoods;
@property(retain,nonatomic)NSMutableArray *starGoodsDetails;
@property(retain,nonatomic)NSMutableArray *userMsg;
@end
