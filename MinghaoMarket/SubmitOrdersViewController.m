//
//  SubmitOrdersViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "SubmitOrdersViewController.h"
#import "MyUiview.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "SelectionCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "AddAddress.h"
#import "TableViewWithBlock.h"
#import "User.h"
#import "MingHaoApiService.h"
#import "AddAddressViewController.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@interface SubmitOrdersViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,AddAddressDelegate>{
    NSString *ccc;
}

/****************提交订单*****************/
//  提交订单按钮
@property (strong, nonatomic) IBOutlet UIView *submitOrdersView;

//  提交订单view
@property (strong, nonatomic) IBOutlet UIView *submitView;

//  提交订单的事件方法
- (IBAction)submitOrdersBtnClick:(id)sender;

//  地址输入框
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
//  总金额数
@property (strong, nonatomic) IBOutlet UILabel *sumPrice;
//  运费金额
@property (strong, nonatomic) IBOutlet UILabel *triffckPrice;

@end

@implementation SubmitOrdersViewController
//@synthesize addressTypeArray;


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
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"提交订单";
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    
    _submitView.layer.cornerRadius=3;
    _submitView.layer.masksToBounds=YES;
    
    _submitOrdersView.layer.borderWidth=1.0;
    _submitOrdersView.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 返回动作
-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}
#pragma mark - AddAddressDelegate
- (void)addAddressWithAddressLabel:(NSString *)addressText
{
    self.addressTextField.text = addressText;
}

#pragma mark - 提交订单,在这里跳转到支付界面
- (IBAction)submitOrdersBtnClick:(id)sender {
    
    
    NSLog(@"转到支付界面");
//    self.navigationController pushViewController: animated:
    
}

@end
