//
//  ViewController.m
//  XxiTitleScollerView
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//
#define ScaleWidth ([UIScreen mainScreen].bounds.size.width/750)

#import "ViewController.h"
#import "XxiScrollerTitleVIew.h"
#import "Masonry.h"
#import "XxiTableViewCell.h"

//第一个提交至github的项目

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)XxiScrollerTitleVIew *titleView;
@property(nonatomic,strong)UITableView *xxiTabalView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"First",@"Second",@"Three",@"Four",@"Five",@"Six",@"Seven"];
    __weak typeof(self)weakSelf = self;
    _titleView = [[XxiScrollerTitleVIew alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 80) titles:self.titles callBack:^(NSInteger pageIndex) {
        NSLog(@"%ld",pageIndex);
        [weakSelf.scrollView setContentOffset:CGPointMake(pageIndex * weakSelf.scrollView.bounds.size.width, 0) animated:NO];
    } swipLineColor:[UIColor redColor] titleNormalColor:[UIColor blackColor] titleSelectColor:[UIColor blueColor]];
    [self.view addSubview:_titleView];
    
    // 创建滚动视图控制器的scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_titleView.frame))];
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
//    self.scrollView.scrollEnabled = NO;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * _titles.count, self.scrollView.bounds.size.height);
    [self.view addSubview:self.scrollView];
    [self addChildrenView];
}

#pragma mark addView
-(void)addChildrenView
{
    for(NSInteger i=0;i<self.titles.count;i++){
        self.xxiTabalView = [[UITableView alloc]init];
        self.xxiTabalView.tag = 100 + i;
        self.xxiTabalView.bounces = NO;
        self.xxiTabalView.delegate = self;
        self.xxiTabalView.dataSource = self;
        self.xxiTabalView.backgroundColor = [UIColor whiteColor];
        [self.xxiTabalView registerClass:[XxiTableViewCell class] forCellReuseIdentifier:@"XxiTableViewCell"];
        self.xxiTabalView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.xxiTabalView.frame = CGRectMake(self.scrollView.bounds.size.width * i, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:self.xxiTabalView];
    }
}

#pragma mark - UIScrollViewDelegate
//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [_titleView selectButtonIndex:index];
    NSLog(@"scrollViewDidEndDecelerating");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_titleView moveTopViewLine:scrollView.contentOffset];
    NSLog(@"scrollViewDidScroll");
}

#pragma mark tableViewDelegate && tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XxiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XxiTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(tableView.tag == 102){
        [cell.label setTextColor:[UIColor blueColor]];
    }
    return  cell;
}

@end
