//
//  MMHeaderRefresh.m
//  CatRefresh
//
//  Created by yumingming on 16/2/17.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "MMHeaderRefresh.h"

const CGFloat refreshHeaderHeight = 75;

@implementation MMHeaderRefresh
+(instancetype)header{
    return [[MMHeaderRefresh alloc]init];
}

//构造方法
-(instancetype)init{

    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];

        self.catRefreshBackgroundView = [[UIView alloc ] init];
        [self.catRefreshBackgroundView setBackgroundColor:[UIColor clearColor]];
        [self.catRefreshBackgroundView addSubview:self];

        self.circleView = [[MMCircleView alloc ] init];
        [self addSubview:self.circleView];

        self.catImageView = [[UIImageView alloc ] init];
        self.catImageView.backgroundColor = [UIColor clearColor];
        self.catImageView.image = [UIImage imageNamed:@"cat"];
        [self addSubview:self.catImageView];

        // 6.设置默认状态
        [self setState:mmRefreshStateNormal];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 缓存位置偏移
    self.scrollViewInitInset = self.tableView.contentInset;

    self.catRefreshBackgroundView.frame = CGRectMake(0, self.tableView.contentInset.top , self.tableView.frame.size.width, self.tableView.frame.size.height);

    self.frame = CGRectMake(0, self.tableView.contentInset.top, self.tableView.frame.size.width, 100);

    self.catImageView.frame  = CGRectMake((self.frame.size.width - 30)*0.5 , 20, 30, 30);

    // 圆圈比图片的放大尺寸
    CGFloat sale = 5;
    self.circleView.frame = CGRectMake(self.catImageView.frame.origin.x - sale, self.catImageView.frame.origin.y - sale,self.catImageView.frame.size.width + sale*2, self.catImageView.frame.size.height + sale*2);

    self.tableView.backgroundView = self.catRefreshBackgroundView;


}


- (void)setTableView:(UITableView *)tableView{
    // 监听contentOffset
    [tableView addObserver:self
                forKeyPath:@"contentOffset"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
    _tableView = tableView;
    tableView.backgroundView = self.catRefreshBackgroundView;
}


#pragma mark 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    CGFloat offsetY = -self.tableView.contentOffset.y - self.tableView.contentInset.top;

    if (offsetY<=0) return;
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
        || _state == mmRefreshStateRefreshing)

        return;

    if (_tableView.isDragging) {

        // 画线
        if (offsetY >= self.catImageView.frame.origin.y) {
            self.circleView.progress = (offsetY - self.catImageView.frame.origin.y) / (refreshHeaderHeight - self.catImageView.frame.origin.y);
            [self.circleView setNeedsDisplay];
        }

        if (_state == mmRefreshStatePulling && offsetY <= refreshHeaderHeight) {

            // 转为普通状态
            [self setState:mmRefreshStateNormal];
        }

        // 大于刷新高度 转为即将刷新状态
        else if (_state == mmRefreshStateNormal && offsetY > refreshHeaderHeight) {

            // 转为即将刷新状态
            [self setState:mmRefreshStatePulling];
        }
    } else {

        // 即将刷新 && 手松开
        if (_state == mmRefreshStatePulling) {

            // 开始刷新
            [self setState:mmRefreshStateRefreshing];
        }
    }
}

#pragma mark 结束刷新
- (void)endRefreshing{
    self.circleView.progress = 0;
    [self.circleView setNeedsDisplay];
    [self setState:mmRefreshStateNormal];
}

-(void)setState:(mmRefreshState)state{

    if (_state == state) return;
    switch (state) {

        case mmRefreshStatePulling:// 刷新中
        {
            break;
        }
        case mmRefreshStateNormal:// 恢复普通状态
        {
            _tableView.userInteractionEnabled = YES;
            [self.circleView.layer removeAnimationForKey:@"rotateAnimation"];

            // 执行动画
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets inset = _tableView.contentInset;
                inset.top = _scrollViewInitInset.top;
                _tableView.contentInset = inset;
            }];

            break;
        }

        case mmRefreshStateRefreshing:  // 正在刷新中
        {

            _tableView.userInteractionEnabled = NO;
            // 执行动画
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets inset = _tableView.contentInset;
                inset.top = _scrollViewInitInset.top + refreshHeaderHeight;
                _tableView.contentInset = inset;
                _tableView.contentOffset = CGPointMake(0, - _scrollViewInitInset.top - refreshHeaderHeight);
            }];

            [self rotateAnimation];

            // 回调
            if (_beginRefreshingBlock) {
                _beginRefreshingBlock(self);
            }
            break;
        }

        default:
            break;
    }
    _state = state;
}


-(void)rotateAnimation{
    CABasicAnimation* rotate =  [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    [rotate setToValue: [NSNumber numberWithFloat: M_PI * 2.0]];
    rotate.repeatCount = 111;
    rotate.duration = 1;
    rotate.cumulative = true;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.circleView.layer addAnimation:rotate forKey:@"rotateAnimation"];
}




-(void)free{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}



@end
