//
//  StarGoodsDetailsTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/3.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "StarGoodsDetailsTableViewController.h"
#import "CycleScrollView.h"
#import "PageIndicator.h"
#import "StarGoodsDetailsOneTableViewCell.h"
#import "StarGoodsDetailsTwoTableViewCell.h"
#import "StarGoodsDetailsThreeTableViewCell.h"
#import "MingHaoApiService.h"
#import "StarShopGoods.h"
#import "UserLoginViewController.h"
#import "ShoppingCarTableViewController.h"
@interface StarGoodsDetailsTableViewController ()<CycleScrollViewDelegate,UIScrollViewDelegate>{
    NSMutableArray *focusImageArray;
    NSMutableArray *focusImageArray2;
    int s;
    int y;


}


- (IBAction)addToShopCar:(id)sender;

- (IBAction)myShopCar:(id)sender;



- (IBAction)collectionBtnClick:(id)sender;



@property (strong, nonatomic) IBOutlet UIScrollView *starGoodsDetailsScrollview;


@property (strong, nonatomic) IBOutlet CycleScrollView *cycleView;


@property (strong, nonatomic) IBOutlet PageIndicator *pageIndicator;


@property (strong, nonatomic) IBOutlet UIView *starGoodsDetailsFooterView;


@property (strong, nonatomic) IBOutlet UIView *addCarView;


@property (strong, nonatomic) IBOutlet UIView *carView;




@end

@implementation StarGoodsDetailsTableViewController
@synthesize starGoodsDetails,starGoods,userMsg;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_starGoodsDetailsScrollview setScrollEnabled:YES];
    
    
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    starGoodsDetails=[api showStarShopGoodsMsg:starGoods.starShopGoodsId];
    
    
    focusImageArray=[[NSMutableArray alloc] init];
    StarShopGoods *staGoods;
    staGoods=[starGoodsDetails objectAtIndex:0];
    for (Picture *picture in staGoods.starShopGoodsImage){
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            [focusImageArray addObject:picture.pictureURL];
        }
    }
    
    focusImageArray2=[[NSMutableArray alloc] init];
    for (Picture *picture in staGoods.thumbPicture2) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [focusImageArray2 addObject:picture.pictureURL];
            
        }
    }

    
    
    self.pageIndicator.currentPageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_active"];
    self.pageIndicator.pageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_inactive"];
    self.pageIndicator.sizeOfIndicator = CGSizeMake(8.0f, 12.0f);
    self.pageIndicator.space=3.0f;
    
    
    
    self.pageIndicator.numberOfPages=[focusImageArray count];
    self.pageIndicator.currentPage=0;
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
    _starGoodsDetailsFooterView.layer.borderWidth=1.0;
    _starGoodsDetailsFooterView.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    
    return _starGoodsDetailsFooterView;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
    
}



-(void)viewWillAppear:(BOOL)animated{
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    starGoodsDetails=[api showStarShopGoodsMsg:starGoods.starShopGoodsId];
    
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
    
    self.pageIndicator.currentPage=page;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2+[focusImageArray2 count];;
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
        StarShopGoods *sGoods;
        sGoods=[starGoodsDetails objectAtIndex:indexPath.row];
        StarGoodsDetailsOneTableViewCell *oneCell=(StarGoodsDetailsOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"starOneCell" forIndexPath:indexPath];
        
        if (![sGoods.starShopGoodsName isKindOfClass:[NSNull class]]) {
            oneCell.starGoodsName.text=sGoods.starShopGoodsName;
        }else{
            oneCell.starGoodsName.text=@"null";
        }
        
        
        if(![sGoods.starShopGoodsPrice isKindOfClass:[NSNull class]]){
            oneCell.starGoodsPrice.text=sGoods.starShopGoodsPrice;
        }else{
            oneCell.starGoodsPrice.text=@"null";
        }
        
        if (![sGoods.starShopGoodsDiscountTime isKindOfClass:[NSNull class]]) {
            oneCell.starGoodsDicountTime.text=sGoods.starShopGoodsDiscountTime;
        }else{
            oneCell.starGoodsDicountTime.text=@"null";
        }
        
        oneCell.collectionBtn.imageView.image=[UIImage imageNamed:@"2015042702082798_easyicon_net_33.0217706821"];
        oneCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return oneCell;
    }else if(indexPath.row==1){
        StarShopGoods *sGoods;
        sGoods=[starGoodsDetails objectAtIndex:indexPath.row-1];
        StarGoodsDetailsTwoTableViewCell *twoCell=(StarGoodsDetailsTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"starTwoCell" forIndexPath:indexPath];
        if (![sGoods.starShopGoodsBrand isKindOfClass:[NSNull class]]) {
            twoCell.starGoodsBrand.text=sGoods.starShopGoodsBrand;
        }else{
            twoCell.starGoodsBrand.text=@"null";
        }
        
        if (![sGoods.starShopGoodsName isKindOfClass:[NSNull class]]) {
            twoCell.starGoodsMingzi.text=sGoods.starShopGoodsName;
        }else{
            twoCell.starGoodsMingzi.text=@"null";
        }
        
        if (![sGoods.starShopGoodsPlace isKindOfClass:[NSNull class]]) {
            twoCell.starGoodsPlace.text=sGoods.starShopGoodsPlace;
        }else{
            twoCell.starGoodsPlace.text=@"null";
        }
        
        
        if (![sGoods.starShopGoodsStyle isKindOfClass:[NSNull class]]) {
            twoCell.starGoodsStyle.text=sGoods.starShopGoodsStyle;
        }else{
            twoCell.starGoodsStyle.text=@"null";
        }
        
        if (![sGoods.starShopGoodsId isKindOfClass:[NSNull class]]) {
            twoCell.starGoodsNo.text=sGoods.starShopGoodsId;
        }else{
            twoCell.starGoodsNo.text=@"null";
        }
        
        
        
        twoCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return twoCell;
    }else{
        StarGoodsDetailsThreeTableViewCell *threeCell=(StarGoodsDetailsThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"starThreeCell" forIndexPath:indexPath];
        threeCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        for (int i=0;i<[focusImageArray2 count];i++) {
            //NSString *s1=[focusImageArray2 objectAtIndex:i];
            threeCell.starGoodsImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[focusImageArray2 objectAtIndex:indexPath.row-2]]]];
        }
        
        
        return threeCell;
    }
    return nil;

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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    s=self.tableView.frame.size.height;
    y=_starGoodsDetailsFooterView.frame.size.height;
    _starGoodsDetailsFooterView.frame=CGRectMake(_starGoodsDetailsFooterView.frame.origin.x, s+self.tableView.contentOffset.y-y, _starGoodsDetailsFooterView.frame.size.width, _starGoodsDetailsFooterView.frame.size.height);
    
}

- (IBAction)addToShopCar:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        userMsg=[api login:[User getCurrentUser]];
        starGoodsDetails=[api  showStarShopGoodsMsg:starGoods.starShopGoodsId];
        
        User *user;
        user=[userMsg objectAtIndex:0];
        StarShopGoods *ssGoods;
        ssGoods=[starGoodsDetails objectAtIndex:0];
        NSString *starShopGoodsID=ssGoods.starShopGoodsId;
        NSString *userId=user.userId;
        if ([api addLatestOnlineGoodsToShoppingCar:userId withGoodsId:starShopGoodsID]) {
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


//加入收藏
- (IBAction)collectionBtnClick:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        if ([api addLatestOnlineGoodsCollection:[User getUserID] withGoodsId:starGoods.starShopGoodsId]) {
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
