//
//  IntroductionToTheMingHaoViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/24.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "IntroductionToTheMingHaoViewController.h"
#import "MingHaoApiService.h"
#import "GoodsType.h"
#import "UIImageView+WebCache.h"
@interface IntroductionToTheMingHaoViewController ()


@property (strong, nonatomic) IBOutlet UIImageView *minghaoImage;



@property (strong, nonatomic) IBOutlet UITextView *minghaoInfo;


@end

@implementation IntroductionToTheMingHaoViewController
@synthesize minghaoMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    
    MingHaoApiService *api=[[MingHaoApiService alloc]init];
    minghaoMsg=[api abboutMingHao];
    GoodsType *goodsType=[minghaoMsg objectAtIndex:0];
    
    _minghaoInfo.text=goodsType.productTypeName;
    
    [_minghaoImage sd_setImageWithURL:[NSURL URLWithString:goodsType.productTypeImage.pictureURL] placeholderImage:[UIImage imageNamed:@"120"]];
//    _minghaoImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:goodsType.productTypeImage.pictureURL]]];
    
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15]};
    _minghaoInfo.attributedText=[[NSAttributedString alloc]initWithString: _minghaoInfo.text attributes:attributes];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
