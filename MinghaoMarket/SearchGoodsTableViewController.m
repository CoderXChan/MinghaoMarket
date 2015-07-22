//
//  SearchGoodsTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/8.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "SearchGoodsTableViewController.h"
#import "SearchGoodsTableViewCell.h"
#import "LatestOnlineGoodsMsgService.h"
#import "MingHaoApiService.h"
#import "GoodsDetailsTableViewController.h"
#import "Store.h"
#import "GoodsListCollectionViewController.h"
#import "StarShopGoodsService.h"
static int tempInt;
@interface SearchGoodsTableViewController (){
    int tempInt;
}


@property (strong, nonatomic) IBOutlet UITextField *searchTitle;



//搜商品
- (IBAction)searchBtnClick:(id)sender;


//搜店铺
- (IBAction)searchShopsBtnClick:(id)sender;


- (IBAction)closeKBClick:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *searchGoodsView;


@property (strong, nonatomic) IBOutlet UIView *searchShopsView;



@end

@implementation SearchGoodsTableViewController
@synthesize searchGoodsArray,searchShopsArray;

+(void)setTempInt:(int)num{
    tempInt = num;
    
}

+(int)getTempInt{
    return tempInt;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    
    //设置圆角
    _searchGoodsView.layer.cornerRadius=3;
    _searchGoodsView.layer.masksToBounds=YES;
    
    _searchShopsView.layer.cornerRadius=3;
    _searchShopsView.layer.masksToBounds=YES;
    
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
    if ([SearchGoodsTableViewController getTempInt]==1) {
        NSLog(@"sgoods=%lu",(unsigned long)[searchGoodsArray count]);
        return [searchGoodsArray count];
    }else if([SearchGoodsTableViewController getTempInt]==2){
        NSLog(@"sshops=%lu",(unsigned long)[searchShopsArray count]);
        return [searchShopsArray count];
    }
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([SearchGoodsTableViewController getTempInt]==1) {
        Goods *goods;
        goods=[searchGoodsArray objectAtIndex:indexPath.row];
        SearchGoodsTableViewCell *scell=(SearchGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"searchGoodsCell" forIndexPath:indexPath];
        if (![goods.goodsName isKindOfClass:[NSNull class]]) {
            scell.searchName.text=goods.goodsName;
        }else{
            scell.searchName.text=@"null";
        }
        
        
        if (![goods.goodsDesc isKindOfClass:[NSNull class]]) {
            scell.searchDesc.text=goods.goodsDesc;
        }else{
            scell.searchDesc.text=@"null";
        }
        
        
        
        Picture *picture=goods.thumbPicture;
        if (picture) {
            if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
                scell.searchImgae.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
            }else{
                scell.searchImgae.image=[UIImage imageNamed:@"wemall_picture_default"];
                
            }
        }
        
        
        scell.searchGoodsBtn.goods=goods;
        [scell.searchGoodsBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return scell;

    }else if([SearchGoodsTableViewController getTempInt]==2){
        Goods *good;
        good=[searchShopsArray objectAtIndex:indexPath.row];
        SearchGoodsTableViewCell *scell=(SearchGoodsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"searchGoodsCell" forIndexPath:indexPath];
        if (![good.goodsName isKindOfClass:[NSNull class]]) {
            scell.searchName.text=good.goodsName;
        }else{
            scell.searchName.text=@"null";
        }
        
        
        if (![good.goodsDesc isKindOfClass:[NSNull class]]) {
            scell.searchDesc.text=good.goodsDesc;
        }else{
            scell.searchDesc.text=@"null";
        }
        
        
        
        Picture *picture=good.thumbPicture;
        if (picture) {
            if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
                scell.searchImgae.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
            }else{
                scell.searchImgae.image=[UIImage imageNamed:@"wemall_picture_default"];
                
            }
        }
        
        
        scell.searchGoodsBtn.starGoods=good;
        [scell.searchGoodsBtn addTarget:self action:@selector(showGoodsListCollection1:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return scell;

    
    }
    return nil;
    
    
}


-(void)showGoodsListCollection1:(MyButton *)btn{
    NSLog(@"店铺商品列表");
    
    GoodsListCollectionViewController *g = [self.storyboard instantiateViewControllerWithIdentifier:@"glcvc"];
    
    
    
    Goods *good=[[Goods alloc] init];
    g.goods=btn.starGoods;
    good.starShopId=btn.starGoods.starShopId;
    
    NSLog(@"good.starShopId=%@",good.starShopId);
    NSLog(@"btn.goods.starShopId=%@",btn.starGoods.starShopId);
    
    //调查看明星店铺商品接口（传店铺id）
    StarShopGoodsService *starService=[[StarShopGoodsService alloc] init];
    NSLog(@"gg==%@",good.starShopId);
    [starService showStarShopGoods:good.starShopId];
    
    
    [self.navigationController  pushViewController:g animated:YES];
    
    
}


#pragma mark - 搜索店铺详情
-(void)showGoodsListCollection:(MyButton *)btn{
    
    GoodsDetailsTableViewController *myBtn=[[self storyboard] instantiateViewControllerWithIdentifier:@"goodsDetailsTVC"];
    
    Goods *good=[[Goods alloc] init];
    
    myBtn.goods=btn.goods;
    good.goodsID=btn.goods.goodsID;
    
    LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
    [logService showLatestOnlineGoodsMsg:good.goodsID];
    
    
    [self.navigationController pushViewController:myBtn animated:YES];
    
}



#pragma mark - 搜索商品弹出的界面

- (IBAction)searchBtnClick:(id)sender {
    if (![_searchTitle.text isEqualToString:@""]) {
        //tempInt=1;
        [SearchGoodsTableViewController setTempInt:1];
        
        NSString *searchString=_searchTitle.text;
        NSLog(@"sss=%@",searchString);
        
        LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
        [logService searchGoods:searchString];
        
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        searchGoodsArray = [api showSearchGoods:_searchTitle.text];
        
        NSLog(@"searchgoodsArray===%@",searchGoodsArray);
        
        [self.tableView reloadData];
    }else{
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入要搜索商品的关键字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
    
    }
    
    
}
#pragma mark - 搜索店铺弹出的界面

- (IBAction)searchShopsBtnClick:(id)sender {
    
    if (![_searchTitle.text isEqualToString:@""]) {
        //tempInt=2;
        
        [SearchGoodsTableViewController setTempInt:2];
        
        NSString *searchString=_searchTitle.text;
        NSLog(@"sss=%@",searchString);
        
        LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
        [logService searchShops:searchString];
        
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        searchShopsArray=[api showSearchShops:_searchTitle.text];
        
        NSLog(@"searchshopsArray===%@",searchShopsArray);
        
        [self.tableView reloadData];
    }else{
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入要搜索店铺的关键字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        
    }

    
    
}

- (IBAction)closeKBClick:(id)sender {
    [_searchTitle resignFirstResponder];
    
    
}
@end
