//
//  ES_IMTableViewCell.m
//  Esports
//
//  Created by 田晓鹏 on 2020/4/8.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_IMTableViewCell.h"

@interface PJ_IMTableViewCell()

@property (nonatomic, strong) UILabel *label_1;
@property (nonatomic, strong) UILabel *label_2;
@property (nonatomic, strong) UILabel *label_3;

@end

@implementation PJ_IMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:view];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    [view.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:4].active = YES;
    [view.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:8].active = YES;
    [view.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-8].active = YES;
    [view.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-4].active = YES;
    
    UILabel *lb = [[UILabel alloc] init];
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    lb.textColor = [UIColor colorWithHexString:@"#192126"];
    lb.font = [UIFont systemFontOfSize:15.0 weight:(UIFontWeightRegular)];
    [view addSubview:lb];
    self.label_1 = lb;

    UILabel *label_2 = [[UILabel alloc] init];
    label_2.translatesAutoresizingMaskIntoConstraints = NO;
    label_2.numberOfLines = 1;
    label_2.textAlignment = NSTextAlignmentRight;
    label_2.textColor = [UIColor colorWithHexString:@"#AAB2B7"];
    label_2.font = [UIFont systemFontOfSize:12.0 weight:(UIFontWeightRegular)];
    [view addSubview:label_2];
    self.label_2 = label_2;

    UILabel *label_3 = [[UILabel alloc] init];
    label_3.translatesAutoresizingMaskIntoConstraints = NO;
    label_3.textColor = [UIColor colorWithHexString:@"#333333"];
    label_3.font = [UIFont systemFontOfSize:14.0 weight:(UIFontWeightLight)];
    label_3.numberOfLines = -1;
    [view addSubview:label_3];
    self.label_3 = label_3;
    
    UIView *subV = [[UIView alloc] init];
    subV.translatesAutoresizingMaskIntoConstraints = NO;
    subV.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    [self.contentView addSubview:subV];
    
    [lb.topAnchor constraintEqualToAnchor:view.topAnchor constant:8].active = YES;
    [lb.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:8].active = YES;
    [lb.rightAnchor constraintEqualToAnchor:label_2.leftAnchor constant: 8].active = YES;
    [lb.heightAnchor constraintEqualToConstant:20.0].active = YES;
    [label_2.topAnchor constraintEqualToAnchor:lb.topAnchor constant:0].active = YES;
    [label_2.rightAnchor constraintEqualToAnchor:view.rightAnchor constant:-8].active = YES;
    
    [label_3.topAnchor constraintEqualToAnchor:lb.bottomAnchor constant:4].active = YES;
    [label_3.leftAnchor constraintEqualToAnchor:lb.leftAnchor constant:0].active = YES;
    [label_3.rightAnchor constraintEqualToAnchor:label_2.rightAnchor constant:0].active = YES;
    [label_3.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-4].active = YES;
    
    [subV.heightAnchor constraintEqualToConstant:0.5].active = YES;
    [subV.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:15].active = YES;
    [subV.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-15].active = YES;
    [subV.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-1].active = YES;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.label_2.text = nil;
    self.label_1.text = nil;
    self.label_3.text = nil;
}

- (void)setModel:(TIMElem *)model {
    _model = model;
    if(model) {
        if ([model isKindOfClass:[TIMTextElem class]]) {
            TIMTextElem *msg = (TIMTextElem *)model;
            self.label_1.text =  msg.senderName;
            self.label_1.textColor = [UIColor colorWithHexString:@"#171F24"];
            self.label_2.text = msg.timeStr;
            self.label_3.text = msg.text;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
