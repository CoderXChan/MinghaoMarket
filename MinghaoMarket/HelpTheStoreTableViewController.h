//
//  HelpTheStoreTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/10.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Feed;
@interface HelpTheStoreTableViewController : UITableViewController
@property (strong,nonatomic)Feed *feed;
@property(nonatomic)NSInteger pageSize;
-(void)updateDoing;

@property(retain,nonatomic)NSMutableArray *homePageImage;
@end
