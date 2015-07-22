//
//  UserRegisterViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/20.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserLoginViewController.h"
#import "User.h"
#import "UserServices.h"
#import "MenuEighthTableViewController.h"
@interface UserRegisterViewController (){
    
}


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *regAiv;


- (IBAction)hadIDtoLogin:(id)sender;


- (IBAction)closeKBAction:(id)sender;


@end

@implementation UserRegisterViewController
@synthesize userPhoneNum,userNickname,userPwd,confirmUserPwd,userEmail;

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
    [self.regAiv setHidden:YES];
    
    // Do any additional setup after loading the view.
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 18, 18);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
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



- (IBAction)regClick:(id)sender {
    [userPhoneNum resignFirstResponder];
    [userNickname resignFirstResponder];
    [userPwd resignFirstResponder];
    [confirmUserPwd resignFirstResponder];
    [userEmail resignFirstResponder];
    
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    //NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    //NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    /*
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    */
    
    
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    //昵称
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *nickNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    
    //#pragma 正则匹配用户密码6-18位数字和字母组合
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    //return [emailTest evaluateWithObject:email];
    
    //av=[[UIAlertView alloc] init];
    if ([userPhoneNum.text isEqualToString:@""] || userPhoneNum.text.length!=11) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号为空或不是一个有效手机号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else if ([userNickname.text isEqualToString:@""] || ![nickNamePredicate evaluateWithObject:userNickname.text]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"昵称不符合要求" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else if ([userPwd.text isEqualToString:@""] || ![pred evaluateWithObject:userPwd.text]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不符合要求" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else if ([confirmUserPwd.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入确认密码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else if(![confirmUserPwd.text isEqualToString:userPwd.text]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }else if([userEmail.text isEqualToString:@""]  || ![emailTest evaluateWithObject:userEmail.text]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱为空或不是一个有效的邮箱" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    
    }else{
        [self.view setAlpha:0.5];
        
        [_regAiv setColor:[UIColor grayColor]];
        [_regAiv setHidden:NO];
        [_regAiv startAnimating];
        [self.view addSubview:_regAiv];
        
        [self performSelector:@selector(stop) withObject:nil afterDelay:1];
    
    }
    
  
}



-(void)stop{
    [_regAiv stopAnimating];
    _regAiv.hidden=YES;
    [self.view setAlpha:1];
    
    User *user=[[User alloc] init];
    user.userPhoneNumber=userPhoneNum.text;
    user.userName=userNickname.text;
    user.userPassWord=userPwd.text;
    user.userEmail=userEmail.text;
    
    UserServices *userService=[[UserServices alloc] init];
    if ([userService registed:user]) {
        
        UIAlertView *a=[[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜您注册成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [a show];
    }else{
        UIAlertView *a=[[UIAlertView alloc]initWithTitle:@"提示" message:@"该手机号码已被注册!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [a show];
    }
    
}


//响应警告视图
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *s=[alertView buttonTitleAtIndex:buttonIndex];
    if ([s isEqualToString:@"确定"]){
        //返回根视图
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];

    }
}



- (IBAction)hadIDtoLogin:(id)sender {
    
    UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
    [self.navigationController  pushViewController:ulvc animated:YES];
    
}

- (IBAction)closeKBAction:(id)sender {
    [userPhoneNum resignFirstResponder];
    [userNickname resignFirstResponder];
    [userPwd resignFirstResponder];
    [confirmUserPwd resignFirstResponder];
    [userEmail resignFirstResponder];
    
    
}
@end
