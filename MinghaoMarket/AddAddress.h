//
//  AddAddress.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddAddress : NSObject
@property(copy,nonatomic)NSString *addressId;
@property(copy,nonatomic)NSString *province;
@property(copy,nonatomic)NSString *city;
@property(copy,nonatomic)NSString *county;
@property(copy,nonatomic)NSString *addressinfo;
@property(copy,nonatomic)NSString *receive;
@property(copy,nonatomic)NSString *receivephone;

@end
