//
//  MenuFirstTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface MenuFirstTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *menuFirstImage;


@property (weak, nonatomic) IBOutlet UILabel *menuFirstTitle;


@property (weak, nonatomic) IBOutlet UILabel *menuFirstRestTime;



@property (strong, nonatomic) IBOutlet UILabel *menuFirstDiscount;




@property (strong, nonatomic) IBOutlet MyButton *menuFirstBtn;



@end
