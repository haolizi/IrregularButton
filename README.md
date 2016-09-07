# IrregularButton

不规则按钮自动换行及单选功能的简单实现

## Usage

```objective-c
//初始化
HLZIrregulatBtn *irregulatBtn = [[HLZIrregulatBtn alloc]initWithFrame:CGRectMake(15, 150, self.view.frame.size.width - 30, self.view.frame.size.height)];
[self.view addSubview:irregulatBtn];

//数据源
NSArray *listArray = @[@"张三",
                       @"李四",
                       @"隔壁老王",
                       @"麻声稀饭",
                       @"啪啪",
                       @"irregularButton",
                       @"newline",
                       @"over"];
[irregulatBtn getArrayDataSourse:listArray];

//点击事件回调
[irregulatBtn setChooseBlock:^(UIButton *button) {
    NSLog(@"index:%ld    indexName:%@",(long)button.tag,listArray[button.tag]);
}];

//重置frame
CGSize size = [irregulatBtn returnSize];
irregulatBtn.frame = CGRectMake(15, 150, self.view.frame.size.width - 30, size.height);
NSLog(@"%f",size.height);
```

效果图：
![image](https://github.com/haolizi/IrregularButton/blob/master/example.png)

