//
//  AppDelegate.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "AppDelegate.h"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AVOSCloud setApplicationId:@"lBissdVtrukyGkFtSMz9P95D-gzGzoHsz"
          clientKey:@"Krb5moo4iL4A46O4nWhlkdFk"
    serverURLString:@"https://lbissdvt.lc-cn-n1-shared.com"];
    
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        switch ([settings authorizationStatus]) {
            case UNAuthorizationStatusAuthorized:
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
                break;
            case UNAuthorizationStatusNotDetermined:
                [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        });
                    }
                }];
                break;
            default:
                break;
        }
    }];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    [[AVInstallation defaultInstallation] setDeviceTokenFromData:deviceToken
                                                          teamId:@"5K3WC542NF"];
    [[AVInstallation defaultInstallation] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            // save succeeded
        } else if (error) {
            NSLog(@"%@", error);
        }
    }];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
     NSLog(@"%@", error);
}


@end
