//
//  GoodsDetailsTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "GoodsDetailsTableViewController.h"
#import "CycleScrollView.h"
#import "PageIndicator.h"
#import "GoodsDetailsThreeTableViewCell.h"
#import "GoodsDetailsTwoTableViewCell.h"
#import "GoodsDetailsOneTableViewCell.h"
#import "MingHaoApiService.h"
#import "MyButton.h"
#import "ShoppingCarTableViewController.h"
#import "LatestOnlineGoods.h"
#import "User.h"
#import "UserLoginViewController.h"
@interface GoodsDetailsTableViewController ()<CycleScrollViewDelegate,UIScrollViewDelegate>{
    NSMutableArray *focusImageArray;
    NSMutableArray *focusImageArray2;
    int s;
    int y;
    
}

- (IBAction)addToShoppingCar:(id)sender;



- (IBAction)myShopCar:(id)sender;



@property (strong, nonatomic) IBOutlet UIScrollView *goodsDetailsImageScrollView;


@property (strong, nonatomic) IBOutlet CycleScrollView *cycleView;


@property (strong, nonatomic) IBOutlet PageIndicator *indiView;


- (IBAction)collectionBtnClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *goodsDetailsFooterView;


@property (strong, nonatomic) IBOutlet UIView *addCarView;


@property (strong, nonatomic) IBOutlet UIView *carView;

@end

@implementation GoodsDetailsTableViewController
@synthesize goodsDetails,goods,userMsg;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    [_goodsDetailsImageScrollView setScrollEnabled:YES];

    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    
    goodsDetails=[api showLatestOnlineGoodsMsg:goods.goodsID];

    NSLog(@"goodsde===%@",goodsDetails);
    focusImageArray=[[NSMutableArray alloc] init];

    LatestOnlineGoods *lolGoods;
    lolGoods=[goodsDetails objectAtIndex:0];
    //NSLog(@"lolgoods==%@",lolGoods.thumbPictures);
    for (Picture *picture in lolGoods.thumbPictures) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [focusImageArray addObject:picture.pictureURL];
            
        }
    }

    
    
    focusImageArray2=[[NSMutableArray alloc] init];
    for (Picture *picture in lolGoods.thumbPictures2) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [focusImageArray2 addObject:picture.pictureURL];
            
        }
    }
    NSLog(@"focusImageArray2=%@",focusImageArray2);


    
    self.indiView.currentPageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_active"];
    self.indiView.pageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_inactive"];
    self.indiView.sizeOfIndicator = CGSizeMake(8.0f, 12.0f);
    self.indiView.space=3.0f;
    
    
    //NSLog(@"ssd=%lu",(unsigned long)[focusImageArray count]);

    self.indiView.numberOfPages=[focusImageArray count];
    self.indiView.currentPage=0;
    [self.cycleView reload];
    
    
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    
    self.tableView.bounces=NO;
    
    //设置圆角
    _addCarView.layer.cornerRadius=3;
    _addCarView.layer.masksToBounds=YES;
    
    _carView.layer.cornerRadius=3;
    _carView.layer.masksToBounds=YES;
   
}




-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _goodsDetailsFooterView.layer.borderWidth=1.0;
    _goodsDetailsFooterView.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    
    return _goodsDetailsFooterView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    
    goodsDetails=[api showLatestOnlineGoodsMsg:goods.goodsID];

    
    [self.tableView reloadData];
    [super viewWillAppear:animated];

}



-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//多少页
-(NSInteger) numberOfPages:(CycleScrollView *) cycleScrollView{

    return [focusImageArray count];
    
}

- (UIView *) cycleScrollView:(CycleScrollView *) cycleScrollView viewForPage:(NSInteger)page reusingView:(UIView *) view{
    UIImageView *focusImageView;
    if (view) {
        focusImageView=(UIImageView *)view;
    }else{
        focusImageView=[[UIImageView alloc] init];
    }
    
    focusImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[focusImageArray objectAtIndex:page]]]];
    
    return focusImageView;
}

- (void) cycleScrollView:(CycleScrollView *) cycleScrollView scrollToPage:(NSInteger) page{
    
    self.indiView.currentPage=page;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2+[focusImageArray2 count];
}


