//
//  InTheSaleTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InTheSaleTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *InTheSaleGoodsImage;


@property (strong, nonatomic) IBOutlet UILabel *InTheSaleGoodsName;


@property (strong, nonatomic) IBOutlet UILabel *InTheSaleGoodsNote;



@property (strong, nonatomic) IBOutlet UILabel *InTheSaleGoodsPrice;


@property (strong, nonatomic) IBOutlet UILabel *InTheSaleGoodsDiscount;


@property (strong, nonatomic) IBOutlet UILabel *InTheSaleGoodsPlace;

@end
