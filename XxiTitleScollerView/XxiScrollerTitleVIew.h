//
//  XxiScrollerTitleVIew.h
//  XxiTitleScollerView
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^Callback)(NSInteger pageIndex);

@interface XxiScrollerTitleVIew : UIView
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *topLine;//顶部线条
@property(nonatomic,strong)UIButton *oldBtn;//之前选中的按钮

/**
 * titles   按钮的标题
 * CallBack 点击头部按钮时的回调
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles callBack:(Callback)block swipLineColor:(UIColor *)color titleNormalColor:(UIColor *)normalColor titleSelectColor:(UIColor *)selectColor;

/**
 * 选择对应的按钮
 */
- (void)selectButtonIndex:(NSInteger)index;

/**
 * 设置底部线条的实时偏移量
 */
- (void)moveTopViewLine:(CGPoint)point;

@end
