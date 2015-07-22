//
//  MenuEighthTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/17.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuEighthTableViewController.h"
#import "MenuEighthTableViewCell.h"
#import "UserLoginViewController.h"
#import "UserRegisterViewController.h"
#import "CreateStoreViewController.h"
#import "User.h"
#import "UserLoginViewController.h"
#import "IntroductionToTheMingHaoViewController.h"
#import "AddAddressViewController.h"
#import "WalletManagementTableViewController.h"
#import "UserRegisterViewController.h"
#import "PointsForTableViewController.h"
#import "MyOrdersTableViewController.h"
#import "MingHaoApiService.h"
#import "MyStoreViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "ShoppingCarTableViewController.h"
@interface MenuEighthTableViewController (){
    NSMutableArray *myTitleArray;
}


/********************个人中心界面**********************/

/** 登录按钮  */
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
/** 注册按钮  */
@property (strong, nonatomic) IBOutlet UIButton *registeredBtn;

/** 登录按钮上添加了一层自定义label  */
@property (strong, nonatomic) IBOutlet UILabel *loginLabel;
/** 注册按钮上添加了一层自定义label  */
@property (strong, nonatomic) IBOutlet UILabel *registeredLabel;
/**  待支付按钮   */
@property (strong, nonatomic) IBOutlet UIButton *willPayBtn;
/**  待收货按钮   */
@property (strong, nonatomic) IBOutlet UIButton *willReceive;
/**  把这个按钮添加到willPayBtn    */
@property (strong,nonatomic) UIButton *redBtn;



//login
- (IBAction)loginBtnClick:(id)sender;


//registered
- (IBAction)registeredBtnClick:(id)sender;


- (IBAction)ToBePaidClick:(id)sender;

- (IBAction)ForTheGoods:(id)sender;


//全部订单图片
- (IBAction)AllOrdersClick:(id)sender;


//全部订单文字
- (IBAction)allOrdersClick1:(id)sender;







@end

@implementation MenuEighthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /***************刺激注册账号***************/
    
    if ([User getCurrentUser] != NULL) {     // 已经登陆，点击他时redBtn消失，并且到预付VC
        //  在这里判断要不要显示小红点
        //  还需要从待支付控制器传值过来。判断账户已经登录，并且传值不为0
        //  接下来就要知道预付订单数组里面有多少个了
        self.redBtn.hidden = NO;
        self.redBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.redBtn.backgroundColor = [UIColor redColor];
        _redBtn.frame = CGRectMake(self.willPayBtn.frame.origin.x , self.willPayBtn.frame.origin.y-self.willPayBtn.frame.size.height-30, 24, 24);
        [_redBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.redBtn.layer setCornerRadius:12];
        [self.redBtn setTitle:@"3" forState:UIControlStateNormal];
        [_redBtn addTarget:self action:@selector(jumpToMyOrderVC) forControlEvents:UIControlEventTouchUpInside];
        
        [self.willPayBtn addSubview:_redBtn];
        
    }else{
        self.redBtn.hidden = YES;
    }
    
    
    if ([[User getUserShop ]isEqualToString:@"1"]) {
        myTitleArray=[[NSMutableArray alloc] initWithObjects:@"我的店铺",@"成为会员",@"钱包管理",@"地址管理",@"积分兑换",@"明昊客服",@"关于明昊", nil];
    }else{
        myTitleArray=[[NSMutableArray alloc] initWithObjects:@"免费开店",@"成为会员",@"钱包管理",@"地址管理",@"积分兑换",@"明昊客服",@"关于明昊", nil];
    }
    
    self.navigationItem.title=@"我";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
    
    NSLog(@"us==%@",[User getUserShop]);
  

}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
    if ([User getCurrentUser]!=NULL) {
        [_loginBtn setHidden:YES];
        //[_registeredBtn setHidden:YES];
        //[_registeredLabel setHidden:YES];

        _loginLabel.text=[User getName];
        _loginLabel.textColor=[UIColor blackColor];
        
        
        _registeredLabel.text=@"注销";
        [_registeredBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }

}


-(void)exitBtnClick{
    [User setCurrentUser:nil];
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

    return 7;
}


