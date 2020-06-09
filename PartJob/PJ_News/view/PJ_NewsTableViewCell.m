//
//  PJ_NewsTableViewCell.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/5.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_NewsTableViewCell.h"

#import "UIImageView+WebCache.h"

@interface PJ_NewsTableViewCell()

@property (nonatomic,strong)UIImageView *imageIV;

@property (nonatomic,strong)UILabel *titlLabel;
@property (nonatomic,strong)UILabel *markLabel;
@property (nonatomic,strong)UILabel *authorLabel;
@property (nonatomic,strong)UILabel *readNumberLabel;

@property (nonatomic,strong)UIView *line;
@end

@implementation PJ_NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    return self;
}

/**
 *  子视图
 */
- (void)setupSubviews
{
    _imageIV = [[UIImageView alloc]init];
    _imageIV.backgroundColor = [UIColor whiteColor];
    _imageIV.layer.masksToBounds = YES;
    _imageIV.layer.cornerRadius = STANDAED_SIZE(9);
    [self.contentView addSubview:_imageIV];
    [_imageIV mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(STANDAED_SIZE(25));
        make.bottom.mas_equalTo(-STANDAED_SIZE(28));
        make.left.equalTo(self.contentView.mas_left).offset(STANDAED_SIZE(38));
        make.width.mas_equalTo(STANDAED_SIZE(200));
        make.height.mas_equalTo(STANDAED_SIZE(144));
    }];
                   
    _titlLabel = [[UILabel alloc]init];
    _titlLabel.font = LabelFont(30);
    _titlLabel.numberOfLines = 2;
    _titlLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titlLabel];
    [_titlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(STANDAED_SIZE(29));
        make.left.equalTo(_imageIV.mas_right).offset(STANDAED_SIZE(20));
        make.right.equalTo(self.contentView.mas_right).offset(STANDAED_SIZE(-20));
    }];
                   
    _markLabel = [[UILabel alloc]init];
    _markLabel.textAlignment = NSTextAlignmentLeft;
    _markLabel.text = @"图文";
    _markLabel.textColor = [UIColor colorWithHexString:@"#737478"];
    _markLabel.font = LabelFont(26);
    [self.contentView addSubview:_markLabel];
    [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(STANDAED_SIZE(130));
        make.left.equalTo(_titlLabel.mas_left);
        make.width.mas_equalTo(STANDAED_SIZE(100));
        make.height.mas_equalTo(STANDAED_SIZE(30));
    }];
    
    UIImageView *imageViewC = [[UIImageView alloc]init];
    [self.contentView addSubview:imageViewC];
    imageViewC.image =[UIImage imageNamed:@"author"];
    [imageViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(STANDAED_SIZE(130));
        make.left.equalTo(_markLabel.mas_right).offset(STANDAED_SIZE(0));
        make.width.mas_equalTo(imageViewC.image.size.width);
        make.height.mas_equalTo(imageViewC.image.size.height);
    }];
    
    _authorLabel = [[UILabel alloc]init];
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    _authorLabel.text = @"作者";
    _authorLabel.textColor = [UIColor colorWithHexString:@"#737478"];
    _authorLabel.font = LabelFont(26);
    [self.contentView addSubview:_authorLabel];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(STANDAED_SIZE(130));
        make.left.equalTo(imageViewC.mas_right).offset(STANDAED_SIZE(5));
        make.width.mas_equalTo(STANDAED_SIZE(110));
        make.height.mas_equalTo(STANDAED_SIZE(30));
    }];
    
    _readNumberLabel = [[UILabel alloc]init];
    _readNumberLabel.textAlignment = NSTextAlignmentRight;
    _readNumberLabel.text = [NSString stringWithFormat:@"浏览量：1232"];
    _readNumberLabel.textColor = [UIColor colorWithHexString:@"#737478"];
    _readNumberLabel.font = LabelFont(26);
    [self.contentView addSubview:_readNumberLabel];
    _readNumberLabel.backgroundColor = [UIColor whiteColor];
    [_readNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(STANDAED_SIZE(130));
        make.left.equalTo(_authorLabel.mas_right).offset(STANDAED_SIZE(0));
        make.width.mas_equalTo(STANDAED_SIZE(190));
        make.height.mas_equalTo(STANDAED_SIZE(30));
    }];
       
    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(-STANDAED_SIZE(3));
        make.left.equalTo(self.contentView .mas_left).offset(STANDAED_SIZE(30));
        make.width.mas_equalTo(STANDAED_SIZE(681));
        make.height.mas_equalTo(0.5);
    }];
               
}

-(void)setTableCellWithData:(AVObject*)object
{
    [_imageIV sd_setImageWithURL:[NSURL URLWithString:object[@"imageUrl"]] placeholderImage:nil];
    _titlLabel.text = object[@"title"];
    _authorLabel.text = object[@"author"];
    _markLabel.text = object[@"profile"];
    _readNumberLabel.text = [NSString stringWithFormat:@"浏览量：%@",object[@"readNumber"]];
    
}
// cell分割线的创建
-(UIView *)line{
    if (!_line) {
        _line = [[UIView  alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    [self.contentView addSubview:_line];
    return _line;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
