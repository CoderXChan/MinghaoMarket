//
//  MenuSecondTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuSecondTableViewController.h"
#import "MenuSecondTableViewCell.h"
#import "MenuGoodsListCollectionViewController.h"
#import "MingHaoApiService.h"
#import "MenuGoods.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface MenuSecondTableViewController (){
    UIColor *testColor1;
}



@property (strong, nonatomic) IBOutlet UIImageView *headerImage;



@end

@implementation MenuSecondTableViewController
@synthesize menuBeautyGoods,menuBeautyImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title=@"服饰";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    NSString *idType=@"2";
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    menuBeautyGoods=[api showMenuGoods:idType];
    NSLog(@"menuBeautyGoods%@",menuBeautyGoods);
    
    
    menuBeautyImage=[api showMenuHeaderImage:idType];
    Goods *goods=[menuBeautyImage objectAtIndex:0];
    Picture *picture=goods.thumbPicture;
    if (picture) {
        //  也是SD加载
        NSURL *url = [NSURL URLWithString:picture.pictureURL];
        [_headerImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
        
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

#pragma mark - cell  方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"menuSecondCell";
    MenuSecondTableViewCell *mscell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (mscell==nil) {
        
        mscell=[[MenuSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];
    
    
    
    
    /*
    MenuSecondTableViewCell *mscell = [tableView dequeueReusableCellWithIdentifier:@"menuSecondCell" forIndexPath:indexPath];
    if (mscell==nil) {
        mscell=[[[NSBundle mainBundle]loadNibNamed:@"menuSecondCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        mscell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    Goods *menuGoods=[menuBeautyGoods objectAtIndex:indexPath.row];*/
    
    
    for (Picture *picture in menuGoods.thumbPictures) {
        [mscell.menuSecondImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
        
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            mscell.menuSecondImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            mscell.menuSecondImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }
    
    
    if (![menuGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
        mscell.menuSecondDiscount.text=menuGoods.goodsDiscount;
    }else{
        mscell.menuSecondDiscount.text=@" ";
    }
    
    
    if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
        mscell.menuSecondTitle.text=menuGoods.goodsName;
    }else{
        mscell.menuSecondTitle.text=@" ";
    }
    
    
    if (![menuGoods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
        mscell.menuSecondRestTime.text=menuGoods.goodsDiscountTime;
    }else{
        mscell.menuSecondRestTime.text=@" ";
    }
    
    
    mscell.menuSecondBtn.goods=menuGoods;
    [mscell.menuSecondBtn addTarget:self action:@selector(showMenuGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    

    /*
    mscell.menuSecondImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuGoodsListCollection:)];
    [mscell.menuSecondImage addGestureRecognizer:singleTap];
    */
    return mscell;
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
