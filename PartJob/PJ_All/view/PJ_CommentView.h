//
//  ES_CommentView.h
//  Esports
//
//  Created by 田晓鹏 on 2020/4/13.
//  Copyright © 2020 esports. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PJ_TextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PJ_CommentView : UIView <EAMTextViewDelegate>

@property (nonatomic, strong) PJ_TextView* textView;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, strong) void (^sendAction)(void);

@end

NS_ASSUME_NONNULL_END
