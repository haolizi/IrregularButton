//
//  HLZIrregulatBtn.m
//  IrregularButton
//
//  Created by chuang Hao on 16/9/6.
//  Copyright © 2016年 chuang Hao. All rights reserved.
//

#import "HLZIrregulatBtn.h"
#import <QuartzCore/QuartzCore.h>

//圆角弧度
#define CORNER_RADIUS 2.0f
//两个按钮左右之间的间隙
#define HLZ_BUTTON_PADDING 10.0f
//两个按钮上下之间的间隙
#define HLZ_BUTTON_PADDING_UP 10.0f
//字体大小
#define HLZ_FONT_SIZE 14.0f
//左右内边距
#define HLZ_HORIZONTAL_PADDING 18.0f
//上下内边距
#define HLZ_VERTICAL_PADDING 6.0f
//背景颜色
#define HLZ_BG_COLOR [UIColor whiteColor]
//字体颜色
#define HLZ_TEXTCOLOR [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0]
//字体选中颜色
#define HLZ_SELECT_TEXTCOLOR [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
//边框颜色
#define HLZ_BOARD_COLOR   [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0].CGColor //边框颜色
//边框宽
#define HLZ_BORDER_WIDTH 1.0f
//button高
#define HLZ_BUTTON_HEIGHT 34

@implementation HLZIrregulatBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonArray = [NSMutableArray array];
        [self addSubview:self.ltView];
    }
    return self;
}

- (void)getArrayDataSourse:(NSArray *)array
{
    self.arrDataSourse = [[NSArray alloc] initWithArray:array];
    self.heightSize = CGSizeZero;
    [self showBtn];
}

- (void)setLabelBackgroundColor:(UIColor *)color
{
    self.btnBgColor = color;
    [self showBtn];
}

- (void)showBtn
{
    for (UIButton *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    CGRect previousFrame = CGRectZero;
    float  totalHeight = 0;
    BOOL   gotPreviousFrame = NO;
    int    buttonTag = 0;
    
    for (NSString *singleText in self.arrDataSourse) {
        CGRect textSize  = [self sizeWithFont:singleText];
        textSize.size.width += HLZ_HORIZONTAL_PADDING*2;
        textSize.size.height += HLZ_VERTICAL_PADDING*2;
        UIButton *irregulatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!gotPreviousFrame) {
            irregulatBtn.frame = CGRectMake(0, 0, textSize.size.width, textSize.size.height);
            totalHeight = textSize.size.height;
        }
        else {
            CGRect newRect = CGRectZero;
            if (previousFrame.origin.x + previousFrame.size.width + textSize.size.width + HLZ_BUTTON_PADDING > self.frame.size.width) {
                newRect.origin = CGPointMake(0, previousFrame.origin.y + textSize.size.height + HLZ_BUTTON_PADDING_UP);
                totalHeight += textSize.size.height + HLZ_BUTTON_PADDING_UP;
            }
            else {
                newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + HLZ_BUTTON_PADDING, previousFrame.origin.y);
            }
            newRect.size = textSize.size;
            irregulatBtn.frame = newRect;
        }
        previousFrame = irregulatBtn.frame;
        gotPreviousFrame = YES;
        
        [irregulatBtn.titleLabel setFont:[UIFont systemFontOfSize:HLZ_FONT_SIZE]];
        
        if (!self.btnBgColor) {
            [irregulatBtn setBackgroundColor:HLZ_BG_COLOR];
        }
        else {
            [irregulatBtn setBackgroundColor:self.btnBgColor];
        }
        
        [irregulatBtn setTitleColor:HLZ_TEXTCOLOR forState:UIControlStateNormal];
        [irregulatBtn setTitle:singleText forState:UIControlStateNormal];
        [irregulatBtn.layer setMasksToBounds:YES];
        [irregulatBtn.layer setCornerRadius:CORNER_RADIUS];
        [irregulatBtn.layer setBorderColor:HLZ_BOARD_COLOR];
        [irregulatBtn.layer setBorderWidth:HLZ_BORDER_WIDTH];
        irregulatBtn.titleLabel.font = [UIFont systemFontOfSize:HLZ_FONT_SIZE];
        
        [irregulatBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:irregulatBtn];
        [self addSubview:irregulatBtn];
        irregulatBtn.tag = buttonTag;
        buttonTag += 1;
    }
    self.heightSize = CGSizeMake(self.frame.size.width, totalHeight + 1.0f);
}

#pragma mark - 传递点击事件
- (void) click:(UIButton *)button{
    button.selected = !button.selected;
    //单选
    for (int i = 0; i < self.buttonArray.count; i ++) {
        UIButton *button1 = self.buttonArray[i];
        if (button.tag == i) {
            button.selected = button1.selected;
        }
        else{
            button1.selected = NO;
        }
        button1.backgroundColor = [UIColor whiteColor];
        [button1 setTitleColor:HLZ_TEXTCOLOR forState:UIControlStateNormal];
    }
    UIButton *button2 = self.buttonArray[button.tag];
    //选中按钮
    if (button2.selected) {
        [button2 setBackgroundColor:HLZ_TEXTCOLOR];
        [button2 setTitleColor:HLZ_SELECT_TEXTCOLOR forState:UIControlStateNormal];
        if (self.block) {
            self.block(button2);
        }
    }
    else{
        [button2 setBackgroundColor:[UIColor whiteColor]];
        [button2 setTitleColor:HLZ_TEXTCOLOR forState:UIControlStateNormal];
    }
}

- (void) setChooseBlock:(chooseBlock)block{
    self.block = [block copy];
}

#pragma mark - 返回size
- (CGSize)returnSize
{
    return self.heightSize;
}

- (CGRect)sizeWithFont:(NSString *)text{
    CGRect textSize = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, HLZ_BUTTON_HEIGHT) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:HLZ_FONT_SIZE],NSFontAttributeName, nil] context:nil];
    return textSize;
}

@end
