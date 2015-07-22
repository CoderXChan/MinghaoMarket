//
//  GoodsListCollectionViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/11.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface GoodsListCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *goodsListImage;


@property (strong, nonatomic) IBOutlet UILabel *goodsListName;


@property (strong, nonatomic) IBOutlet UILabel *goodsListDiscount;


@property (strong, nonatomic) IBOutlet UIButton *buyNow;


@property (strong, nonatomic) IBOutlet MyButton *starShopGoodsBtn;




@end
