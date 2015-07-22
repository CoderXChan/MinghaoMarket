//
//  MyStoreViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/20.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Store.h"
@interface MyStoreViewController : UIViewController

@property(retain,nonatomic)Store *store;


@property(retain,nonatomic)NSMutableArray *myStoreMsg;

@end
