//
//  GoodsType.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/24.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@interface GoodsType : NSObject

@property(nonatomic,retain)NSString *productTypeId;
@property(nonatomic,retain)NSString *productTypeName;
@property (strong,nonatomic) Picture *productTypeImage;

@end
