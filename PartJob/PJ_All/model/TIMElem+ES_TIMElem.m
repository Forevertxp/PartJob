//
//  TIMElem+ES_TIMElem.m
//  Esports
//
//  Created by 田晓鹏 on 2020/4/8.
//  Copyright © 2020 esports. All rights reserved.
//

#import "TIMElem+ES_TIMElem.h"

#import <objc/runtime.h>

@implementation TIMElem (ES_TIMElem)

- (void)setSenderName:(NSString *)senderName {
    objc_setAssociatedObject(self, @"senderName", senderName, OBJC_ASSOCIATION_COPY);
}
                            
- (NSString *)senderName {
    return objc_getAssociatedObject(self, @"senderName");
}

- (void)setTimeStr:(NSString *)timeStr {
    objc_setAssociatedObject(self, @"timeStr", timeStr, OBJC_ASSOCIATION_COPY);
}

- (NSString *)timeStr {
    return objc_getAssociatedObject(self, @"timeStr");
}

@end
