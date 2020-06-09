//
//  PJ_NetHelper.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_NetHelper.h"

static PJ_NetHelper *helper;

@implementation PJ_NetHelper

+(instancetype)instance{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        helper =[[PJ_NetHelper alloc] init];
    });
    return helper;
}

- (void)requestJobListWithType:(NSInteger)type Page:(NSInteger)page Success:(void (^)(NSArray* result))success{
    AVQuery *query = [AVQuery queryWithClassName:@"jianzhi"];
    if (type!=0) {
        [query whereKey:@"category" equalTo:@(type)];
    }
    query.limit = 10;
    query.skip = 10*(page-1);
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (success){
            success(array);
        }
    }];
}

- (void)applyJob:(NSString*)objectId{
    AVObject *object = [AVObject objectWithClassName:@"jianzhi" objectId:objectId];
    [object setObject:@(7) forKey:@"category"];
    [object saveInBackground];
}

- (void)requestNewsList:(void (^)(NSArray* result))success{
    AVQuery *query = [AVQuery queryWithClassName:@"jianzhi_news"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (success){
            success(array);
        }
    }];
}

- (void)requestJobDetail{
    AVQuery *query = [AVQuery queryWithClassName:@"jianzhi"];
    [query getObjectInBackgroundWithId:@"5ed4c753b3d3940008365c1b" block:^(AVObject *todo, NSError *error) {
        // todo 就是 objectId 为 582570f38ac247004f39c24b 的 Todo 实例
        NSString *title    = todo[@"name"];

        // 获取内置属性
        NSString *objectId = todo.objectId;
        NSDate *updatedAt  = todo.updatedAt;
        NSDate *createdAt  = todo.createdAt;
    }];
}

- (AVObject*)requestUserInfo:(NSString*)phone{
    AVQuery *query = [AVQuery queryWithClassName:@"yonghu"];
    [query whereKey:@"phone" equalTo:phone];
    AVObject *object = [query getFirstObject];
    return object;
}

- (void)upateUserInfo:(NSString*)objectId
                 Name:(NSString*)name
               School:(NSString*)school
              Profile:(NSString*)profile{
    AVObject *object = [AVObject objectWithClassName:@"yonghu" objectId:objectId];
    [object setObject:name forKey:@"name"];
    [object setObject:school forKey:@"school"];
    [object setObject:profile forKey:@"profile"];
    [object saveInBackground];
}

@end
