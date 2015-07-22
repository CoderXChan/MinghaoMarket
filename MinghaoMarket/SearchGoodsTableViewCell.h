//
//  SearchGoodsTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/8.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface SearchGoodsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *searchImgae;

//@property (strong, nonatomic) IBOutlet UILabel *searchDiscount;

@property (strong, nonatomic) IBOutlet UILabel *searchName;

@property (strong, nonatomic) IBOutlet UILabel *searchDesc;


@property (strong, nonatomic) IBOutlet MyButton *searchGoodsBtn;







@end
