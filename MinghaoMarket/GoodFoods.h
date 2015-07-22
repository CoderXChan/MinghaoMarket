//
//  GoodFoods.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/6.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
@interface GoodFoods : NSObject{
    NSString *typeId;
    NSString *type;//0为信息   1为美食

}


@property(nonatomic,retain)NSString *foodsDescName;
@property(nonatomic,retain)NSString *foodsDescDesc;
@property(copy,nonatomic)NSString *foodsDescId;
@property(copy,nonatomic)NSString *foodsDescMoney;

//差滑动图和详情图片
@property (strong,nonatomic) NSMutableArray *thumbPictures;




//差滑动图和详情图片
@property (strong,nonatomic) NSMutableArray *thumbPictures2;




@property(nonatomic,retain)NSString *typeId;

@property(nonatomic,retain)NSString *type;
@end
