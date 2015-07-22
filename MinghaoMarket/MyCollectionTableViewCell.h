//
//  MyCollectionTableViewCell.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyButton.h"
@interface MyCollectionTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *collectionImages;

@property (strong, nonatomic) IBOutlet UILabel *collectionName;


@property (strong, nonatomic) IBOutlet UILabel *collectionDesc;
@property (strong, nonatomic) IBOutlet UILabel *collectionPrice;


@property (strong, nonatomic) IBOutlet MyButton *collectionDeleteBtn;



@property (strong, nonatomic) IBOutlet MyButton *collectionBtn;



@end
