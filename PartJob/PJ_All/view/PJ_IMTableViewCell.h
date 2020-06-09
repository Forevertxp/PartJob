//
//  ES_IMTableViewCell.h
//  Esports
//
//  Created by 田晓鹏 on 2020/4/8.
//  Copyright © 2020 esports. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TIMElem+ES_TIMElem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PJ_IMTableViewCell : UITableViewCell

@property (nonatomic, strong)TIMElem *model;

@end

NS_ASSUME_NONNULL_END
