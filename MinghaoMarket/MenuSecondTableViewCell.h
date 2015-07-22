//
//  MenuSecondTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface MenuSecondTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *menuSecondImage;


@property (strong, nonatomic) IBOutlet UILabel *menuSecondTitle;


@property (strong, nonatomic) IBOutlet UILabel *menuSecondRestTime;


@property (strong, nonatomic) IBOutlet UILabel *menuSecondDiscount;


@property (strong, nonatomic) IBOutlet MyButton *menuSecondBtn;




@end
