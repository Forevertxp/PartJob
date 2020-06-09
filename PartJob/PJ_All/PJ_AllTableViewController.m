//
//  PJAllTableViewController.m
//  PartJob
//
//  Created by 田晓鹏 on 2020/6/2.
//  Copyright © 2020 esports. All rights reserved.
//

#import "PJ_AllTableViewController.h"

#import "PJ_AllHeaderView.h"
#import "PJ_AllTableViewCell.h"
#import "PJ_AllDetailViewController.h"

#import <MJRefresh/MJRefresh.h>

@interface PJ_AllTableViewController ()<PJ_AllHeaderViewDelegate>

@property (nonatomic,strong) NSMutableArray *pj_dataArray;

@property (nonatomic) NSInteger category;
@property (nonatomic) NSInteger currentPage;

@property (nonatomic,strong) PJ_AllHeaderView *header;

@end

@implementation PJ_AllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"兼职";
    
    _pj_dataArray = [NSMutableArray arrayWithCapacity:0];
    
    _header = [[PJ_AllHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, STANDAED_SIZE(380))];
    _header.delegate = self;
    https://github.com/Forevertxp/PartJob.git
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.category = 0;
        self.currentPage = 1;
        [self requestData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self requestData];
    }];
}

-(void)requestData{
     [[PJ_NetHelper instance] requestJobListWithType:self.category Page:self.currentPage Success:^(NSArray * _Nonnull result) {
         
         if (self.currentPage==1) {
             [self->_pj_dataArray removeAllObjects];
         }
         [self->_pj_dataArray addObjectsFromArray: result];
         
         if (self->_pj_dataArray.count>0) {
             self.tableView.tableHeaderView = self->_header;
         }
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
         [self.tableView reloadData];
    }];
}

#pragma mark headerview
-(void)didClickView:(NSInteger)position{
    self.category = position;
    self.currentPage = 1;
    [self requestData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pj_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"all";
    PJ_AllTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PJ_AllTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    AVObject *object = _pj_dataArray[indexPath.row];
    [cell setTableCellWithData:object];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STANDAED_SIZE(220);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PJ_AllDetailViewController *detailVC = [[PJ_AllDetailViewController alloc]init];
    detailVC.object = _pj_dataArray[indexPath.row];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
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
