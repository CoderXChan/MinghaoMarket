//
//  FlashGoodsTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/8.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "FlashGoodsTableViewController.h"
#import "MingHaoApiService.h"
#import "FlashGoodsTableViewCell.h"
#import "Picture.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
@interface FlashGoodsTableViewController ()

@end

@implementation FlashGoodsTableViewController
@synthesize fgoods,goodsArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    
    goodsArray=[api showFlashGoods:fgoods.flashGoodsID];
    
    NSLog(@"flashgoodsarray===%@",goodsArray);
    
    
    
    
    
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;

    NSLog(@"flashgoodid================%@",fgoods.flashGoodsID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [goodsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Goods *goods;
    goods=[goodsArray objectAtIndex:indexPath.row];
    FlashGoodsTableViewCell *flashCell=(FlashGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"flashGoodscell" forIndexPath:indexPath];

    if (![goods.goodsName isKindOfClass:[NSNull class]]) {
        flashCell.flashGoodsTitle.text=goods.goodsName;
    }else{
        flashCell.flashGoodsTitle.text=@"null";
    }
    
    
    if (![goods.goodsPrice isKindOfClass:[NSNull class]]) {
        flashCell.flashGoodsPrice.text=goods.goodsPrice;
    }else{
        flashCell.flashGoodsPrice.text=@"null";
    }
    
    if (![goods.goodsDiscount isKindOfClass:[NSNull class]]) {
        flashCell.flashGoodsDiscount.text=goods.goodsDiscount;
    }else{
        flashCell.flashGoodsDiscount.text=@"null";
    }
    
    if (![goods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
        flashCell.flashGoodsBuyer.text=goods.goodsDiscountTime;
    }else{
        flashCell.flashGoodsBuyer.text=@"null";
    }
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15]};

    
    flashCell.flashGoodsTitle.attributedText=[[NSAttributedString alloc]initWithString: flashCell.flashGoodsTitle.text attributes:attributes];
    
    
    
    /*
    for (Picture *picture in  goods.thumbPictures) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            flashCell.flashGoodsImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
        }else{
            flashCell.flashGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        }
    }*/
    
    
    Picture *picture=goods.thumbPicture;
    if (picture) {
        if (picture.pictureURL) {
            flashCell.flashGoodsImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
            
        }else{
            flashCell.flashGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        }
    }

    
    
    //自定义按钮传值
    flashCell.flashGoodsBtn.goods=goods;
    [flashCell.flashGoodsBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return flashCell;
}


-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"商品列表");
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
