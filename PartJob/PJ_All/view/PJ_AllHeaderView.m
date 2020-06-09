//
//  PJ_AllHeaderView.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_AllHeaderView.h"

@interface PJ_AllHeaderView()

@property (nonatomic) UIView *xiaoyuanView;
@property (nonatomic) UIView *xiaoshouView;
@property (nonatomic) UIView *canyinView;
@property (nonatomic) UIView *jigongView;
@property (nonatomic) UIView *shejiView;
@property (nonatomic) UIView *qitaView;

@end

@implementation PJ_AllHeaderView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _xiaoyuanView = [self viewWithName:@"校园" Pic:@"校园专区" Type:1];
        _xiaoyuanView.frame = CGRectMake(0, 0, kScreenWidth/3, STANDAED_SIZE(170));
        
        [self addSubview:_xiaoyuanView];
        
        _xiaoshouView = [self viewWithName:@"销售" Pic:@"销售动态" Type:2];
        _xiaoshouView.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, STANDAED_SIZE(170));
        
        [self addSubview:_xiaoshouView];
        
        _canyinView = [self viewWithName:@"餐饮" Pic:@"餐饮" Type:3];
        _canyinView.frame = CGRectMake(kScreenWidth/3*2, 0, kScreenWidth/3, STANDAED_SIZE(170));
        
        [self addSubview:_canyinView];
        
        _jigongView = [self viewWithName:@"技工" Pic:@"技术" Type:4];
        _jigongView.frame = CGRectMake(0, STANDAED_SIZE(170), kScreenWidth/3, STANDAED_SIZE(170));
        
        [self addSubview:_jigongView];
        
        _shejiView = [self viewWithName:@"设计" Pic:@"设计" Type:5];
        _shejiView.frame = CGRectMake(kScreenWidth/3, STANDAED_SIZE(170), kScreenWidth/3, STANDAED_SIZE(170));
        
        [self addSubview:_shejiView];
        
        _qitaView = [self viewWithName:@"其他" Pic:@"其他" Type:6];
        _qitaView.frame = CGRectMake(kScreenWidth/3*2, STANDAED_SIZE(170), kScreenWidth/3, STANDAED_SIZE(170));
        
        [self addSubview:_qitaView];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(STANDAED_SIZE(20), STANDAED_SIZE(360), kScreenWidth-STANDAED_SIZE(40), STANDAED_SIZE(10))];
        line.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        [self addSubview:line];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(UIView*)viewWithName:(NSString*)name Pic:(NSString*)pic Type:(int)type{
    UIView *view = [UIView new];
    UIView *bg = [[UIView alloc]init];
    bg.layer.masksToBounds = YES;
    bg.layer.cornerRadius = STANDAED_SIZE(40);
    [view addSubview:bg];
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:pic]];
    [bg addSubview:icon];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textColor = [UIColor colorWithHexString:@"#979797"];
    nameLabel.font = LabelFont(24);
    nameLabel.text = name;
    [view addSubview:nameLabel];
    
    UITapGestureRecognizer *tap;
    switch (type) {
        case 1:
            bg.backgroundColor = [UIColor colorWithHexString:@"#FF6666"];
            break;
        case 2:
            bg.backgroundColor = [UIColor colorWithHexString:@"#3399ff"];
            break;
        case 3:
            bg.backgroundColor = [UIColor colorWithHexString:@"#ff007f"];
            break;
        case 4:
            bg.backgroundColor = [UIColor colorWithHexString:@"#cc00cc"];
            break;
        case 5:
            bg.backgroundColor = [UIColor colorWithHexString:@"#99ff99"];
            break;
        case 6:
            bg.backgroundColor = [UIColor colorWithHexString:@"#ff8000"];
            break;
            
        default:
            break;
    }
    view.userInteractionEnabled = YES;
    view.tag = type;
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickView:)];
    [view addGestureRecognizer:tap];
    
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(STANDAED_SIZE(30));
        make.centerX.equalTo(view);
        make.width.height.equalTo(@(STANDAED_SIZE(100)));
    }];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bg);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(bg.mas_bottom).offset(STANDAED_SIZE(20));
    }];
    
    return view;
}

-(void)didClickView:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIView *view = (UIView *)tap.view;
    NSInteger index = view.tag;
    if (_delegate) {
        [_delegate didClickView:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
