//
//  PJ_UserTableViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_UserTableViewController.h"

#import "PJ_UserHeaderView.h"
#import "PJ_AllTableViewCell.h"
#import "PJ_UserLoginViewController.h"
#import "PJ_UserEditViewController.h"
#import "PJ_AllDetailViewController.h"
#import "PJ_ApproveViewController.h"

@interface PJ_UserTableViewController ()

@property(nonatomic,strong) NSArray *pj_applyArray;
@property(nonatomic,strong) PJ_UserHeaderView *header;

@end

@implementation PJ_UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    _header = [[PJ_UserHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, STANDAED_SIZE(320))];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    _header.userInteractionEnabled = YES;
    [_header addGestureRecognizer:tap];
    self.tableView.tableHeaderView = _header;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)requestData{
     [[PJ_NetHelper instance] requestJobListWithType:7 Page:1 Success:^(NSArray * _Nonnull result) {
         self->_pj_applyArray = result;
        [self.tableView reloadData];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_header refresh];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    if (phone) {
        [self requestData];
    }
}

-(void)tap{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    if (!phone) {
        PJ_UserLoginViewController *login = [[PJ_UserLoginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }else{
        PJ_UserEditViewController *edit = [[PJ_UserEditViewController alloc]init];
        edit.type = 1;
        edit.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:edit animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _pj_applyArray.count;
    }
    return 1;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *secLabel = [[UILabel alloc]init];
    secLabel.textColor = [UIColor colorWithHexString:@"#fc4434"];
    switch (section) {
        case 0:
            secLabel.text = @"  · 个人资料";
            break;
        case 1:
            secLabel.text = @"  · 企业认证";
            break;
        case 2:
            secLabel.text = @"  · 职位申请";
            break;
        default:
            break;
    }
    
    return secLabel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return STANDAED_SIZE(90);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0||indexPath.section==1){
        static NSString *cellId = @"company";
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = LabelFont(28);
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        if (indexPath.section==0) {
            cell.textLabel.text = @"完善资料提高职位匹配度";
        }else{
            cell.textLabel.text = @"认证成功后可分布职位";
        }
        
        return cell;
    }else{
        static NSString *cellId = @"apply";
        PJ_AllTableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PJ_AllTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        AVObject *object = _pj_applyArray[indexPath.row];
        [cell setTableCellWithData:object];
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        return STANDAED_SIZE(200);
    }
    return STANDAED_SIZE(90);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phone = [defaults objectForKey:@"PJ_USER_PHPNE"];
    if (!phone) {
        PJ_UserLoginViewController *login = [[PJ_UserLoginViewController alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }else{
        if (indexPath.section==0) {
            PJ_UserEditViewController *edit = [[PJ_UserEditViewController alloc]init];
            edit.type = 1;
            edit.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:edit animated:YES];
        }else if (indexPath.section==1) {
            PJ_ApproveViewController *approve = [[PJ_ApproveViewController alloc]init];
            approve.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:approve animated:YES];
        }else{
            PJ_AllDetailViewController *detailVC = [[PJ_AllDetailViewController alloc]init];
            detailVC.object = _pj_applyArray[indexPath.row];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
