//
//  BeautyMakeupBoutiqueTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface BeautyMakeupBoutiqueTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bmbGoodsImage;

@property (weak, nonatomic) IBOutlet UIImageView *bmbPersonImage;

@property (weak, nonatomic) IBOutlet UILabel *bmbBuyPersonNum;

@property (weak, nonatomic) IBOutlet UIImageView *bmbShopCar;

@property (weak, nonatomic) IBOutlet UITextView *bmbGoodsDescribe;

@property (weak, nonatomic) IBOutlet UILabel *bmbGoodsDiscount;

@property (weak, nonatomic) IBOutlet UILabel *bmbGoodsOldPrice;


@property (strong, nonatomic) IBOutlet UILabel *nowPrice;



@property (strong, nonatomic) IBOutlet MyButton *beautyBtn;





@end
