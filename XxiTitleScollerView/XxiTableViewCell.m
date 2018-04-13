//
//  XxiTableViewCell.m
//  XxiTitleScollerView
//
//  Created by XXxxi on 2018/4/13.
//  Copyright © 2018年 Chomp. All rights reserved.
//

#import "XxiTableViewCell.h"
#import "Masonry.h"

@implementation XxiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label = [[UILabel alloc]init];
        [self.label setText:@"这是一个label"];
        [self.label setTextColor:[UIColor redColor]];
        [self.label setFont:[UIFont systemFontOfSize:25]];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
        }];
    }
    return  self;
}

@end
