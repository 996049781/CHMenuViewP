//
//  ViewController.m
//  CHMenu
//
//  Created by chenghao on 2017/3/1.
//  Copyright © 2017年 clearcdm.com. All rights reserved.
//

#import "ViewController.h"
#import "CHMenuView.h"
@interface ViewController (){
    UITableView* _knowledge;
    UITableView* _information;
    UITableView* _policy;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    _knowledge = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

    
    _information = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

    
    _policy = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

    
    CHMenuView* menuView = [[CHMenuView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) titles:@[@"第一",@"第二",@"第三"] andViews:@[_knowledge,_information,_policy] andTitleColor:[UIColor redColor]];
    [self.view addSubview:menuView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
