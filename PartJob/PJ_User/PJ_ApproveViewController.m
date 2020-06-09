//
//  PJ_ApproveViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/4.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_ApproveViewController.h"

@interface PJ_ApproveViewController ()

@property (nonatomic,strong) UIImageView *avatarIV;

@property (nonatomic,strong) UILabel *nameContent;
@property (nonatomic,strong) UILabel *schoolContent;
@property (nonatomic,strong) UITextView *profileContent;
@property (nonatomic,strong) AVObject * user;

@end

@implementation PJ_ApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"认证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubViews];
}

-(void)loadSubViews
{
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, kNavBarAndStatusBarHeight, kScreenWidth, STANDAED_SIZE(300));
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, kScreenWidth, 180);
    gl.startPoint = CGPointMake(0.5, -0.3);
    gl.endPoint = CGPointMake(0.46, 1.13);
    gl.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FF8000"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FF3333"].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [headerView.layer addSublayer:gl];
    [self.view addSubview:headerView];
    
    _avatarIV = [[UIImageView alloc]init];
    _avatarIV.image = [UIImage imageNamed:@"默认图"];
    _avatarIV.layer.masksToBounds = YES;
    _avatarIV.layer.cornerRadius = STANDAED_SIZE(90);
    [self.view addSubview:_avatarIV];
       
    [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(-STANDAED_SIZE(120));
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(STANDAED_SIZE(180));
        make.height.mas_equalTo(STANDAED_SIZE(180));
    }];
    
    UILabel *nameL = [[UILabel alloc]init];
    nameL.text = @"企业名称:";
    [self.view addSubview:nameL];
    
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(STANDAED_SIZE(100));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(160));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    _nameContent = [[UILabel alloc]init];
    _nameContent.text = @"阿里云";
    _nameContent.textColor = [UIColor colorWithHexString:@"#666666"];
    _nameContent.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_nameContent];
    [_nameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameL);
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(180));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    UILabel *schoolL = [[UILabel alloc]init];
    schoolL.text = @"企业规模:";
    [self.view addSubview:schoolL];
    
    [schoolL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameL.mas_bottom).offset(STANDAED_SIZE(50));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(160));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    _schoolContent = [[UILabel alloc]init];
    _schoolContent.text = @"10000人+";
    _schoolContent.textColor = [UIColor colorWithHexString:@"#666666"];
    _schoolContent.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_schoolContent];
    [_schoolContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(schoolL);
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(180));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    UILabel *profileL = [[UILabel alloc]init];
    profileL.text = @"企业简介";
    [self.view addSubview:profileL];
       
    [profileL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(schoolL.mas_bottom).offset(STANDAED_SIZE(50));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    _profileContent = [[UITextView alloc]init];
    _profileContent.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    _profileContent.textColor = [UIColor colorWithHexString:@"#333333"];
    _profileContent.font = LabelFont(28);
    _profileContent.text = @"阿里云创立于2009年，为阿里巴巴集团旗下的云计算业务。Gartner及IDC的资料分别显示，阿里云是全球三大基础设施即服务（IaaS）供应商之一以及中国最大的公共云服务供应商。阿里云向阿里巴巴集团电商平台上的商家以及初创公司、企业与政府机构等全球用户，提供一整套云计算服务。";
    [self.view addSubview:_profileContent];
    
    [_profileContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileL.mas_bottom).offset(STANDAED_SIZE(50));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.right.equalTo(self.view.mas_right).offset(-STANDAED_SIZE(35));
        make.height.mas_equalTo(STANDAED_SIZE(250));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = YES;
    button.backgroundColor = [UIColor colorWithHexString:@"#C0C0C0"];
    [button addTarget:self action:@selector(apply) forControlEvents:(UIControlEventTouchUpInside)];
    [button setTitle:@"认证中" forState:(UIControlStateNormal)];
    button.enabled = NO;
    [self.view addSubview:button];
    
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_profileContent.mas_bottom).offset(STANDAED_SIZE(100));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(90));
        make.right.equalTo(self.view.mas_right).offset(-STANDAED_SIZE(95));
        make.height.mas_equalTo(STANDAED_SIZE(80));
    }];
}

-(void)apply{
    
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
