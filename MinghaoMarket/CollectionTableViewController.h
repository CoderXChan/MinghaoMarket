//
//  CollectionTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface CollectionTableViewController : UITableViewController<SlideNavigationControllerDelegate>

@property(retain,nonatomic)NSMutableArray *currentUserAllCollectionGoods;

@end
