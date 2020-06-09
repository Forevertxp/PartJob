//
//  PJ_UserHeaderView.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/3.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_UserHeaderView.h"

@implementation PJ_UserHeaderView{
    
    UIImageView *avatarIV ;
    
    UILabel *title;
    
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height-STANDAED_SIZE(20));
        gl.startPoint = CGPointMake(0.5, -0.3);
        gl.endPoint = CGPointMake(0.46, 1.13);
        gl.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FF8000"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FF3333"].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [self.layer addSublayer:gl];
        
        avatarIV = [[UIImageView alloc]init];
        avatarIV.image = [UIImage imageNamed:@"默认图"];
        avatarIV.layer.masksToBounds = YES;
        avatarIV.layer.cornerRadius = STANDAED_SIZE(75);
        [self addSubview:avatarIV];
           
        [avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(STANDAED_SIZE(30));
            make.centerX.equalTo(self);
            make.width.mas_equalTo(STANDAED_SIZE(150));
            make.height.mas_equalTo(STANDAED_SIZE(150));
        }];
        
        title = [[UILabel alloc]init];
        title.font = [UIFont systemFontOfSize:20];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor whiteColor];
        [self addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avatarIV.mas_bottom).offset(STANDAED_SIZE(30));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

-(void)refresh{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    if (!phone) {
        title.text = @"点击登录";
        avatarIV.image = [UIImage imageNamed:@"默认图"];
    }else{
        title.text = [defaults objectForKey:@"PJ_USER_NAME"];
        avatarIV.image = [UIImage imageNamed:@"头像"];
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
