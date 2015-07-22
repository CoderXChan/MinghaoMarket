//
//  UserLoginViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/17.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *userId;


@property (strong, nonatomic) IBOutlet UITextField *userPwd;



@property(retain,nonatomic)NSMutableArray *userMsg;

@end
