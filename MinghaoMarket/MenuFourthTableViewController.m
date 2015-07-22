//
//  MenuFourthTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/16.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuFourthTableViewController.h"
#import "MenuFourthTableViewCell.h"
#import "MenuGoodsListCollectionViewController.h"
#import "MingHaoApiService.h"
#import "MenuGoods.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface MenuFourthTableViewController (){
    UIColor *testColor1;
}


@property (strong, nonatomic) IBOutlet UIImageView *headerImage;



@end

@implementation MenuFourthTableViewController
@synthesize menuBeautyGoods,menuBeautyImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title=@"汽车";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
    
    /*
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的发布" style:UIBarButtonItemStylePlain target:self action:@selector(OnRightButton:)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;*/
}


-(void)viewWillAppear:(BOOL)animated{
    NSString *idType=@"4";
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    menuBeautyGoods=[api showMenuGoods:idType];
    NSLog(@"menuBeautyGoods%@",menuBeautyGoods);
    
    menuBeautyImage=[api showMenuHeaderImage:idType];
    Goods *goods=[menuBeautyImage objectAtIndex:0];
    Picture *picture=goods.thumbPicture;
    if (picture) {
        [_headerImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
//        if (picture.pictureURL) {
//            _headerImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//            
//        }else{
//            _headerImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }
    
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


-(void)OnRightButton:(id)sender{
    
    //MyStoreViewController *msvc=[self.storyboard instantiateViewControllerWithIdentifier:@"mystoreVC"];
    //[self.navigationController  pushViewController:msvc animated:YES];
    
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
    NSLog(@"menugoodscount==%lu",(unsigned long)[menuBeautyGoods count]);
    return [menuBeautyGoods count];
}

//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"menuFourthCell";
    MenuFourthTableViewCell *mfcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (mfcell==nil) {
        
        mfcell=[[MenuFourthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    
    
    
    
    
    
    /*
    MenuFourthTableViewCell *mfcell = [tableView dequeueReusableCellWithIdentifier:@"menuFourthCell" forIndexPath:indexPath];
    if (mfcell==nil) {
        mfcell=[[[NSBundle mainBundle]loadNibNamed:@"menuFourthCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        mfcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    
    
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    */
    
    
    
    //mfcell.menuFirstImage.image=[UIImage imageNamed:@"beauty2"];
    for (Picture *picture in  menuGoods.thumbPictures) {
        [mfcell.menuFourthImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            mfcell.menuFourthImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            mfcell.menuFourthImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }
    
    
    if (![menuGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
        mfcell.menuFourthDiscount.text=menuGoods.goodsDiscount;
    }else{
        mfcell.menuFourthDiscount.text=@"null";
    }
    
    
    if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
        mfcell.menuFourthTitle.text=menuGoods.goodsName;
    }else{
        mfcell.menuFourthTitle.text=@"null";
    }
    
    
    if (![menuGoods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
        mfcell.menuFouthRestTime.text=menuGoods.goodsDiscountTime;
    }else{
        mfcell.menuFouthRestTime.text=@"null";
    }
    

    
    mfcell.menuFourthBtn.goods=menuGoods;
    [mfcell.menuFourthBtn addTarget:self action:@selector(showMenuGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    

    return mfcell;
}


-(void)showMenuGoodsListCollection:(MyButton *)btn{
    NSLog(@"商品详情");
    GoodsDetailsTableViewController *myBtn=[[self storyboard] instantiateViewControllerWithIdentifier:@"goodsDetailsTVC"];
    
    Goods *mgood=[[Goods alloc] init];
    
    myBtn.goods=btn.goods;
    mgood.goodsID=btn.goods.goodsID;
    
    
    NSLog(@"menubeautygoodsid=%@",btn.goods.goodsID);
    NSLog(@"menubeautygoodsid222=%@",mgood.goodsID);
    
    LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
    [logService showLatestOnlineGoodsMsg:mgood.goodsID];
    
    
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
