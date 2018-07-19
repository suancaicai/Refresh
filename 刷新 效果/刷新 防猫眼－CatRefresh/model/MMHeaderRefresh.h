//
//  MMHeaderRefresh.h
//  CatRefresh
//
//  Created by yumingming on 16/2/17.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCircleView.h"

//刷新状态
typedef enum{
    mmRefreshStateNormal         = 1,  //普通状态
    mmRefreshStatePulling        = 2,  //松开就可以刷新的状态
    mmRefreshStateRefreshing     = 3,  // 正在刷新的状态
    mmRefreshStateWillRefreshing = 4
}mmRefreshState;



@class MMHeaderRefresh;
// 开始进入刷新状态就会调用
typedef void (^BeginRefreshingBlock)(MMHeaderRefresh *refreshView);



@interface MMHeaderRefresh : UIView

@property (nonatomic, assign) UIEdgeInsets scrollViewInitInset;
@property (nonatomic, strong) UIImageView *catImageView;
@property (nonatomic, weak)   UITableView *tableView;
@property (nonatomic, strong) UIView  *catRefreshBackgroundView;
@property (nonatomic, assign) mmRefreshState state;
@property (nonatomic, strong) MMCircleView *circleView;

@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;

+(instancetype)header;
-(void)endRefreshing;
-(void)free;

@end
