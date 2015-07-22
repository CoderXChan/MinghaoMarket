//
//  MenuSixthViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/17.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuSixthViewController.h"
#import "HouseServiceTableViewController.h"
#import "GoodFoods.h"
@interface MenuSixthViewController ()


- (IBAction)realEstateBtnClick:(id)sender;//房产

- (IBAction)hotalBtnClick:(id)sender;//酒店

- (IBAction)cardBtnClick:(id)sender;//票务卡券

- (IBAction)petBtnClick:(id)sender;//宠物

- (IBAction)hourseServiceBtnClick:(id)sender;//家政服务

- (IBAction)recruitmentBtnClick:(id)sender;//求职招聘

- (IBAction)manyPeopleFunnyBtnClick:(id)sender;//多人娱乐

- (IBAction)carServiceBtnClick:(id)sender;//汽车服务

- (IBAction)publicServiceBtnClick:(id)sender;//公共服务

- (IBAction)findJobBtnClick:(id)sender;//发简历找工作

- (IBAction)decorateBuildingMaterialsBtnClick:(id)sender;//装修建材

- (IBAction)educationTrainingBtnClick:(id)sender;//教育培训


@end

@implementation MenuSixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"请选择发布类别";
    UIColor *testColor= [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:testColor}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)realEstateBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"1";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)hotalBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"2";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)cardBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"3";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)petBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"4";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)hourseServiceBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"5";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)recruitmentBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"6";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)manyPeopleFunnyBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"7";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

    
}

- (IBAction)carServiceBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"8";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)publicServiceBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"9";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)findJobBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"10";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)decorateBuildingMaterialsBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"11";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)educationTrainingBtnClick:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"12";
    gfoods.type=@"0";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

    
}
@end
