//
//  PJ_NetHelper.h
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PJ_NetHelper : NSObject

+(instancetype)instance;

- (void)requestJobListWithType:(NSInteger)type Page:(NSInteger)page Success:(void (^)(NSArray* result))success;
- (void)applyJob:(NSString*)objectId;
- (void)requestNewsList:(void (^)(NSArray* result))success;
- (void)requestJobDetail;
- (AVObject*)requestUserInfo:(NSString*)phone;
- (void)upateUserInfo:(NSString*)objectId
                 Name:(NSString*)name
               School:(NSString*)school
              Profile:(NSString*)profile;

@end

NS_ASSUME_NONNULL_END
