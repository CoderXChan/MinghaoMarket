//
//  ShoppingCarTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/10.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

//@protocol shoppingCarVCDelegate <NSObject>
//
//- (void)shoppingCarVCWithWillPayGoodsArray:(NSArray *)goodsArray;
//
//@end

@interface ShoppingCarTableViewController : UITableViewController

@property(retain,nonatomic)NSMutableArray *currentUserAllShoppingCarGoods;


@property(retain,nonatomic)NSMutableArray *userMsg;
@property(retain,nonatomic)Goods *goods;

@property(retain,nonatomic)NSMutableArray *goodsMsg;

//-(void)relodataMethod;
//// 购物车的代理   为了拿到预定订单的数
//@property (assign,nonatomic) id<shoppingCarVCDelegate> delegate;
//
@property (strong, nonatomic) IBOutlet UILabel *theAllMoney;


 @property (nonatomic,assign)float tempNum;


@property (nonatomic,strong)   NSMutableArray * cellArray;


@end