//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuEighthTableViewCell *mEighthcell = [tableView dequeueReusableCellWithIdentifier:@"menuEighthCell" forIndexPath:indexPath];
    if (mEighthcell==nil) {
        mEighthcell=[[[NSBundle mainBundle]loadNibNamed:@"menuEighthCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        mEighthcell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    mEighthcell.menuEighthImage.image=[UIImage imageNamed:@"goin"];//不显示
    mEighthcell.menuEighthTitle.text=[myTitleArray objectAtIndex:indexPath.row];
    
    
    
    return mEighthcell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0  && [User getCurrentUser]!=NULL ) {
        if ([[User getUserShop ]isEqualToString:@"1"]) {
            MyStoreViewController *msvc=[self.storyboard instantiateViewControllerWithIdentifier:@"mystoreVC"];
            [self.navigationController  pushViewController:msvc animated:YES];
        }else{
            CreateStoreViewController *csvc=[self.storyboard instantiateViewControllerWithIdentifier:@"createStoreVC"];
            [self.navigationController  pushViewController:csvc animated:YES];
        }
        
    }else if (indexPath.row==1 &&  [User getCurrentUser]!=NULL){
        UserRegisterViewController *userReg=[self.storyboard instantiateViewControllerWithIdentifier:@"userRegisterVC"];
        [self.navigationController pushViewController:userReg animated:YES];
    }else if (indexPath.row==2 && [User getCurrentUser]!=NULL){
        WalletManagementTableViewController *wamatvc=[self.storyboard instantiateViewControllerWithIdentifier:@"walletManagementTVC"];
        [self.navigationController pushViewController:wamatvc animated:YES];
    }else if (indexPath.row==3 && [User getCurrentUser]!=NULL){
        AddAddressViewController *aavc=[self.storyboard instantiateViewControllerWithIdentifier:@"addaddressVC"];
        [self.navigationController pushViewController:aavc animated:YES];
    }else if (indexPath.row==4 ){
        PointsForTableViewController *pointFortvc=[self.storyboard instantiateViewControllerWithIdentifier:@"pointsForTVC"];
        [self.navigationController pushViewController:pointFortvc animated:YES];
    }else if (indexPath.row==5 ){
        // 在这里跳转到明昊客服界面
    }else if(indexPath.row==6 ) {
        IntroductionToTheMingHaoViewController *ittmhvc=[self.storyboard instantiateViewControllerWithIdentifier:@"introductionToTheMH"];
        [self.navigationController pushViewController:ittmhvc animated:YES];
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController pushViewController:ulvc animated:YES];
    }
    
}

#pragma mark - jumpToMyOrderVC
- (void)jumpToMyOrderVC
{
    self.redBtn.hidden = YES;
    
    ShoppingCarTableViewController *motvc=[self.storyboard instantiateViewControllerWithIdentifier:@"shopCarTVC"];
    [self.navigationController pushViewController:motvc animated:YES];

}


#pragma mark - 登录按钮
- (IBAction)loginBtnClick:(id)sender {
    
    UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
    [self.navigationController  pushViewController:ulvc animated:YES];
    
    
}

#pragma mark - 注册按钮
- (IBAction)registeredBtnClick:(id)sender {
    
    UserRegisterViewController *urvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userRegisterVC"];
    [self.navigationController  pushViewController:urvc animated:YES];
}

#pragma mark - 跳转到待支付界面 shoppingcarVC
- (IBAction)ToBePaidClick:(id)sender {
    
    //  还是需要先判断一下有没有登陆    shopCarTVC
    if ([User getCurrentUser] != NULL) {    //  登陆了
        
        ShoppingCarTableViewController *motvc=[self.storyboard instantiateViewControllerWithIdentifier:@"shopCarTVC"];
        [self.navigationController pushViewController:motvc animated:YES];
    }else{                                 // 没有登陆
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController pushViewController:ulvc animated:YES];
        
    }
    
    
}



#pragma mark - 待收货界面,  这里错了
- (IBAction)ForTheGoods:(id)sender {
    if ([User getCurrentUser]!=NULL) {   //  已经登录 ，那就跳转界面
        NSLog(@"到代收货界面");
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController pushViewController:ulvc animated:YES];
        
    }
}
#pragma mark - 全部订单页面
- (IBAction)AllOrdersClick:(id)sender {   // 没有登录时点击这个会到UserLoginViewController
    
    NSLog(@"0000000000000000");
    
    if ([User getCurrentUser]!=NULL) {   // 判断用户是否登录过
        NSLog(@"全部订单页面");
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController pushViewController:ulvc animated:YES];
        
    }
}
#pragma mark - 全部订单
- (IBAction)allOrdersClick1:(id)sender {  // 用户已经登录过，直接跳转到 MyOrdersTableViewController
    
    
    if ([User getCurrentUser] != NULL) {
        
        MyOrdersTableViewController *motvc=[self.storyboard instantiateViewControllerWithIdentifier:@"myOrdersTVC"];
        [self.navigationController pushViewController:motvc animated:YES];
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController pushViewController:ulvc animated:YES];
        
    }
    
}

@end
