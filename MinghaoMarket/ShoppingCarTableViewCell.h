//
//  ShoppingCarTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/28.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
#import "ShoppingCarTableViewController.h"
@interface ShoppingCarTableViewCell : UITableViewCell
//  商品配图
@property (strong, nonatomic) IBOutlet UIImageView *shoppingCarImage;

//  商品名称
@property (strong, nonatomic) IBOutlet UILabel *shoppingCarGoodsName;

//  商品价格
@property (strong, nonatomic) IBOutlet UILabel *shoppingCarGoodsPrice;

//  商品描述
@property (strong, nonatomic) IBOutlet UILabel *shoppingCarGoodsDes;

//  删除按钮
@property (strong, nonatomic) IBOutlet MyButton *shoppingCarDeleteBtn;

//  人民币壁纸
@property (strong, nonatomic) IBOutlet UILabel *shoppingCarDiscount;

//  商品折扣价
@property (strong, nonatomic) IBOutlet UILabel *shoppingDiscountThanPrice;

//  合计价格
@property (strong, nonatomic) IBOutlet UILabel *shoppingAllPrice;

//  商品数量
@property (weak, nonatomic) IBOutlet UITextField *textDisplay;

//  购物车控制器
@property(nonatomic,assign)ShoppingCarTableViewController *sctvc;


-(void)setContentWithString:(int)it;

@property (nonatomic,assign) int i;




@end
