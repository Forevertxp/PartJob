//
//  ES_CommentView.m
//  Esports
//
//  Created by 田晓鹏 on 2020/4/13.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_CommentView.h"

@interface PJ_CommentView ()

@property (nonatomic, strong) UIButton* sendButton;

@end

@implementation PJ_CommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        [self addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.height.equalTo(@1);
            make.width.equalTo(@(kScreenWidth));
        }];
        
        self.textView = [[PJ_TextView alloc]init];
        [self addSubview:self.textView];
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setImage:[UIImage imageNamed:@"发送"] forState:UIControlStateNormal];
        [self addSubview:_sendButton];
        [_sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-5);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
        }];

        
        self.textView.delegate = self;
        self.textView.autoresizesVertically = YES;
        self.textView.minimumHeight = 32.0f;
        self.textView.maximumHeight = 120.0f;
        self.textView.font=LabelFont(28);
        self.textView.textColor=[UIColor colorWithHexString:@"#B4AFAF"];
        self.textView.layer.cornerRadius = 8;
        self.textView.placeholder = @"有何意向？说来听听...";
        self.textView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        
        self.textView.layer.borderWidth = 1.0f;
        self.textView.layer.borderColor = [[UIColor colorWithHexString:@"#D9D9D9"] CGColor];
        
        [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.height.equalTo(@(40));
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.sendButton.mas_left).offset(-10);
        }];
    }
    return self;
}

- (void)sendButtonPressed:(UIButton*)sender
{
    if (_sendAction != nil)
    {
        _sendAction();
    }
}

- (void)textView:(PJ_TextView *)textView willChangeFromHeight:(CGFloat)oldHeight toHeight:(CGFloat)newHeight
{
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.height.equalTo(@(newHeight));
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.sendButton.mas_left).offset(-10);
    }];
}

- (NSString*)text
{
    return _textView.text;
}

- (void)setText:(NSString *)text
{
    [_textView setText:text];
    if ([text isEqualToString:@""]) {
        [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.height.equalTo(@32);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.sendButton.mas_left).offset(-10);
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
