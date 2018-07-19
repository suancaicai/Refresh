//
//  ViewController.m
//  CatRefresh
//
//  Created by yumingming on 16/2/17.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "ViewController.h"
#import "MMHeaderRefresh.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *array;

}
@property (nonatomic ,strong)MMHeaderRefresh *refresh;
@property (nonatomic ,strong)UITableView *mainTable;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

      [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:210.0/255.0 green:38.0/255.0 blue:44.0/255.0 alpha:1]];

    [self addTableView];

    // Do any additional setup after loading the view, typically from a nib.
    self.refresh = [MMHeaderRefresh header];
    self.refresh.tableView = self.mainTable;
    typeof(self) __weak weakSelf = self;
    self.refresh.beginRefreshingBlock = ^(MMHeaderRefresh *refreshView){
        [weakSelf dd];
    };



}

-(void)dd{

    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.refresh endRefreshing];
    });
}




-(void)addTableView{
    array = @[@"fdvkfjf",@"fvadfvfa",@"avadfvv",@"fdvkfbj",@"fvadbtfva",@"avadfv",@"fdvkfj",@"fvadfva",@"avadfv"];

    CGRect frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60);
    self.mainTable = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    [self.view addSubview:self.mainTable];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text =  array[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
