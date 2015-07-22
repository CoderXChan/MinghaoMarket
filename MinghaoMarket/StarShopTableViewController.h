//
//  StarShopTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Feed;
@interface StarShopTableViewController : UITableViewController
@property (strong,nonatomic)Feed *feed;
@property(nonatomic)NSInteger pageSize;
//@property (copy,nonatomic) NSString *idNo;
-(void)updateDoing;


@property(retain,nonatomic)NSMutableArray *homePageImage;
@end
