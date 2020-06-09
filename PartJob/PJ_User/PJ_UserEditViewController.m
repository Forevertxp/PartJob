//
//  PJ_UserEditViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/3.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_UserEditViewController.h"

@interface PJ_UserEditViewController ()

@property (nonatomic,strong) UIImageView *avatarIV;

@property (nonatomic,strong) UITextField *nameContent;
@property (nonatomic,strong) UITextField *schoolContent;
@property (nonatomic,strong) UITextView *profileContent;
@property (nonatomic,strong) AVObject * user;

@end

@implementation PJ_UserEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"申请资料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubViews];
    [self loadData];
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
    nameL.text = @"姓名:";
    [self.view addSubview:nameL];
    
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(STANDAED_SIZE(100));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(80));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    _nameContent = [[UITextField alloc]init];
    _nameContent.placeholder = @"暂无";
    _nameContent.clearButtonMode = UITextFieldViewModeAlways;
    _nameContent.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_nameContent];
    [_nameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameL);
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(130));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    UILabel *schoolL = [[UILabel alloc]init];
    schoolL.text = @"学校:";
    [self.view addSubview:schoolL];
    
    [schoolL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameL.mas_bottom).offset(STANDAED_SIZE(50));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(80));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    _schoolContent = [[UITextField alloc]init];
    _schoolContent.placeholder = @"暂无";
    _schoolContent.clearButtonMode = UITextFieldViewModeAlways;
    _schoolContent.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_schoolContent];
    [_schoolContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(schoolL);
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(130));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    UILabel *profileL = [[UILabel alloc]init];
    profileL.text = @"个人描述";
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
    _profileContent.font = LabelFont(24);
    [self.view addSubview:_profileContent];
    [_profileContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileL.mas_bottom).offset(STANDAED_SIZE(50));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.right.equalTo(self.view.mas_right).offset(-STANDAED_SIZE(35));
        make.height.mas_equalTo(STANDAED_SIZE(250));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = YES;
    button.backgroundColor = [UIColor colorWithHexString:@"#FF8000"];
    [button addTarget:self action:@selector(updateRequest) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    if (self.type==1) {
        [button setTitle:@"完善资料" forState:(UIControlStateNormal)];
    }else{
        [button setTitle:@"立即申请" forState:(UIControlStateNormal)];
    }
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_profileContent.mas_bottom).offset(STANDAED_SIZE(100));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(90));
        make.right.equalTo(self.view.mas_right).offset(-STANDAED_SIZE(95));
        make.height.mas_equalTo(STANDAED_SIZE(80));
    }];
}

-(void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    
    if (phone) {
        self.user = [[PJ_NetHelper instance] requestUserInfo:phone];
        _avatarIV.image = [UIImage imageNamed:@"头像"];
        _nameContent.text = self.user[@"name"];
        _schoolContent.text = self.user[@"school"];
        _profileContent.text = self.user[@"profile"];
    }
}

-(void)updateRequest{
    if (self.type==1) {
        [[PJ_NetHelper instance] upateUserInfo:self.user[@"objectId"] Name:_nameContent.text School:_schoolContent.text Profile:_profileContent.text];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[PJ_NetHelper instance] applyJob:self.jobId];
        [SVProgressHUD showInfoWithStatus:@"申请成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
