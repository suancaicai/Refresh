//
//  SDRefreshFooterView.m
//  SDRefreshView
//
//  Created by aier on 15-2-23.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDRefreshFooterView.h"
#import "UIView+SDExtension.h"

@implementation SDRefreshFooterView
{
    CGFloat _originalScrollViewContentHeight;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textForNormalState = @"上拉可以加载最新数据";
        self.stateIndicatorViewNormalTransformAngle = M_PI;
        self.stateIndicatorViewWillRefreshStateTransformAngle = 0;
        [self setRefreshState:SDRefreshViewStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.activityIndicatorView.hidden = YES;
    _originalScrollViewContentHeight = self.scrollView.contentSize.height;
    self.scrollViewEdgeInsets = UIEdgeInsetsMake(0, 0, self.sd_height, 0);
    self.center = CGPointMake(self.scrollView.sd_width * 0.5, self.scrollView.contentSize.height + self.sd_height * 0.5 + self.scrollView.contentInset.bottom);
    
    self.hidden = [self shouldHide];
}

- (BOOL)shouldHide
{
    if (self.isEffectedByNavigationController) {
        return (self.scrollView.bounds.size.height - SDKNavigationBarHeight + self.scrollView.contentInset.bottom > self.sd_y);
    }
    return (self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom > self.sd_y);
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:SDRefreshViewObservingkeyPath]) return;
    
    CGFloat y = [change[@"new"] CGPointValue].y;
    
    // 只有在 y>0 以及 scrollview的高度不为0 时才判断
    if ((y <= 0) || (self.scrollView.bounds.size.height == 0)) return;

    // 触发SDRefreshViewStateRefreshing状态
    if (y < (self.scrollView.contentSize.height - self.scrollView.sd_height + self.sd_height + self.scrollView.contentInset.bottom) && (self.refreshState == SDRefreshViewStateWillRefresh)) {
        [self setRefreshState:SDRefreshViewStateRefreshing];
    }
    
    // 触发SDRefreshViewStateWillRefresh状态
    if (y > (self.scrollView.contentSize.height - self.scrollView.sd_height + self.sd_height + self.scrollView.contentInset.bottom) && (SDRefreshViewStateNormal == self.refreshState)) {
        if (self.hidden) return;
        [self setRefreshState:SDRefreshViewStateWillRefresh];
    }
    
    // 如果scrollView内容有增减，重新调整refreshFooter位置
    if (self.scrollView.contentSize.height != _originalScrollViewContentHeight) {
        [self layoutSubviews];
    }
}


@end
