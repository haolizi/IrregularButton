//
//  ViewController.m
//  IrregularButton
//
//  Created by chuang Hao on 16/9/6.
//  Copyright © 2016年 chuang Hao. All rights reserved.
//
//功能:不规则按钮自动换行、单选
#import "ViewController.h"
#import "HLZIrregulatBtn.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HLZIrregulatBtn *irregulatBtn = [[HLZIrregulatBtn alloc]initWithFrame:CGRectMake(15, 150, self.view.frame.size.width - 30, self.view.frame.size.height)];
    [self.view addSubview:irregulatBtn];
    
    //数据源
    NSArray *listArray = @[@"张三",@"李四",@"隔壁老王",@"麻声稀饭",@"啪啪",@"irregularButton",@"newline",@"over"];
    [irregulatBtn getArrayDataSourse:listArray];
    
    //回调
    [irregulatBtn setChooseBlock:^(UIButton *button) {
        NSLog(@"index:%ld    indexName:%@",(long)button.tag,listArray[button.tag]);
    }];
    
    //重置frame
    CGSize size = [irregulatBtn returnSize];
    irregulatBtn.frame = CGRectMake(15, 150, self.view.frame.size.width - 30, size.height);
    NSLog(@"%f",size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
