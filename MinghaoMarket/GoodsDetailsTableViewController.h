//
//  GoodsDetailsTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "MingHaoApiService.h"
#import "MenuGoods.h"
@class LatestOnlineGoods;
@interface GoodsDetailsTableViewController : UITableViewController
@property(retain,nonatomic)NSMutableArray *goodsDetails;
//@property (copy,nonatomic) NSString *goodsId;
@property(retain,nonatomic)Goods *goods;
@property(retain,nonatomic)MenuGoods *menuGoods;
@property(strong,nonatomic)LatestOnlineGoods *lolGoods;

@property(retain,nonatomic)NSMutableArray *userMsg;

@end
