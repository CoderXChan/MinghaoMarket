//
//  User.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(copy,nonatomic)NSString *userId;
@property(copy,nonatomic)NSString *userPhoneNumber;
@property(copy,nonatomic)NSString *userName;
@property(copy,nonatomic)NSString *userPassWord;
@property(copy,nonatomic)NSString *userEmail;
@property(copy,nonatomic)NSString *userShopYesOrNo;
@property(copy,nonatomic)NSString *userPoints;
@property(copy,nonatomic)NSString *userVip;


-(id)initWithUserId:(NSString *)uId withPhoneNumber:(NSString *)upNum withName:(NSString *)uName withPwd:(NSString *)uPwd withEmail:(NSString *)uEmail withPoints:(NSString *)uPoints withUserVip:(NSString *)uVip;



//设置当前用户
+(void)setCurrentUser:(User *)cUser;

//获取当前用户
+(User *)getCurrentUser;


+(void)setName:(NSString *)name;

+(NSString *)getName;

+(void)setUserid:(NSString *)uid;
+(NSString *)getUserID;


//获取用户是否开店
+(void)setUserShop:(NSString *)uShop;
+(NSString *)getUserShop;


//获取用户积分
+(void)setUserPoints:(NSString *)point;
+(NSString *)getUserPoint;



//获取是否是vip
+(void)setUserVip:(NSString *)uvip;
+(NSString *)getUserVip;


@end
