//
//  SearchGoodsTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/8.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchGoodsTableViewController : UITableViewController
@property(retain,nonatomic)NSMutableArray *searchGoodsArray;


@property(retain,nonatomic)NSMutableArray *searchShopsArray;



+(void)setTempInt:(int)num;
+(int)getTempInt;
@end
