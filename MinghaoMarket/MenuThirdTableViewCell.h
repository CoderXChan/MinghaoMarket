//
//  MenuThirdTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface MenuThirdTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *menuThirdImage;

@property (strong, nonatomic) IBOutlet UILabel *menuThirdTitle;

@property (strong, nonatomic) IBOutlet UILabel *menuThirdRestTime;

@property (strong, nonatomic) IBOutlet UILabel *menuThirdDiscount;


@property (strong, nonatomic) IBOutlet MyButton *menuThirdBtn;



@end
