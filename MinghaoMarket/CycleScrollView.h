//
//  CycleScrollView.h
//  CycleScroll
//
//  Created by Andy Tung on 15-1-23.
//  Copyright (c) 2015年 Andy Tung (tanghuacheng.cn). All rights reserved.
//

#import <UIKit/UIKit.h>

@class CycleScrollView;

@protocol CycleScrollViewDelegate <NSObject>
@required
- (NSInteger) numberOfPages:(CycleScrollView *) cycleScrollView;//多少页
- (UIView *) cycleScrollView:(CycleScrollView *) cycleScrollView viewForPage:(NSInteger)page reusingView:(UIView *) view;
@optional
- (void) cycleScrollView:(CycleScrollView *) cycleScrollView scrollToPage:(NSInteger) page;//改下标和标题

@end

@interface CycleScrollView : UIView

@property (weak,nonatomic) IBOutlet id<CycleScrollViewDelegate> delegate;

- (void) reload;

@end
