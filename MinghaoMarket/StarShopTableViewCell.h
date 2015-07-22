//
//  StarShopTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface StarShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;


@property (weak, nonatomic) IBOutlet UIImageView *shopImage;


@property (weak, nonatomic) IBOutlet UILabel *shopNameLable;


@property (weak, nonatomic) IBOutlet UILabel *fansNum;


@property (weak, nonatomic) IBOutlet UILabel *scoreNum;


@property (weak, nonatomic) IBOutlet UILabel *salesNum;


@property (weak, nonatomic) IBOutlet UILabel *goodsNum;


//@property (strong, nonatomic) IBOutlet MyButton *showGoodsBtn;


@property (strong, nonatomic) IBOutlet MyButton *showGoods;


@end
