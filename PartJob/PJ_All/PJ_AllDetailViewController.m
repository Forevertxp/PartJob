//
//  PJ_AllDetailViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/5.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_AllDetailViewController.h"

#import "PJ_ChatViewController.h"
#import "PJ_UserLoginViewController.h"
#import "PJ_UserEditViewController.h"

@interface PJ_AllDetailViewController ()

@end

@implementation PJ_AllDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"职位详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubViews];
}

-(void)loadSubViews
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(STANDAED_SIZE(30), kNavBarAndStatusBarHeight+STANDAED_SIZE(30), kScreenWidth-STANDAED_SIZE(60), STANDAED_SIZE(40))];
    titleLabel.text = _object[@"name"];
    [self.view addSubview:titleLabel];
    
    UILabel *localLabel = [[UILabel alloc]initWithFrame:CGRectMake(STANDAED_SIZE(30), kNavBarAndStatusBarHeight+STANDAED_SIZE(80), kScreenWidth-STANDAED_SIZE(60), STANDAED_SIZE(40))];
    localLabel.text = [NSString stringWithFormat:@"%@ | %@",_object[@"time"],_object[@"location"]];
    localLabel.font = LabelFont(28);
    localLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.view addSubview:localLabel];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(STANDAED_SIZE(30), kNavBarAndStatusBarHeight+STANDAED_SIZE(140), kScreenWidth-STANDAED_SIZE(60), STANDAED_SIZE(40))];
    priceLabel.font = LabelFont(28);
    priceLabel.textColor = [UIColor colorWithHexString:@"#FF6666"];
    priceLabel.text = [NSString stringWithFormat:@"%@/天",_object[@"price"]];
    [self.view addSubview:priceLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight+STANDAED_SIZE(200), kScreenWidth, STANDAED_SIZE(10))];
    line.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    [self.view addSubview:line];
    
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(STANDAED_SIZE(30), kNavBarAndStatusBarHeight+STANDAED_SIZE(230), kScreenWidth-STANDAED_SIZE(60), STANDAED_SIZE(40))];
    descLabel.text = @"职位描述";
    [self.view addSubview:descLabel];
    
    UITextView *descText = [[UITextView alloc]initWithFrame:CGRectMake(STANDAED_SIZE(30), kNavBarAndStatusBarHeight+STANDAED_SIZE(280), kScreenWidth-STANDAED_SIZE(60), STANDAED_SIZE(600))];
    descText.font = LabelFont(28);
    descText.textColor = [UIColor colorWithHexString:@"#666666"];
    descText.text = _object[@"description"];
    [self.view addSubview:descText];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [messageBtn setContentMode:UIViewContentModeScaleAspectFill];
    [messageBtn addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageBtn];
    
    UIButton *applyLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([_object[@"category"] integerValue]!=7) {
        [applyLabel setTitle:@"立即申请" forState:UIControlStateNormal];
    }else{
        [applyLabel setTitle:@"静候佳音" forState:UIControlStateNormal];
    }
    
    applyLabel.titleLabel.textColor = [UIColor whiteColor];
    applyLabel.backgroundColor = [UIColor colorWithHexString:@"FF6666"];
    [self.view addSubview:applyLabel];
    
    [applyLabel addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    
    [applyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@(STANDAED_SIZE(80)));
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(@(STANDAED_SIZE(500)));
    }];
    
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(applyLabel);
        make.left.equalTo(self.view);
        make.right.equalTo(applyLabel.mas_left);
    }];
    
}

-(void)chat{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    if (!phone) {
        PJ_UserLoginViewController *login = [[PJ_UserLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        PJ_ChatViewController *chat = [[PJ_ChatViewController alloc]init];
        [self.navigationController pushViewController:chat animated:YES];
    }
   
}

-(void)apply{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    if (!phone) {
        PJ_UserLoginViewController *login = [[PJ_UserLoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        if ([_object[@"category"] integerValue]!=7) {
            PJ_UserEditViewController *edit = [[PJ_UserEditViewController alloc]init];
            edit.type = 2;
            edit.jobId = _object[@"objectId"];
            [self.navigationController pushViewController:edit animated:YES];
        }
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
