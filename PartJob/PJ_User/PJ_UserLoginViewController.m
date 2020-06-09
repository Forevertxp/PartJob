//
//  PJ_UserLoginViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/3.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_UserLoginViewController.h"

@interface PJ_UserLoginViewController ()

@property(nonatomic ,strong)UITextField *textContent;
@property(nonatomic ,strong)UITextField *codeContent;
@property(nonatomic ,strong)UIButton *timeButton;

@end

@implementation PJ_UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:[self headerView]];
    [self loadCellSubViews];
    [self.view addSubview:[self footViews]];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
}

-(void)viewTapped:(UITapGestureRecognizer*)tap1
{

    [self.view endEditing:YES];

}

-(UIView*)headerView{
    UIView * headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, kNavBarAndStatusBarHeight, kScreenWidth, 180);
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, kScreenWidth, 180);
    gl.startPoint = CGPointMake(0.5, -0.3);
    gl.endPoint = CGPointMake(0.46, 1.13);
    gl.colors = @[(__bridge id)[UIColor colorWithHexString:@"#FF8000"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FF3333"].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [headerView.layer addSublayer:gl];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"欢迎使用蚂蚁兼职";
    title.font = [UIFont systemFontOfSize:24];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:title];
    title.backgroundColor = [UIColor clearColor];
    title.frame =  CGRectMake(0, 0, kScreenWidth, 180);
    return headerView;
}

- (UIView *)footViews {
    UIView *footView = [[UIView alloc]init];
    footView.frame = CGRectMake(0, kNavBarAndStatusBarHeight+180+ STANDAED_SIZE(250), kScreenWidth, STANDAED_SIZE(400));
    footView.backgroundColor = [UIColor whiteColor];
    
    UILabel *apilable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth, STANDAED_SIZE(44))];
    apilable.userInteractionEnabled = YES;
    apilable.numberOfLines = 0;
    apilable.textColor = [UIColor colorWithHexString:@"#9b9b9b"];
    apilable.font = LabelFont(24);
    apilable.textAlignment = NSTextAlignmentLeft;
    apilable.adjustsFontSizeToFitWidth = YES;
    apilable.minimumScaleFactor = 13.0;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"验证即完成账号注册 | 并代表您同意(用户服务协议)"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#F5A623"]  range:NSMakeRange(str.length-7,7)];
    apilable.attributedText = str;
    UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browseProcotol)];
    [apilable addGestureRecognizer:tap3];
    [footView addSubview:apilable];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = YES;
    button.frame = CGRectMake(STANDAED_SIZE(92), STANDAED_SIZE(100),kScreenWidth- STANDAED_SIZE(92)*2, STANDAED_SIZE(70));
    button.backgroundColor = [UIColor colorWithHexString:@"#FF8000"];
    [button setTitle:@"登 录" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(loginRequest) forControlEvents:(UIControlEventTouchUpInside)];
    [footView addSubview:button];
        
    return footView;
}


-(void)loadCellSubViews
{
    
    _textContent = [[UITextField alloc]init];
    _textContent.placeholder = @"请输入手机号";
    _textContent.clearButtonMode = UITextFieldViewModeAlways;
    _textContent.backgroundColor = [UIColor whiteColor];
    [_textContent addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged]; // 监听事件
    [self.view addSubview:_textContent];
    [_textContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavBarAndStatusBarHeight+180+ STANDAED_SIZE(50));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
    
    _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeButton.translatesAutoresizingMaskIntoConstraints = YES;
    _timeButton.backgroundColor = [UIColor colorWithHexString:@"#FF8000"];
    [_timeButton setTitle:@" 获取验证码 " forState:(UIControlStateNormal)];
    _timeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_timeButton addTarget:self action:@selector(timeEnd) forControlEvents:(UIControlEventTouchUpInside)];
    [_timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_timeButton];
    [_timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavBarAndStatusBarHeight+180+ STANDAED_SIZE(50));
        make.left.equalTo(self.textContent.mas_right).offset(STANDAED_SIZE(4));
        make.right.equalTo(self.view.mas_right).offset(-STANDAED_SIZE(30));
        make.height.mas_equalTo(STANDAED_SIZE(50));
    }];
    
    _codeContent = [[UITextField alloc]init];
    _codeContent.placeholder = @"请输入验证码";
    _codeContent.clearButtonMode = UITextFieldViewModeAlways;
    _codeContent.backgroundColor = [UIColor whiteColor];
    [_codeContent addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged]; // 监听事件
    [self.view addSubview:_codeContent];
    [_codeContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kNavBarAndStatusBarHeight+180+ STANDAED_SIZE(150));
        make.left.equalTo(self.view.mas_left).offset(STANDAED_SIZE(35));
        make.width.mas_equalTo(STANDAED_SIZE(500));
        make.height.mas_equalTo(STANDAED_SIZE(40));
    }];
}
- (void) textFieldDidChange:(UITextField*) sender {
    
}

-(void)browseProcotol{
    
}
-(void)loginRequest
{
    AVObject * user = [[PJ_NetHelper instance] requestUserInfo:_textContent.text];
    if (user) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:user[@"phone"] forKey:@"PJ_USER_PHPNE"];
        [defaults setObject:user[@"name"] forKey:@"PJ_USER_NAME"];
        [defaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }
}

-(void)timeEnd
{
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.timeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.timeButton.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.timeButton setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.timeButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
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
