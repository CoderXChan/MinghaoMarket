//
//  MyStoreFeed.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStoreFeed : NSObject

- (instancetype)initWithName:(NSString *) name note:(NSString *) note imageURL:(NSString *) imageURL homeURL:(NSString *) homeURL pageURL:(NSString *) pageURL;


@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *note;
@property (copy,nonatomic) NSString *imageURL;
@property (copy,nonatomic) NSString *homeURL;
@property (copy,nonatomic) NSString *pageURL;


@end
