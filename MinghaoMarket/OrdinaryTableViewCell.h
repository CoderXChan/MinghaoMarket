//
//  OrdinaryTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/7.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface OrdinaryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *oImage;

@property (strong, nonatomic) IBOutlet UILabel *oTitle;


@property (strong, nonatomic) IBOutlet UILabel *oDisCount;


@property (strong, nonatomic) IBOutlet MyButton *showMsgBtn;



@end