//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([ indexPath indexAtPosition: 1 ] == 0){
        return 80.0;
    }else if([indexPath indexAtPosition:2]==1){
        return 180.0;
    }else if ([indexPath indexAtPosition:3]==2){
        return 110.0;
    
    }
    return 180.0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
        LatestOnlineGoods *lolGoods;
        lolGoods=[goodsDetails objectAtIndex:indexPath.row];
    
        GoodsDetailsOneTableViewCell *oneCell=(GoodsDetailsOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"goodsDetailsOneCell" forIndexPath:indexPath];

        if (![lolGoods.latestOnlineGoodsName isKindOfClass:[NSNull class]]) {
            oneCell.goodsName.text=lolGoods.latestOnlineGoodsName;
        }else{
            oneCell.goodsName.text=@"**";
        }
        
        

        if (![lolGoods.latestOnlineGoodsPrice isKindOfClass:[NSNull class]]) {
            oneCell.goodsPrice.text=lolGoods.latestOnlineGoodsPrice;
        }else{
            oneCell.goodsPrice.text=@"**";
        }
        

        
        if (![lolGoods.latestOnlineGoodsDiscountTime isKindOfClass:[NSNull class]]) {
            oneCell.goodsTime.text=lolGoods.latestOnlineGoodsDiscountTime;
        }else{
            oneCell.goodsTime.text=@"**";
        }
        
        oneCell.collectionBtn.imageView.image=[UIImage imageNamed:@"2015042702082798_easyicon_net_33.0217706821"];
        oneCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return oneCell;
    }else if(indexPath.row==1){
        LatestOnlineGoods *lolGoods;
        lolGoods=[goodsDetails objectAtIndex:indexPath.row-1];
        GoodsDetailsTwoTableViewCell *twoCell=(GoodsDetailsTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"goodsDetailsTwoCell" forIndexPath:indexPath];

        if (![lolGoods.latestOnlineGoodsBrand isKindOfClass:[NSNull class]]) {
            twoCell.goodsBrand.text=lolGoods.latestOnlineGoodsBrand;
        }else{
            twoCell.goodsBrand.text=@"**";
        }
        
        if (![lolGoods.latestOnlineGoodsName isKindOfClass:[NSNull class]]) {
            twoCell.goodsName.text=lolGoods.latestOnlineGoodsName;
        }else{
            twoCell.goodsName.text=@"**";
        }
        

        
        if (![lolGoods.latestOnlineGoodsPlace isKindOfClass:[NSNull class]]) {
            twoCell.goodsOrigin.text=lolGoods.latestOnlineGoodsPlace;
        }else{
            twoCell.goodsOrigin.text=@"**";
        }
        
        
        
        
        if (![lolGoods.latestOnlineGoodsStyle isKindOfClass:[NSNull class]]) {
            twoCell.goodsStyle.text=lolGoods.latestOnlineGoodsStyle;
        }else{
            twoCell.goodsStyle.text=@"**";
        }
        
        

        
        
        if (![lolGoods.latestOnlineGoodsID isKindOfClass:[NSNull class]]) {
            twoCell.goodsNo.text=lolGoods.latestOnlineGoodsID;
        }else{
            twoCell.goodsNo.text=@"**";
        }
        

        twoCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return twoCell;
    }else{
        GoodsDetailsThreeTableViewCell *threeCell=(GoodsDetailsThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"goodsDetailsThree" forIndexPath:indexPath];
        threeCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        for (int i=0;i<[focusImageArray2 count];i++) {
            NSString *s1=[focusImageArray2 objectAtIndex:i];
            NSLog(@"s=%@",s1);
            threeCell.goodsDetailsImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[focusImageArray2 objectAtIndex:indexPath.row-2]]]];
        }
        return threeCell;
    }
    return nil;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    s=self.tableView.frame.size.height;
    y=_goodsDetailsFooterView.frame.size.height;
    _goodsDetailsFooterView.frame=CGRectMake(_goodsDetailsFooterView.frame.origin.x, s+self.tableView.contentOffset.y-y, _goodsDetailsFooterView.frame.size.width, _goodsDetailsFooterView.frame.size.height);
    
}


- (IBAction)addToShoppingCar:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        //做加入购物车操作
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        userMsg=[api login:[User getCurrentUser]];
        goodsDetails=[api showLatestOnlineGoodsMsg:goods.goodsID];
        
        User *user;
        user=[userMsg objectAtIndex:0];
        LatestOnlineGoods *lolGoods;
        lolGoods=[goodsDetails objectAtIndex:0];
        NSString *goodsId=lolGoods.latestOnlineGoodsID;
        NSString *userId=user.userId;
        
        if ([api addLatestOnlineGoodsToShoppingCar:userId withGoodsId:goodsId]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"加入购物车成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"购物车已有该商品" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }
        
        NSLog(@"即将做加入购物车操作。。。");
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];
    }
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *string=[alertView buttonTitleAtIndex:buttonIndex];
    if ([string isEqualToString:@"确定"]){
        //返回根视图
        ShoppingCarTableViewController *sctvc=[self.storyboard instantiateViewControllerWithIdentifier:@"shopCarTVC"];
        [self.navigationController pushViewController:sctvc animated:YES];

    }
}

- (IBAction)myShopCar:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        ShoppingCarTableViewController *sctvc=[self.storyboard instantiateViewControllerWithIdentifier:@"shopCarTVC"];
        [self.navigationController pushViewController:sctvc animated:YES];

    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];

    
    }

        
}


- (IBAction)collectionBtnClick:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        if ([api addLatestOnlineGoodsCollection:[User getUserID] withGoodsId:goods.goodsID]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"加入收藏成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏夹已有该商品" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }
        
        NSLog(@"即将做加入收藏操作。。。");
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];
    }

}



@end
