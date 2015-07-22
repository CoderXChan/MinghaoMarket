//
//  AddAddressViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/24.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddressManagementViewController.h"
#import "Address.h"
#import "AddAddress.h"
#import "User.h"
#import "MingHaoApiService.h"
#import "MenuEighthTableViewController.h"

@interface AddAddressViewController ()<AddressManagementVCDelegate>


- (IBAction)addAddressBtnClick:(id)sender;



@end

@implementation AddAddressViewController
@synthesize addressMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"地址管理";
    AddressManagementViewController *addAddressManagerVC = [[AddressManagementViewController alloc]init];
    addAddressManagerVC.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        addressMsg=[api showCurrentUserAddress:[User getUserID]];
        
    }
    
    self.addressText = [NSString string];
    
    for (int i=0; i<addressMsg.count; i++) {
        //常用地址1
        AddAddress *address=[addressMsg objectAtIndex:0];
        NSString *province=address.province;  // 省
        NSString *city=address.city;    // 市
        NSString *county=address.county;     // 县
        NSString *addressinfo=address.addressinfo;    //  详细地址信息
        NSString *receiveName = address.receive;    //  收件人
        NSString *receivePhone = address.receivephone;     //  收件人电话
        
        NSString *aaa;
        aaa=[province stringByAppendingString:city];
        NSString *bbb;
        bbb=[aaa stringByAppendingString:county];
        NSString *ccc;
        ccc=[bbb stringByAppendingString:addressinfo];
        NSString *ddd;
        ddd = [ccc stringByAppendingString:receiveName];
        NSString *eee;
        eee = [ddd stringByAppendingString:receivePhone];
        
        NSLog(@"eee===%@",eee);
        self.addressText = eee;
        
    }
    [self.delegate addAddressWithAddressLabel:self.addressText];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self performSelector:@selector(AddressManagementVCWithAddressMessage:) withObject:nil];
}

-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    //[self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
    MenuEighthTableViewController *amvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuEighthTVC"];
    //amvc.delegate=self;
    [self.navigationController pushViewController:amvc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AddressManagementVCWithAddressMessage:(NSString *)addressMessage
{
    self.theGoodAddress.text = addressMessage;
    NSLog(@"------------------addressMessage-%@---------------------",addressMessage);
}


#pragma mark - 添加收货地址
- (IBAction)addAddressBtnClick:(id)sender {
    AddressManagementViewController *amvc=[self.storyboard instantiateViewControllerWithIdentifier:@"addressManagementVC"];
    //amvc.delegate=self;
    [self.navigationController pushViewController:amvc animated:YES];
    
    
}
@end
