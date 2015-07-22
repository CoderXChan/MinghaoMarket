//
//  PageIndicator.h
//  MySinaNews
//
//  Created by Andy Tung on 15-1-21.
//  Copyright (c) 2015年 Andy Tung (tanghuacheng.cn). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageIndicator : UIView

@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;
@property(nonatomic) CGSize sizeOfIndicator;//大小
@property(nonatomic) CGFloat space;//间隔距离
@property (strong,nonatomic) UIImage *pageImage;
@property (strong,nonatomic) UIImage *currentPageImage;

@end
