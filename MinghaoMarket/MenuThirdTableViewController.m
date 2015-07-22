//
//  MenuThirdTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuThirdTableViewController.h"
#import "MenuThirdTableViewCell.h"
#import "MenuGoodsListCollectionViewController.h"
#import "MingHaoApiService.h"
#import "MenuGoods.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface MenuThirdTableViewController (){
    UIColor *testColor;
}


@property (strong, nonatomic) IBOutlet UIImageView *headerImage;




@end

@implementation MenuThirdTableViewController
@synthesize menuBeautyGoods,menuBeautyImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title=@"居家";
    testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *idType=@"3";
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
    static NSString *CellIdentifier = @"menuThirdCell";
    MenuThirdTableViewCell *mtcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (mtcell==nil) {
        
        mtcell=[[MenuThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    
    /*
    MenuThirdTableViewCell *mtcell = [tableView dequeueReusableCellWithIdentifier:@"menuThirdCell" forIndexPath:indexPath];
    if (mtcell==nil) {
        mtcell=[[[NSBundle mainBundle]loadNibNamed:@"menuThirdCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        mtcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    */
    
    
    
    //mfcell.menuFirstImage.image=[UIImage imageNamed:@"beauty2"];
    for (Picture *picture in  menuGoods.thumbPictures) {
        
        [mtcell.menuThirdImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
        
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            mtcell.menuThirdImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            mtcell.menuThirdImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }
    
    
    if (![menuGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
        mtcell.menuThirdDiscount.text=menuGoods.goodsDiscount;
    }else{
        mtcell.menuThirdDiscount.text=@"null";
    }
    
    
    if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
        mtcell.menuThirdTitle.text=menuGoods.goodsName;
    }else{
        mtcell.menuThirdTitle.text=@"null";
    }
    
    
    if (![menuGoods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
        mtcell.menuThirdRestTime.text=menuGoods.goodsDiscountTime;
    }else{
        mtcell.menuThirdRestTime.text=@"null";
    }
    
    
    mtcell.menuThirdBtn.goods=menuGoods;
    [mtcell.menuThirdBtn addTarget:self action:@selector(showMenuGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
    mtcell.menuThirdImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuGoodsListCollection:)];
    [mtcell.menuThirdImage addGestureRecognizer:singleTap];
    */
    return mtcell;
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
