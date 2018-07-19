//
//  ViewController.m
//  MMRefresh
//
//  Created by yumingming on 16/2/15.
//  Copyright © 2016年 MM. All rights reserved.
//

#import "ViewController.h"
#import "SDTableViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    SDTableViewController *SD = [[SDTableViewController alloc]init];
    [self.view addSubview:SD.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
