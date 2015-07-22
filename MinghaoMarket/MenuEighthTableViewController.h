//
//  MenuEighthTableViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/17.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"


@interface MenuEighthTableViewController : UITableViewController<SlideNavigationControllerDelegate,UIWebViewDelegate>

/**  预支付订单数         */
@property (assign,nonatomic) NSInteger *willPayCount;



@end
