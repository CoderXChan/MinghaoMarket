//
//  UserLoginViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/17.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "UserLoginViewController.h"
#import "User.h"
#import "UserServices.h"
#import "UserRegisterViewController.h"
#import "MenuEighthTableViewController.h"
#import "MingHaoApiService.h"
@interface UserLoginViewController ()


- (IBAction)closeKBAction:(id)sender;



@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *userLoginAiv;


- (IBAction)goToRegAction:(id)sender;




@end

@implementation UserLoginViewController
@synthesize userId,userPwd,userMsg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_userLoginAiv setHidden:YES];
    
    // Do any additional setup after loading the view.
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 18, 18);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    // 读取userDefault
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *myNum = [userDefault stringForKey:@"uNum"];
    NSString *myPwd = [userDefault stringForKey:@"uPwd"];
    self.userId.text = myNum;
    self.userPwd.text = myPwd;
}


-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    //[self.navigationController popViewControllerAnimated:YES];
    MenuEighthTableViewController *eetvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuEighthTVC"];
    [self.navigationController pushViewController:eetvc animated:YES];
    //[_sideSlipView switchMenu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 用户登录
- (IBAction)userLoginClick:(id)sender {
    [userId resignFirstResponder];
    [userPwd resignFirstResponder];
    
    if ([userId.text isEqualToString:@""]) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else if ([userPwd.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else{
        [self.view setAlpha:0.8];
        [self.navigationController.navigationBar setAlpha:0.8];
        
        [_userLoginAiv setColor:[UIColor grayColor]];
        [_userLoginAiv setHidden:NO];
        [_userLoginAiv startAnimating];
        [self.view addSubview:_userLoginAiv];
        
        [self performSelector:@selector(stop) withObject:nil afterDelay:1];
    
    }
}

#pragma mark - 账号密码缓存
-(void)stop{
    //停止转动
    [_userLoginAiv stopAnimating];
    [_userLoginAiv removeFromSuperview];
    //恢复透明度
    [self.view setAlpha:1];
    [self.navigationController.navigationBar setAlpha:1];
    
    User *user=[[User alloc]init];
    user.userPhoneNumber=userId.text;
    user.userPassWord=userPwd.text;
    
    
    UserServices *us=[[UserServices alloc]init];
    
    if(![us login:user]) {
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码不正确！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
    }else{
        // set当前用户
        [User setCurrentUser:user];
        
        
        // 保存当前用户信息
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        userMsg=[api login:[User getCurrentUser]];
        User *user1;
        user1=[userMsg objectAtIndex:0];
        
        
        [User setUserid:user1.userId];
        [User setName:user1.userName];
        [User setUserShop:user1.userShopYesOrNo];
        [User setUserPoints:user1.userPoints];
        [User setUserVip:user1.userVip];
        
        NSLog(@"userPhoneNumber==%@",self.userId.text);   // 13537729094
        NSLog(@"pwd==%@",self.userPwd.text);   // czc123456
        NSString *uNum = self.userId.text;
        NSString *uPwd = self.userPwd.text;
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:uNum forKey:@"uNum"];
        [userDefault setObject:uPwd forKey:@"uPwd"];
        [userDefault synchronize];
        
        
        //返回上一页
        //[self.navigationController popViewControllerAnimated:YES];
        MenuEighthTableViewController *me=[self.storyboard instantiateViewControllerWithIdentifier:@"menuEighthTVC"];
        [self.navigationController pushViewController:me animated:YES];

    }
}



- (IBAction)closeKBAction:(id)sender {
    [userId resignFirstResponder];
    [userPwd resignFirstResponder];
    
}
- (IBAction)goToRegAction:(id)sender {
    UserRegisterViewController *userReg=[self.storyboard instantiateViewControllerWithIdentifier:@"userRegisterVC"];
    [self.navigationController pushViewController:userReg animated:YES];
}
@end
