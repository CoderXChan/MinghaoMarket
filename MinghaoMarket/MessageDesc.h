//
//  MessageDesc.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/7/1.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@interface MessageDesc : NSObject
@property(nonatomic,retain)NSString *messageDescName;
@property(nonatomic,retain)NSString *messageDescDesc;
@property(copy,nonatomic)NSString *messageDescType;
@property(copy,nonatomic)NSString *messageDescMoney;
@property(copy,nonatomic)NSString *messageDescTime;
@property (strong,nonatomic) Picture *messageDescImage;
@end
