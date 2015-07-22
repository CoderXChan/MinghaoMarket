//
//  PageIndicator.m
//  MySinaNews
//
//  Created by Andy Tung on 15-1-21.
//  Copyright (c) 2015年 Andy Tung (tanghuacheng.cn). All rights reserved.
//

#import "PageIndicator.h"

@interface PageIndicator ()

@end

@implementation PageIndicator


//动态改变页面指示器的约束宽值
- (void)updateConstraints{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            if (_numberOfPages>0) {
                constraint.constant = _numberOfPages*(_sizeOfIndicator.width+_space)-_space;
            }else{
                constraint.constant=0;
            }            
        }
    }
    [super updateConstraints];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    self.hidden = _numberOfPages==0;
    [self updateConstraints];    
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage=currentPage;
    [self setNeedsDisplay];//立马重新绘制
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    UIImage *img;
    for (int i=0; i<self.numberOfPages; i++) {
        if (i==self.currentPage) {
            img=self.currentPageImage;
        }else{
            img=self.pageImage;
        }
        [img drawInRect:CGRectMake(i*(_sizeOfIndicator.width+_space),0, _sizeOfIndicator.width, _sizeOfIndicator.height)];
    }
}


@end
