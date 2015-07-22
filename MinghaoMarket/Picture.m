//
//  Picture.m
//  SinaNewsApp1.1
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Picture.h"

@implementation Picture
-(instancetype)initWithURL:(NSString *)pURL{
    if (self=[super init]) {
        self.pictureURL=pURL;
    }
    return self;
}
@end
