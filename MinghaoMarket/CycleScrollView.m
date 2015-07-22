//
//  CycleScrollView.m
//  CycleScroll
//
//  Created by Andy Tung on 15-1-23.
//  Copyright (c) 2015年 Andy Tung (tanghuacheng.cn). All rights reserved.
//

#import "CycleScrollView.h"

@interface CycleScrollView ()<UIScrollViewDelegate>{
    NSInteger _numberOfPages;
    UIScrollView *_innerScrollView;
    UIView *_prevView;
    UIView *_nextView;
    CGPoint _contentOffset;
    NSInteger _currentPage;
}

- (void) initialize;

- (void) setContentOffset:(CGPoint)contentOffset;

@end

@implementation CycleScrollView



- (instancetype)init{
    if (self=[super init]) {
        [self initialize];
    }
    return self;
}

// 故事版
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _innerScrollView = [[UIScrollView alloc] init];
    _innerScrollView.showsHorizontalScrollIndicator = NO;
    _innerScrollView.showsVerticalScrollIndicator = NO;
    _innerScrollView.directionalLockEnabled=YES;
    _innerScrollView.pagingEnabled=YES;
    _innerScrollView.delegate = self;
    [self addSubview:_innerScrollView];
}

- (void)reload{
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _numberOfPages = [self.delegate numberOfPages:self];
    if (_numberOfPages>0) {
        CGRect rect=self.bounds;
        CGSize size = rect.size;
        _contentOffset = CGPointZero;
        _innerScrollView.frame=rect;
        _innerScrollView.contentSize=size;
        _innerScrollView.contentOffset=CGPointZero;
        // Add prev view
        _prevView = [self.delegate cycleScrollView:self viewForPage:0 reusingView:_prevView];
        if (_prevView.superview==nil) {
            [_innerScrollView addSubview:_prevView];
        }
        //
        if (_numberOfPages==1) {
            // Set prev view frame
            _prevView.frame = rect;
            // Remove next view
            if (_nextView != nil) {
                [_nextView removeFromSuperview];
            }
        }
        // Add next view
        else{
            // Set content size and offset
            NSInteger pageOffset = _numberOfPages*10000;
            _innerScrollView.contentSize=CGSizeMake(size.width*pageOffset*2, size.height);
            _innerScrollView.contentOffset = CGPointMake(size.width*pageOffset,0);
            _contentOffset = _innerScrollView.contentOffset;
            // Change prev view frame
            rect.origin.x = _contentOffset.x;
            _prevView.frame=rect;
            // Add next view
            _nextView = [self.delegate cycleScrollView:self viewForPage:1 reusingView:_nextView];
            if (_nextView.superview==nil) {
                [_innerScrollView addSubview:_nextView];
            }
            rect.origin.x=_contentOffset.x+size.width;
            _nextView.frame=rect;
        }
    }
}

- (void)setContentOffset:(CGPoint)contentOffset{
    if (contentOffset.x!=_contentOffset.x) {
        CGSize size = _innerScrollView.bounds.size;
        CGRect rPrev=_prevView.frame;
        CGRect rNext=_nextView.frame;
        CGRect rUnion=CGRectUnion(rPrev, rNext);
        CGRect rPort=CGRectMake(contentOffset.x, contentOffset.y, size.width, size.height);
        
        if (!CGRectContainsRect(rUnion, rPort)) {
            NSInteger page;
            if (contentOffset.x>_contentOffset.x) {
                page=(NSInteger)((contentOffset.x+size.width)/size.width);
            }else{
                page=(NSInteger)(contentOffset.x/size.width);
            }
            
            if (CGRectIntersectsRect(rPort, rPrev)) {
                _nextView = [self.delegate cycleScrollView:self viewForPage:page%_numberOfPages reusingView:_nextView];
                rNext.origin.x = page*size.width;
                _nextView.frame = rNext;
            }else{
                _prevView = [self.delegate cycleScrollView:self viewForPage:page%_numberOfPages reusingView:_prevView];
                rPrev.origin.x = page*size.width;
                _prevView.frame=rPrev;
            }
        }
        _contentOffset=contentOffset;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setContentOffset:scrollView.contentOffset];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSInteger page = (NSInteger)(targetContentOffset->x/scrollView.bounds.size.width);
    page=page%_numberOfPages;
    if (_currentPage!=page) {
        _currentPage=page;
        if ([self.delegate respondsToSelector:@selector(cycleScrollView:scrollToPage:)]) {
            [self.delegate cycleScrollView:self scrollToPage:page];
        }
    }
}

@end
