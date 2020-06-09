//
//  PJ_AllHeaderView.h
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PJ_AllHeaderViewDelegate <NSObject>

-(void)didClickView:(NSInteger)position;

@end

@interface PJ_AllHeaderView : UIView

@property (nonatomic,strong) id<PJ_AllHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
