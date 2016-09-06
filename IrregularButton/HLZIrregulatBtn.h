//
//  HLZIrregulatBtn.h
//  IrregularButton
//
//  Created by chuang Hao on 16/9/6.
//  Copyright © 2016年 chuang Hao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^chooseBlock)(UIButton *button);

@interface HLZIrregulatBtn : UIView

@property (nonatomic, strong) UIColor  *btnBgColor;
@property (nonatomic, assign) CGSize   heightSize;
@property (nonatomic, strong) UIView   *ltView;
@property (nonatomic, strong) NSArray  *arrDataSourse;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSMutableArray *buttonArray;//存放button，实现按钮单选
@property (nonatomic, copy) chooseBlock block;

- (void) setChooseBlock:(chooseBlock)block;
- (void) setLabelBackgroundColor:(UIColor *)color;
- (void) getArrayDataSourse:(NSArray *)array;
- (CGSize) returnSize;

@end
