//
//  MenuFifthTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/16.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuFifthTableViewController.h"
#import "MenuFifthTableViewCell.h"
#import "MenuGoodsListCollectionViewController.h"
#import "MenuGoods.h"
#import "MingHaoApiService.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface MenuFifthTableViewController ()


@property (strong, nonatomic) IBOutlet UIImageView *headerImage;



@end

@implementation MenuFifthTableViewController
@synthesize menuBeautyGoods,menuBeautyImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title=@"旅游";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    NSString *idType=@"5";
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
    static NSString *CellIdentifier = @"menuFifthCell";
    MenuFifthTableViewCell *mFifthcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (mFifthcell==nil) {
        
        mFifthcell=[[MenuFifthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];

    
    
    
    
    
    
    
    /*
    MenuFifthTableViewCell *mFifthcell = [tableView dequeueReusableCellWithIdentifier:@"menuFifthCell" forIndexPath:indexPath];
    if (mFifthcell==nil) {
        mFifthcell=[[[NSBundle mainBundle]loadNibNamed:@"menuFifthCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        mFifthcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    */
    
    
    
    //mfcell.menuFirstImage.image=[UIImage imageNamed:@"beauty2"];
    for (Picture *picture in  menuGoods.thumbPictures) {
        [mFifthcell.menuFifthImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
        
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            mFifthcell.menuFifthImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            mFifthcell.menuFifthImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }
    
    
    if (![menuGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
        mFifthcell.menuFifthDiscount.text=menuGoods.goodsDiscount;
    }else{
        mFifthcell.menuFifthDiscount.text=@"null";
    }
    
    
    if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
        mFifthcell.menuFifthTitle.text=menuGoods.goodsName;
    }else{
        mFifthcell.menuFifthTitle.text=@"null";
    }
    
    
    
    mFifthcell.menuFifthBtn.goods=menuGoods;
    [mFifthcell.menuFifthBtn addTarget:self action:@selector(showMenuGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    

    
    /*
    mFifthcell.menuFifthImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuGoodsListCollection:)];
    [mFifthcell.menuFifthImage addGestureRecognizer:singleTap];
    */
    return mFifthcell;
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


@end
