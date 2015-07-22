//
//  PointsForTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/28.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface PointsForTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *needsPointsNum;


@property (strong, nonatomic) IBOutlet UIImageView *pointsImage;


@property (strong, nonatomic) IBOutlet UILabel *couponsLabel;

@property (strong, nonatomic) IBOutlet UIImageView *pointGoodsImage;


@property (strong, nonatomic) IBOutlet UILabel *pointsGoodsNum;



@property (strong, nonatomic) IBOutlet MyButton *pointsBtn;


@end
