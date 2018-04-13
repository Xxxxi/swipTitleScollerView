//
//  XxiScrollerTitleVIew.m
//  XxiTitleScollerView
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiScrollerTitleVIew.h"
#define ScaleWidth ([UIScreen mainScreen].bounds.size.width/750)

/**
 *
 按钮起始的tag值
 */
#define kBtnTag 777
/**
 *
 每屏显示的按钮的最大个数
 */
#define kSingleViewBtnCount 5
/**
 *
 按钮的超出部分
 */
#define kBtnBeyondWidth 30

@interface XxiScrollerTitleVIew()
@property (nonatomic, strong) Callback block;
@end


@implementation XxiScrollerTitleVIew
{
    // 记录titles count
    NSInteger _titlesCount;
    //按钮宽度
    CGFloat _btnWidth;
}

/**
 初始化方法
 
 @param frame <#frame description#>
 @param titles <#titles description#>
 @param block <#block description#>
 @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles callBack:(Callback)block swipLineColor:(UIColor *)color titleNormalColor:(UIColor *)normalColor titleSelectColor:(UIColor *)selectColor
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        _titlesCount = titles.count;
        self.block = block;
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        // 计算按钮的宽度
        if (titles.count <= kSingleViewBtnCount) {
            _btnWidth = self.bounds.size.width / titles.count;
        } else {
            _btnWidth = self.bounds.size.width / kSingleViewBtnCount + kBtnBeyondWidth;
        }
        _scrollView.contentSize = CGSizeMake(titles.count * _btnWidth, _scrollView.bounds.size.height);
        for (int i = 0; i < titles.count; i++)
        {
            self.btn = [self createBtn:CGRectMake(_btnWidth * i, 0, _btnWidth, self.bounds.size.height) title:titles[i] normalColor:normalColor selectColor:selectColor];
            [_scrollView addSubview:self.btn];
            self.btn.tag = kBtnTag + i;
            if (i == 0) {   //一开始的话默认选择第一个
                self.btn.selected = YES;
                _index = 0;
                
//                UIImageView *redImage = [[UIImageView alloc]initWithFrame:CGRectMake(_btnWidth-12, 2, 12, 12)];
//                redImage.backgroundColor = [UIColor redColor];
//                redImage.layer.cornerRadius = 6;
//                redImage.clipsToBounds = YES;
//                redImage.hidden = YES;
//                [self.btn addSubview:redImage];
                // 线条
                _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-2, _btnWidth, 2)];
                _topLine.backgroundColor = color;
                [_scrollView addSubview:_topLine];
            }
        }
    }
    return self;
}

- (UIButton *)createBtn:(CGRect)frame title:(NSString *)title  normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:28*ScaleWidth]];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectColor forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)btnClick:(UIButton *)sender
{
    if (sender.selected) return;
    sender.selected = YES;
    [sender.titleLabel setFont:[UIFont systemFontOfSize:32*ScaleWidth]];
    self.oldBtn = (UIButton *)[_scrollView viewWithTag:kBtnTag + _index];
    self.oldBtn.selected = NO;
    [self.oldBtn.titleLabel setFont:[UIFont systemFontOfSize:28*ScaleWidth]];
    // 记录新的下标
    _index = sender.tag - kBtnTag;
    if (self.block) {
        self.block(_index);
    }
}
/**
 选择对应的按钮
 */
- (void)selectButtonIndex:(NSInteger)index
{
    UIButton *btn = (UIButton *)[_scrollView viewWithTag:kBtnTag + index];
    if (btn.selected) return;
    btn.selected = YES;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:32*ScaleWidth]];
    // 将之前的变为不选中
    UIButton *oldBtn = (UIButton *)[_scrollView viewWithTag:kBtnTag + _index];
    oldBtn.selected = NO;
    [oldBtn.titleLabel setFont:[UIFont systemFontOfSize:28*ScaleWidth]];
    // 记录
    _index = index;
}
/**
 设置底部线条的实时偏移量
 */
- (void)moveTopViewLine:(CGPoint)point
{
    CGRect rect = _topLine.frame;
    
    if (_titlesCount <= kSingleViewBtnCount)
    {
        rect.origin.x = point.x / _titlesCount;
    }
    else
    {
        // 计算超过kSingleViewBtnCount个数按钮的线条偏移量
        rect.origin.x = (point.x / kSingleViewBtnCount) + (point.x / self.bounds.size.width * kBtnBeyondWidth);
    }
    _topLine.frame = rect;
    // 修改scrollView的偏移量
    [_scrollView scrollRectToVisible:rect animated:YES];  //滚动到特定的区域，这个区域需要在滚动视图的坐标空间中
}

@end
