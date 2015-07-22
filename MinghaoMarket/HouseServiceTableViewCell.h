//
//  HouseServiceTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/27.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface HouseServiceTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *houseServiceImage;



@property (strong, nonatomic) IBOutlet UITextView *houseServiceTitle;


@property (strong, nonatomic) IBOutlet UILabel *houseServiceSubTitle;


@property (strong, nonatomic) IBOutlet UILabel *houseServicePrice;




@property (strong, nonatomic) IBOutlet MyButton *descBtn;

@end
