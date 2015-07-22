//
//  LeftMenuViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL slideOutAnimationEnabled;



@end
