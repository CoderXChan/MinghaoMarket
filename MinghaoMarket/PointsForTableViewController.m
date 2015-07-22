//
//  PointsForTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/28.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "PointsForTableViewController.h"
#import "PointsForTableViewCell.h"
#import "MingHaoApiService.h"
#import "User.h"
#import "UserLoginViewController.h"
@interface PointsForTableViewController ()<UIAlertViewDelegate>{
    NSMutableArray *myTitleArray;
    NSMutableArray *myTitleArrya1;
    UITextField *tf;
    NSString *tempString;
}



@property (strong, nonatomic) IBOutlet UILabel *currentUserPoints;



@end

@implementation PointsForTableViewController
@synthesize pointsGoodsArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"积分兑换";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    
    
    //self.tableView.scrollEnabled=NO;
    
    //self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    if ([User getCurrentUser]==NULL) {
        
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        pointsGoodsArray=[api showNowPointsGoods:@""];
    }else{
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        pointsGoodsArray=[api showNowPointsGoods:[User getUserID]];
        
        
        _currentUserPoints.text=[User getUserPoint];//获得当前用户积分
    }
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [pointsGoodsArray count];
}


//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Goods *goods;
    goods=[pointsGoodsArray objectAtIndex:indexPath.row];
    PointsForTableViewCell *pontsForCell = [tableView dequeueReusableCellWithIdentifier:@"PointsForCell" forIndexPath:indexPath];
    if (pontsForCell==nil) {
        pontsForCell=[[[NSBundle mainBundle]loadNibNamed:@"PointsForCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        pontsForCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    pontsForCell.pointsImage.image=[UIImage imageNamed:@"goin"];
    
    if (![goods.goodsName isKindOfClass:[NSNull class]]) {
        pontsForCell.couponsLabel.text=goods.goodsName;
    }else{
        pontsForCell.couponsLabel.text=@"null";
    }
    
    
    if (![goods.goodsNum isKindOfClass:[NSNull class]]) {
        pontsForCell.pointsGoodsNum.text=goods.goodsNum;
    }else{
        pontsForCell.pointsGoodsNum.text=@"null";
    }
    
    if (![goods.goodsPoints isKindOfClass:[NSNull class]]) {
        pontsForCell.needsPointsNum.text=goods.goodsPoints;
    }else{
        pontsForCell.needsPointsNum.text=@"null";
    }

    
    Picture *picture=goods.thumbPicture;
    if (picture) {
        if (picture.pictureURL) {
            pontsForCell.pointGoodsImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
            
        }else{
            pontsForCell.pointGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        }
    }

    
    [pontsForCell.pointsBtn addTarget:self action:@selector(pointsClickAction:) forControlEvents:UIControlEventTouchUpInside];
    

    pontsForCell.pointsBtn.goods=goods;
    
    
    return pontsForCell;

}

-(void)alterMsg{
    UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"积分不足!" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [av show];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
}



-(void)pointsClickAction:(MyButton *)btn{
    
    
    if ([User getCurrentUser]!=NULL) {
        if ([[User getUserVip] isEqualToString:@"1"]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示:"
                                                            message:@"请输入兑换数量:"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            // 基本输入框，显示实际输入的内容
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            
            
            Goods *good=[[Goods alloc] init];
            
            //myBtn.goods=btn.goods;
            good.goodsID=btn.goods.goodsID;
            
            
            
            tempString=good.goodsID;
            tempString=btn.goods.goodsID;
            
            [alert show];

        }else{
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示:"
                                                            message:@"您还不是会员,请申请成为会员。"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
            [alert show];
            NSLog(@"需要成为会员");
        }
        
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];
    }
    
    
    NSLog(@"231231");
    
}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (!buttonIndex==0) {
        tf=[alertView textFieldAtIndex:0];
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        if ([api userGetPointGoods:[User getUserID] withPointGoodsId:tempString withNum:tf.text]) {
            UIAlertView *a=[[UIAlertView alloc]initWithTitle:@"提示" message:@"兑换成功!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [a show];
        }
    }
    
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    pointsGoodsArray=[api login:[User getCurrentUser]];
    User *user1;
    user1=[pointsGoodsArray objectAtIndex:0];

    [User setUserPoints:user1.userPoints];//保存当前用户积分

    _currentUserPoints.text=[User getUserPoint];//获得当前用户积分
    
    
    pointsGoodsArray=[api showNowPointsGoods:[User getUserID]];
    [self.tableView reloadData];

    
    
}


@end
