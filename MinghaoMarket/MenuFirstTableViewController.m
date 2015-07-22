//
//  MenuFirstTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/13.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuFirstTableViewController.h"
#import "MenuFirstTableViewCell.h"
#import "MingHaoApiService.h"
#import "MingHaoHomePageViewController.h"
#import "MenuFirstTableViewController.h"
#import "MenuGoodsListCollectionViewController.h"
#import "Picture.h"
#import "MenuGoods.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "MyButton.h"
#import "UIImageView+WebCache.h"
@interface MenuFirstTableViewController (){
    UIColor *testColor1;
}


@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


@end

@implementation MenuFirstTableViewController
@synthesize menuBeautyGoods,menuBeautyImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"美妆";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
    
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    NSString *idType=@"1";
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    menuBeautyGoods=[api showMenuGoods:idType];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuBeautyGoods count];
}


//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"menuFirstCell";
    MenuFirstTableViewCell *mfcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (mfcell==nil) {
        
        mfcell=[[MenuFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];

    

    /*
    MenuFirstTableViewCell *mfcell = [tableView dequeueReusableCellWithIdentifier:@"menuFirstCell" forIndexPath:indexPath];
    if (mfcell==nil) {
        mfcell=[[[NSBundle mainBundle]loadNibNamed:@"menuFirstCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        mfcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    */
    
    
    for (Picture *picture in  menuGoods.thumbPictures) {
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            mfcell.menuFirstImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            mfcell.menuFirstImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
        
        //   用SD来加载
        [mfcell.menuFirstImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
    }
    
    if (![menuGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
        mfcell.menuFirstDiscount.text=menuGoods.goodsDiscount;
    }else{
        mfcell.menuFirstDiscount.text=@" ";
    }
    
    
    if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
        mfcell.menuFirstTitle.text=menuGoods.goodsName;
    }else{
        mfcell.menuFirstTitle.text=@" ";
    }
    
    
    if (![menuGoods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
        mfcell.menuFirstRestTime.text=menuGoods.goodsDiscountTime;
    }else{
        mfcell.menuFirstRestTime.text=@" ";
    }
    
    
    
    mfcell.menuFirstBtn.goods=menuGoods;
    [mfcell.menuFirstBtn addTarget:self action:@selector(showMenuGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    return mfcell;
}

#pragma mark - 商品详情
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


@end
