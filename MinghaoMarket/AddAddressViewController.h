//
//  AddAddressViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/24.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@protocol AddAddressDelegate <NSObject>

- (void)addAddressWithAddressLabel:(NSString *)addressText;

@end
@interface AddAddressViewController : UIViewController//<PassValueDelegate>

@property (assign,nonatomic) id<AddAddressDelegate> delegate;
@property(retain,nonatomic)NSMutableArray *addressMsg;
//  承接地址的字符串
@property (copy,nonatomic) NSString *addressText;
@property (strong, nonatomic) IBOutlet UILabel *theGoodAddress;

@end