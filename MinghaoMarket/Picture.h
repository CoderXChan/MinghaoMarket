//
//  Picture.h
//  SinaNewsApp1.1
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject
-(instancetype)initWithURL:(NSString *)pURL;
@property(copy,nonatomic)NSString *pictureURL;
@property(strong,atomic)NSData *pictureData;//延迟加载  图片数据
@end
