//
//  FlashTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface FlashTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *flashImage;


@property (weak, nonatomic) IBOutlet UILabel *flashTitle;


@property (weak, nonatomic) IBOutlet UILabel *flashRestTime;


@property (strong, nonatomic) IBOutlet UILabel *flashDiscount;



@property (strong, nonatomic) IBOutlet MyButton *flashBtn;


@end
