//
//  AddressManagementViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/24.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "AddressManagementViewController.h"
#import "Address.h"
#import "AddAddressViewController.h"
#import "User.h"
#import "MingHaoApiService.h"
#import "UserLoginViewController.h"
#import "AddAddress.h"
@interface AddressManagementViewController ()


@property (strong, nonatomic) IBOutlet UITextField *theBuyer;

@property (strong, nonatomic) IBOutlet UITextField *theBuyerPhoneNumber;

@property (strong, nonatomic) IBOutlet UITextField *province;

@property (strong, nonatomic) IBOutlet UITextField *city;

@property (strong, nonatomic) IBOutlet UITextField *county;


@property (strong, nonatomic) IBOutlet UITextField *detailedAddress;




@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *actView;



@end

@implementation AddressManagementViewController
@synthesize addressMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.actView setHidden:YES];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"地址管理";
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(OnRightButton:)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;

}

-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    AddAddressViewController *eetvc=[self.storyboard instantiateViewControllerWithIdentifier:@"addaddressVC"];
    [self.navigationController pushViewController:eetvc animated:YES];

    //[_sideSlipView switchMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加的item
-(void)OnRightButton:(id)sender{
    if ([self.theBuyer.text isEqualToString:@""]) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写收货人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([self.theBuyerPhoneNumber.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号为空或不是一个有效手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([self.province.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写省份" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([self.city.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写城市" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([self.county.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写县/区" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([self.detailedAddress.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写详细地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else{
        //Address *address=[[Address alloc] init];
        //address.address=self.detailedAddress.text;
        
        //[self.delegate passValue:address];
        
        //AddAddressViewController *aamvc=[self.storyboard instantiateViewControllerWithIdentifier:@"addaddressVC"];
        //[self.navigationController pushViewController:aamvc animated:YES];
        [self.view setAlpha:0.5];
        [_actView setColor:[UIColor grayColor]];
        [_actView setHidden:NO];
        [_actView startAnimating];
        [self.view addSubview:_actView];
        
        [self performSelector:@selector(stop) withObject:nil afterDelay:0.0];
        NSLog(@"添加按钮");
    
    }

}



-(void)stop{
    [_actView stopAnimating];
    _actView.hidden=YES;
    [self.view setAlpha:1];
    
    if ([User getCurrentUser]!=NULL) {
        NSString *province=self.province.text;
        NSString *city=self.city.text;
        NSString *county=self.county.text;
        NSString *addressinfo=self.detailedAddress.text;
        NSString *theBuyer=self.theBuyer.text;
        NSString *theBuyerPhoneNumber=self.theBuyerPhoneNumber.text;
        
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        if ([api saveorupdataAddressWithUserId:[User getUserID] withProvince:province withCity:city withCounty:county withAddressInfo:addressinfo withReceive:theBuyer withReceivePhone:theBuyerPhoneNumber]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"添加地址成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            //  这里把地址添加成功了。并且把这喘字符串传到addAddressVC
            NSLog(@"--%@--%@--%@--%@--%@--%@--",province,city,county,addressinfo,theBuyer,theBuyerPhoneNumber);

            NSString *aaa;
            aaa=[province stringByAppendingString:province];
            NSString *bbb;
            bbb=[aaa stringByAppendingString:city];
            NSString *ccc;
            ccc=[bbb stringByAppendingString:county];
            NSString *ddd;
            ddd = [ccc stringByAppendingString:addressinfo];
            ddd = [ddd stringByAppendingString:@" "];
            NSString *eee;
            eee = [ddd stringByAppendingString:theBuyer];
            eee = [eee stringByAppendingString:@" "];
            NSString *fff;
            fff = [eee stringByAppendingString:theBuyerPhoneNumber];
            self.addressMessage = fff;
            
            //  在此调用代理方法，把地址信息传过去
            if ([self.delegate respondsToSelector:@selector(AddressManagementVCWithAddressMessage:)]) {
                NSLog(@"fff===%@",self.addressMessage);
                [self.delegate AddressManagementVCWithAddressMessage:self.addressMessage];
            }
            
            [alert show];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"添加地址失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
    
        }
        //  跳到添加地址控制器
        AddAddressViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"addaddressVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];

    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
