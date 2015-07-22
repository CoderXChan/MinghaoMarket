//
//  MessageDescViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/7/1.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
#import "GoodFoods.h"
@interface MessageDescViewController : UIViewController

@property(retain,nonatomic)NSMutableArray *messageDescArray;


@property(retain,nonatomic)Goods *goods;


@property(retain,nonatomic)GoodFoods *goodFoods;

@end
