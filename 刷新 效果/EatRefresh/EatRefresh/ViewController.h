//
//  ViewController.h
//  EatRefresh
//
//  Created by yumingming on 16/2/22.
//  Copyright © 2016年 MM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyRefreshControl;

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) MyRefreshControl *refreshControl;

@end

