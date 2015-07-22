//
//  MenuThirdTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface MenuThirdTableViewController : UITableViewController<SlideNavigationControllerDelegate>


@property(retain,nonatomic)NSMutableArray *menuBeautyGoods;


@property(retain,nonatomic)NSMutableArray *menuBeautyImage;
@end
