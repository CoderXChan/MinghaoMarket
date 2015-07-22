//
//  FlashGoodsTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/8.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface FlashGoodsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *flashGoodsImage;

@property (strong, nonatomic) IBOutlet UITextView *flashGoodsTitle;

@property (strong, nonatomic) IBOutlet UILabel *flashGoodsBuyer;


@property (strong, nonatomic) IBOutlet UILabel *flashGoodsDiscount;



@property (strong, nonatomic) IBOutlet UILabel *flashGoodsPrice;


@property (strong, nonatomic) IBOutlet MyButton *flashGoodsBtn;


@end
