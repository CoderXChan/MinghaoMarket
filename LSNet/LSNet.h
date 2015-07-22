//
//  LSNet.h
//  test
//
//  Created by huj on 15-3-13.
//  Copyright (c) 2015年 huj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSNet : NSObject{
    NSString * URL;
    NSString * Boundary;
}

-(id) initWithURL:(NSString *)mURL;
-(BOOL) Post:(NSDictionary *)params withImage:(UIImage *)img;


@end
