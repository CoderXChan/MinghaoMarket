//
//  MyReleaseViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/30.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodFoods.h"
@interface MyReleaseViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *msgName;


@property (strong, nonatomic) IBOutlet UITextView *msgDesc;


@property (strong, nonatomic) IBOutlet UITextField *msgPrice;


@property (copy,nonatomic) NSString *theStoreImageName;


@property(retain,nonatomic)GoodFoods *goodFoods;



//商品详情图片
@property (copy,nonatomic) NSString *theReleaseImageName1;
@property (copy,nonatomic) NSString *theReleaseImageName2;
@property (copy,nonatomic) NSString *theReleaseImageName3;
@property (copy,nonatomic) NSString *theReleaseImageName4;
@property (copy,nonatomic) NSString *theReleaseImageName5;


@end
