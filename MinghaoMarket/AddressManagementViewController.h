//
//  AddressManagementViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/24.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@protocol AddressManagementVCDelegate <NSObject>

- (void)AddressManagementVCWithAddressMessage:(NSString *)addressMessage;

@end

@interface AddressManagementViewController : UIViewController

@property (assign,nonatomic) id<AddressManagementVCDelegate> delegate;
@property(copy,nonatomic)NSMutableArray *addressMsg;
@property (copy,nonatomic) NSString *addressMessage;
@end
