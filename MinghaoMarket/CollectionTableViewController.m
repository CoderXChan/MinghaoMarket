//
//  CollectionTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "MingHaoApiService.h"
#import "MyCollectionTableViewCell.h"
#import "ShoppingCarGoods.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface CollectionTableViewController (){
    NSString *tempSCGoodsID;

}

@end

@implementation CollectionTableViewController
@synthesize currentUserAllCollectionGoods;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"收藏夹";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    //self.tableView.tableFooterView=[[UIView alloc]init];
    
    
    self.tableView.bounces=NO;
    
    
    
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        currentUserAllCollectionGoods=[api queryCollection:[User getUserID]];
    }

}


-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
    
    
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [currentUserAllCollectionGoods count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"collectioncell";
    MyCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"collectioncell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    Goods *scGoods=[currentUserAllCollectionGoods objectAtIndex:indexPath.row];
    if (![scGoods.goodsName isKindOfClass:[NSNull class]]) {
        cell.collectionName.text=scGoods.goodsName;
    }else{
        cell.collectionName.text=@"null";
    }
    
    if (![scGoods.goodsDesc isKindOfClass:[NSNull class]]) {
        cell.collectionDesc.text=scGoods.goodsDesc;
    }else{
        cell.collectionDesc.text=@"null";
    }
    
    if (![scGoods.goodsPrice isKindOfClass:[NSNull class]]) {
        cell.collectionPrice.text=scGoods.goodsPrice;
        
    }else{
        cell.collectionPrice.text=@"null";
    }
    
    
    
    for (Picture  *picture in scGoods.thumbPictures) {
        [cell.collectionImages sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            cell.collectionImages.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            cell.collectionImages.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }
    
    cell.collectionBtn.goods=scGoods;
    [cell.collectionBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];

    
    
    cell.collectionDeleteBtn.goods=scGoods;
    [cell.collectionDeleteBtn addTarget:self action:@selector(deleteGoodsFromCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    //scGoods.shoppingCarGoodsNum=@"1";
    //cell.shoppingCarGoodsNum.text=scGoods.shoppingCarGoodsNum;
    
    return cell;

}



-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"商品详情");
    
    GoodsDetailsTableViewController *myBtn=[[self storyboard] instantiateViewControllerWithIdentifier:@"goodsDetailsTVC"];
    
    Goods *good=[[Goods alloc] init];
    
    myBtn.goods=btn.goods;
    good.goodsID=btn.goods.goodsID;
    
    
    NSLog(@"latestgoodsid=%@",btn.goods.goodsID);
    NSLog(@"latestgoodsid222=%@",good.goodsID);
    
    LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
    [logService showLatestOnlineGoodsMsg:good.goodsID];
    
    
    [self.navigationController pushViewController:myBtn animated:YES];
    
}


-(void)deleteGoodsFromCollection:(MyButton *)btn{
    Goods *good=[[Goods alloc] init];
    good.goodsID=btn.goods.goodsID;
    tempSCGoodsID=good.goodsID;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"是否删除收藏夹中该商品?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert  show];
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (0==buttonIndex){
        return;
    }else{
        //做删除收藏夹商品操作
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        if ([api deleteCollectionGoods:[User getUserID] withGoodsId:tempSCGoodsID]) {
            NSLog(@"%@的%@商品被删除了",[User getUserID],tempSCGoodsID);
        }
    }
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    
    currentUserAllCollectionGoods=[api queryCollection:[User getUserID]];
    
    [self.tableView reloadData];
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
