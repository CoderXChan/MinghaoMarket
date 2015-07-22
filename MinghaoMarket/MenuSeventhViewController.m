//
//  MenuSeventhViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/6.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuSeventhViewController.h"
#import "HouseServiceTableViewController.h"
#import "GoodFoods.h"
@interface MenuSeventhViewController ()

- (IBAction)allFoods:(id)sender;

- (IBAction)fastFoods:(id)sender;

- (IBAction)smallEat:(id)sender;

- (IBAction)tianDian:(id)sender;

- (IBAction)fuShi:(id)sender;

- (IBAction)appleFoods:(id)sender;

- (IBAction)liangYou:(id)sender;

- (IBAction)chickenFoods:(id)sender;

- (IBAction)yuFoods:(id)sender;

- (IBAction)jiuShui:(id)sender;

- (IBAction)liBao:(id)sender;

- (IBAction)buPin:(id)sender;

@end

@implementation MenuSeventhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"美食";
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

- (IBAction)allFoods:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"1";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
    
}

- (IBAction)fastFoods:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"2";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)smallEat:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"3";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)tianDian:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"4";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

}

- (IBAction)fuShi:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"5";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)appleFoods:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"6";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)liangYou:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"7";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

}

- (IBAction)chickenFoods:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"8";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

}

- (IBAction)yuFoods:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"9";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

}

- (IBAction)jiuShui:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"10";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)liBao:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"11";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];
}

- (IBAction)buPin:(id)sender {
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=@"12";
    gfoods.type=@"2";
    HouseServiceTableViewController *houseService=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    houseService.goodFoods=gfoods;
    [self.navigationController  pushViewController:houseService animated:YES];

}
@end
