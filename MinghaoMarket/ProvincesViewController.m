//
//  ProvincesViewController.m
//  MinghaoMarket
//
//  Created by tomsz on 15/7/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "ProvincesViewController.h"

@interface ProvincesViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *sectionArray;
    NSArray *cellArray;
}
@property (weak, nonatomic) IBOutlet UITableView *provinceTable;

@end

@implementation ProvincesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sectionArray = @[@"当前收货地区",@"A",@"B",@"C",@"F",@"G",@"H",@"J",@"L",@"N",@"Q",@"S",@"T",@"X",@"Y",@"Z"];
    NSArray *A = @[@"安徽省"];
    NSArray *B = @[@"北京市"];
    NSArray *C = @[@"重庆市"];
    NSArray *F = @[@"福建省"];
    NSArray *G = @[@"甘肃省",@"广东省",@"广西壮族自治区",@"贵州省"];
    NSArray *H = @[@"海南省",@"河北省",@"黑龙江省",@"河南省",@"湖北省",@"湖南省"];
    NSArray *J = @[@"江苏省",@"江西省",@"吉林省"];
    NSArray *L = @[@"辽宁省"];
    NSArray *N = @[@"内蒙古自治区",@"宁夏回族自治区"];
    NSArray *Q = @[@"青海省"];
    NSArray *S = @[@"陕西省",@"山东省",@"上海市",@"山西省",@"四川省"];
    NSArray *T = @[@"天津市"];
    NSArray *X = @[@"西藏自治区",@"新疆维吾尔自治区"];
    NSArray *Y = @[@"云南省"];
    NSArray *Z = @[@"浙江省"];
    cellArray = @[A,B,C,F,G,H,J,L,N,Q,S,T,X,Y,Z];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -UITableViewDataSource,UITableViewDelegate-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0||section ==1) {
        return 1;
    }else{
        NSArray *array = [cellArray objectAtIndex:section-2];
        return array.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cell0 = @"cell0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell0];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell0];
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
            [cell.contentView addSubview:lable];
            lable.text = @"选择你要收货的地址,送货更快哦";
            lable.textAlignment = NSTextAlignmentCenter;
        }
        return cell;
    }else{
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.section == 1) {
            NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"mainProvince"];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",str];
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[[cellArray objectAtIndex:indexPath.section-2] objectAtIndex:indexPath.row]];;
        }
        return cell;
    }
}
//区头数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 17;
}
//第一个区没区头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?0:20;
}
//cell能不能被选中
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return !(indexPath.section == 0||indexPath.section == 1);
}
//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    [UD setObject:str forKey:@"mainProvince"];
    [UD synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        lable.backgroundColor = [UIColor lightGrayColor];
        lable.text = [NSString stringWithFormat:@"   %@",[sectionArray objectAtIndex:section-1]];
        return lable;
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
