//
//  PJ_ChatViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/5.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_ChatViewController.h"

#import <ImSDK/ImSDK.h>

#import "PJ_IMTableViewCell.h"
#import "PJ_CommentView.h"


@interface PJ_ChatViewController ()<TIMMessageListener,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *bottomBgView;

@property (nonatomic, retain) NSMutableArray *dialogArr;
@property (nonatomic, retain) TIMConversation *conversation;

@property (nonatomic, retain) PJ_CommentView *commentBottomView;

@end

@implementation PJ_ChatViewController

-(void)viewWillAppear:(BOOL)animated{
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisappear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self setUpForDismissKeyboard];
}




- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"在线咨询";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, kScreenWidth, kScreenHeight-kScreenWidth / 16 * 9- kStatusBarHeight)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupCommentBottomView];
    
    [self int_ES_dialog];
}

-(void)backClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupCommentBottomView {
    _commentBottomView = [[PJ_CommentView alloc] init];
    _commentBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentBottomView];
    
    [_commentBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak PJ_ChatViewController* wself = self;
    _commentBottomView.sendAction = ^{
        NSString *textStr = wself.commentBottomView.text;
        if(textStr.length > 0 && textStr) {
            TIMTextElem * text_elem = [[TIMTextElem alloc] init];
            text_elem.text = textStr;
            TIMMessage *msg = [[TIMMessage alloc] init];
            [msg addElem:text_elem];
            
            [wself.conversation sendMessage:msg succ:^(){
                wself.textView.text = nil;
                [wself insertES_DialogModel:msg];
                [wself.view endEditing:YES];
            }fail:^(int code, NSString * err) {
                [SVProgressHUD showErrorWithStatus:@"消息发送失败"];
                [SVProgressHUD dismissWithDelay:2.0];
            }];
        }else {
            [SVProgressHUD showWithStatus:@"发送内容不可为空"];
            [SVProgressHUD dismissWithDelay:2.0];
        }
    };
    
}

#pragma player delegate

-(void)shutdownWithProgress:(NSInteger)progress{
    [self.navigationController popViewControllerAnimated:YES];
}

// 自动播放下一个
- (void)autoPlayNext{
    
}

// 状态显隐
-(void)updateStatusBarAppearance{
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)int_ES_dialog{
    TIMSdkConfig *config = [[TIMSdkConfig alloc] init];
    config.sdkAppId = 1400068198;
    config.disableLogPrint = YES;
    
    TIMManager *manager = [TIMManager sharedInstance];
    [[TIMManager sharedInstance] addMessageListener:self];
    [manager initSdk:config];
       
       // 登陆
    TIMLoginParam *param = [[TIMLoginParam alloc] init];
    param.identifier = @"esports";
    param.userSig = @"eJxlj1FPgzAUhd-5FQ3PxrRAm9bEh4WxBMQYEDJ9It3aks4JTSnoZvzvKi6RxPP6ffeenA8PAOBX*eM13*-7sXONOxnpgxvgQ--qDxqjRcNdE1rxD8p3o61suHLSzhBhjAMIl44WsnNa6YshB9NbNyyEQbw0c8vvh*j7nFDE6FLR7QzvkzpOi-juEKNDLIIzYmM2yVJ0FavxhtuxUiLJ1oyVUq3P465cpW2yyU95gbFQCJHhjWdbVeDsqRzh80QJ36Z1eyT0*MAreLuodPpVXiZREgaURNGCTtIOuu9mIYAIoyCEP-G9T*8LAYVdeg__";
    NSString *groupId = @"@TGS#3ALXMALGH";
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        [manager login:param succ:^{
            dispatch_semaphore_signal(semaphore);
        } fail:^(int code, NSString *msg) {
            
        }];

        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        [[TIMGroupManager alloc] joinGroup:groupId msg:@"" succ:^{
            TIMConversation *grp_conversation = [[TIMManager sharedInstance] getConversation:TIM_GROUP receiver:groupId];
            self.conversation = grp_conversation;
            [grp_conversation getMessage:60 last:nil succ:^(NSArray *msgs) {
                NSArray* reversedArray = [[msgs reverseObjectEnumerator] allObjects];
                for (TIMMessage * msg in reversedArray) {
                    if ([msg isKindOfClass:[TIMMessage class]]) {
                        [self insertES_DialogModel:msg];
                    }
                }
            } fail:^(int code, NSString *msg) {
                NSLog(@"%@", msg);
            }];
        } fail:^(int code, NSString *msg) {
            if(code == 10013) {
                NSLog(@" [imim]  already joined");
                TIMConversation *grp_conversation = [[TIMManager sharedInstance] getConversation:TIM_GROUP receiver:groupId];
                self.conversation = grp_conversation;
                
                [grp_conversation getMessage:60 last:nil succ:^(NSArray * msgList) {
                    NSArray* reversedArray = [[msgList reverseObjectEnumerator] allObjects];
                    for (TIMMessage * msg in reversedArray) {
                        if ([msg isKindOfClass:[TIMMessage class]]) {
                            [self insertES_DialogModel:msg];
                        }
                    }
                }fail:^(int code, NSString * err) {
                    NSLog(@"Get Message Failed:%d->%@", code, err);
                }];

            }else {
                NSLog(@" [imim]  joinGroup error");
            }
        }];
    });
}

-(void)onNewMessage:(NSArray *)msgs{
    [self insertES_DialogModel:msgs.lastObject];
}

- (void)insertES_DialogModel: (TIMMessage *)model {
    
    int count = model.elemCount;

    for (int i = 0; i < count; i++) {
        TIMElem *elm = [model getElem:i];
        if(elm == nil) return;
        if(i==0){
            elm.senderName = @"企业助手";
        }else{
            elm.senderName = @"测试用户";
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:model.timestamp];
        elm.timeStr = dateStr;

        if([elm isKindOfClass:[TIMTextElem class]]) {
            
            [self.dialogArr addObject:elm];
            [self.tableView beginUpdates];
            NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.dialogArr.count-1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[lastPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            [self.tableView endUpdates];
            [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
        }
    }
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"es_im";
    PJ_IMTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PJ_IMTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = self.dialogArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dialogArr.count;
}

- (NSMutableArray *)dialogArr {
    if(_dialogArr == nil) {
        _dialogArr = [NSMutableArray array];
    }
    return _dialogArr;
}

- (void)keyboardWillAppear:(NSNotification *)note
{
    [_commentBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view).offset(-[[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    }];
}

- (void)keyboardWillDisappear:(NSNotification *)note
{
    _commentBottomView.textView.placeholder = @"有何意向？说来听听...";
    [_commentBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view);
    }];
    
}

// 隐藏软键盘
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    __weak __typeof(self)weakSelf = self;
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
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
