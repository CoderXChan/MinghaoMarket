//
//  User.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "User.h"
static NSMutableArray *allUsers;
static User *currUser;
static NSString *uName;
static NSString *uID;
static NSString *userShop;
static NSString *userPoint;
static NSString *userVip;
@implementation User
@synthesize userId,userPhoneNumber,userName,userPassWord,userEmail,userShopYesOrNo,userPoints,userVip;

-(id)initWithUserId:(NSString *)uId withPhoneNumber:(NSString *)upNum withName:(NSString *)uName withPwd:(NSString *)uPwd withEmail:(NSString *)uEmail withPoints:(NSString *)uPoints withUserVip:(NSString *)uVip{
    self=[super init];
    if (self) {
        self.userId=uId;
        self.userPhoneNumber=upNum;
        self.userName=uName;
        self.userPassWord=uPwd;
        self.userEmail=uEmail;
        self.userPoints=uPoints;
        self.userVip=uVip;
    }
    return self;

}


//设置当前用户
+(void)setCurrentUser:(User *)cUser{
    currUser=cUser;

}

//获取当前用户
+(User *)getCurrentUser{
    return currUser;
}



+(void)setName:(NSString *)name{
    uName=name;

}

+(NSString *)getName{
    return uName;
}


+(void)setUserid:(NSString *)uid{
    uID=uid;
    
}

+(NSString *)getUserID{
    return uID;
}



+(void)setUserShop:(NSString *)uShop{
    userShop=uShop;
}
+(NSString *)getUserShop{
    return userShop;

}


//获取用户积分
+(void)setUserPoints:(NSString *)point{
    userPoint=point;

}
+(NSString *)getUserPoint{
    return userPoint;
}




//获取是否是vip
+(void)setUserVip:(NSString *)uvip{
    userVip=uvip;
}
+(NSString *)getUserVip{
    return userVip;
}

@end
