//
//  MyStoreFeed.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MyStoreFeed.h"

@implementation MyStoreFeed

- (instancetype)initWithName:(NSString *)name note:(NSString *)note imageURL:(NSString *)imageURL homeURL:(NSString *)homeURL pageURL:(NSString *)pageURL{
    if (self=[super init]) {
        self.name=name;
        self.note=note;
        self.imageURL=imageURL;
        self.homeURL=homeURL;
        self.pageURL=pageURL;
        
    }
    return self;
}


@end
