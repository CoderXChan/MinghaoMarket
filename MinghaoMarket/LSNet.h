//
//  LSNet.h
//  test
//
//  Created by huj on 15-3-13.
//  Copyright (c) 2015年 huj. All rights reserved.
//



#pragma mark - 上传图片的类


#import <Foundation/Foundation.h>

@interface LSNet : NSObject{
    NSString * URL;
    NSString * Boundary;
    NSString * currentDate;
    NSString * currentUserID;
    
}

-(id) initWithURL:(NSString *)mURL;
-(BOOL) Post:(NSDictionary *)params withImage:(UIImage *)img;
@property(retain,nonatomic)NSMutableArray *userMsg;

@property (copy,nonatomic) NSString *imageName;

@end
