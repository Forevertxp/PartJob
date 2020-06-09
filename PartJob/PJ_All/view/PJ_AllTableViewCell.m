//
//  PJ_AllTableViewCell.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_AllTableViewCell.h"

@interface PJ_AllTableViewCell()

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UIImageView *timeImage;
@property (nonatomic,strong)UIImageView *localImage;

@property (nonatomic,strong)UILabel *localLabel;

@end

@implementation PJ_AllTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier; {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.localLabel];
        [self.contentView addSubview:self.timeImage];
        [self.contentView addSubview:self.localImage];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-STANDAED_SIZE(20));
            make.centerY.equalTo(self.label);
        }];
    }
    return self;
}


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.frame = CGRectMake(STANDAED_SIZE(30), 0, 300, STANDAED_SIZE(100));
    }
    return _label;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = [UIColor colorWithHexString:@"#FF6666"];
        _priceLabel.font = [UIFont systemFontOfSize:STANDAED_SIZE(24)];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UIImageView *)timeImage {
    if (!_timeImage) {
        _timeImage = [[UIImageView alloc]init];
        _timeImage.image = [UIImage imageNamed:@"时间"];
        _timeImage.frame = CGRectMake(STANDAED_SIZE(30), STANDAED_SIZE(105), STANDAED_SIZE(32), STANDAED_SIZE(32));
    }
    return _timeImage;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = LabelFont(28);
        _timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _timeLabel.frame = CGRectMake(STANDAED_SIZE(80), STANDAED_SIZE(100), kScreenWidth, STANDAED_SIZE(50));
    }
    return _timeLabel;
}

- (UIImageView *)localImage {
    if (!_localImage) {
        _localImage = [[UIImageView alloc]init];
        _localImage.image = [UIImage imageNamed:@"地址"];
        _localImage.frame = CGRectMake(STANDAED_SIZE(30), STANDAED_SIZE(160), STANDAED_SIZE(32), STANDAED_SIZE(32));
    }
    return _localImage;
}

- (UILabel *)localLabel {
    if (!_localLabel) {
        _localLabel = [[UILabel alloc]init];
        _localLabel.font = LabelFont(28);
        _localLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _localLabel.frame = CGRectMake(STANDAED_SIZE(80), STANDAED_SIZE(150), STANDAED_SIZE(200), STANDAED_SIZE(50));
    }
    return _localLabel;
}

-(void)setTableCellWithData:(AVObject*)object{
    
    _label.text = object[@"name"];
    _priceLabel.text = [NSString stringWithFormat:@"%@/天",object[@"price"]];
    _timeLabel.text = object[@"time"];
    _localLabel.text = object[@"location"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
