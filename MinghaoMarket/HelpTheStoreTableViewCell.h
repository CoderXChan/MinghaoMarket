//
//  HelpTheStoreTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/10.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface HelpTheStoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *htsGoodsNum;

@property (weak, nonatomic) IBOutlet UILabel *htsSaleNum;

@property (weak, nonatomic) IBOutlet UILabel *htsScore;


@property (weak, nonatomic) IBOutlet UILabel *htsFansNum;

@property (weak, nonatomic) IBOutlet UILabel *htsShopName;

@property (weak, nonatomic) IBOutlet UIImageView *htsGoodsImage;

@property (weak, nonatomic) IBOutlet UIImageView *htsShopImage;


@property (strong, nonatomic) IBOutlet MyButton *helpShopBtn;




@end
