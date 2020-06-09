//
//  ViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_ViewController.h"

#import "Reachability.h"

#import "PJ_MainViewController.h"

#import "PJ_News/PJ_NewsTableViewController.h"
#import "PJ_All/PJ_AllTableViewController.h"
#import "PJ_User/PJ_UserTableViewController.h"

@interface PJ_ViewController ()

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;

@end

@implementation PJ_ViewController

+(void)load {
    
    NSArray *array = [NSArray arrayWithObjects:[self class], nil];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:array];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#ff3333"];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];

    NSMutableDictionary *attrs1 = [NSMutableDictionary dictionary];
    attrs1[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#8a8a8a"];
    [item setTitleTextAttributes:attrs1 forState:UIControlStateNormal];

    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:STANDAED_SIZE(28)] } forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
    [self listenNetWorkingStatus];
}

-(void)setup {
    
    UINavigationController *sportsNav = [[UINavigationController alloc]initWithRootViewController:[[PJ_AllTableViewController alloc]init]];
    sportsNav.title = @"兼职";
    sportsNav.tabBarItem.image = [[UIImage imageNamed:@"兼职"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sportsNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"兼职选择"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *newsNav = [[UINavigationController alloc]initWithRootViewController:[[PJ_NewsTableViewController alloc]init]];
    newsNav.title = @"经验";
    newsNav.tabBarItem.image = [[UIImage imageNamed:@"经验"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newsNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"经验选择"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:[[PJ_UserTableViewController alloc]init]];
    userNav.title = @"我的";
    userNav.tabBarItem.image = [[UIImage imageNamed:@"我的"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"我的选择"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = [NSArray arrayWithObjects:sportsNav,newsNav,userNav,nil];
    
}

// 网络监听
-(void)listenNetWorkingStatus{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    // 设置网络检测的站点
    NSString *remoteHostName = @"www.apple.com";
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
            case NotReachable:
            break;
            
            case ReachableViaWWAN:
                [self requestData];
            break;
            
            case ReachableViaWiFi:
                [self requestData];
            break;
            
        default:
            break;
    }
}

-(void)requestData{
    AVQuery *query = [AVQuery queryWithClassName:@"job"];
    [query getObjectInBackgroundWithId:@"5ede0712572b320009759c90" block:^(AVObject *object, NSError *error) {
        if (object && object[@"url"]&&![@"" isEqualToString:object[@"url"]]) {
            PJ_MainViewController *main = [[PJ_MainViewController alloc]init];
            main.modalPresentationStyle = UIModalPresentationFullScreen;
            main.object = object;
            [self presentViewController:main animated:NO completion:^{
            }];
        }
    }];
}

@end
