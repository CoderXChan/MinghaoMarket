//
//  ShoppingCarTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/10.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "ShoppingCarTableViewController.h"
#import "SubmitOrdersViewController.h"
#import "User.h"
#import "UserLoginViewController.h"
#import "SubmitOrdersViewController.h"
#import "MingHaoApiService.h"
#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarGoods.h"
#import "LatestOnlineGoods.h"
#import "ShoppingCarGoods.h"
#import "UIImageView+WebCache.h"
@interface ShoppingCarTableViewController (){
    int s;
    int y;
    float tempInt;
    float tempInt2;
    float allPrice;//总金额
    NSString *tempSCGoodsID;
}
@property (strong,nonatomic) ShoppingCarGoods *shopGoods;

@property (strong, nonatomic) IBOutlet UIView *footerView1;  // 底部视图

@property (strong, nonatomic) IBOutlet UIView *settlementView;// 结算

@property (copy,nonatomic) NSArray *shoppingCarCount;

#pragma mark - 结算按钮
- (IBAction)settlementBtnClick:(id)sender;



@end

@implementation ShoppingCarTableViewController
@synthesize currentUserAllShoppingCarGoods,userMsg,goodsMsg,goods,tempNum,theAllMoney;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - 加载storyboard比较好
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shopGoods = [[ShoppingCarGoods alloc]init];
    
    
    //ShoppingCarTableViewCell
     tempInt=0;

    self.navigationItem.title=@"购物车";
    
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=back;
    self.tableView.tableFooterView=[[UIView alloc]init];
    
    
    self.tableView.bounces=NO;
    
 
    //  结算按钮
    _settlementView.layer.cornerRadius=3;
    _settlementView.layer.masksToBounds=YES;
    
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        currentUserAllShoppingCarGoods = [api queryShoppingCar:[User getUserID]];
    }
    
    
    
    //  计算总金额
    for (int i =0; i<currentUserAllShoppingCarGoods.count; i++)
    {
        ShoppingCarGoods *m = [currentUserAllShoppingCarGoods objectAtIndex:i];
        float discount=[m.shoppingCarGoodsDiscount intValue];
        float price=[m.shoppingCarGoodsPrice floatValue];
        NSString *discountPrice=[NSString stringWithFormat:@"%.1f",price*discount/10];
        tempInt += [discountPrice floatValue];
        
        
        //  这里可以把预付订单数接收一下currentUserAllShoppingCarGoods:就是预付订单数组
    }
    
    NSString *string=[NSString stringWithFormat:@"%.1f",tempInt];
    theAllMoney.text=string;
     
   
    _cellArray = [[NSMutableArray alloc]init];
    
 }


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];



}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _footerView1.layer.borderWidth=1.0;
    _footerView1.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    
    return _footerView1;

}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90;

}

#pragma mark - 在这里增加返回按钮的自定义动作
-(void)goBackAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}

#pragma mark - 在这里增加返回按钮的自定义动作
-(void)OnBackButton{
    
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
#pragma mark - currentUserAllShoppingCarGoods数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [currentUserAllShoppingCarGoods count];
}

#pragma mark - 定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0;
    
}

//  面试题：怎么实现在个人中心界面获取到购物车界面的还有多少未支付的数量，显示为badgeValue


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ShoppingCarTableViewCell";
    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        cell=[[ShoppingCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    ShoppingCarGoods *scGoods=[currentUserAllShoppingCarGoods objectAtIndex:indexPath.row];
    
    //  商品属性的赋值
    if (![scGoods.shoppingCarGoodsName isKindOfClass:[NSNull class]]) {
        cell.shoppingCarGoodsName.text=scGoods.shoppingCarGoodsName;
    }else{
        cell.shoppingCarGoodsName.text=@" ";
    }
    
    if (![scGoods.shoppingCarGoodsDescribe isKindOfClass:[NSNull class]]) {
        cell.shoppingCarGoodsDes.text=scGoods.shoppingCarGoodsDescribe;
    }else{
        cell.shoppingCarGoodsDes.text=@" ";
    }
    
    if (![scGoods.shoppingCarGoodsPrice isKindOfClass:[NSNull class]]) {
        cell.shoppingCarGoodsPrice.text=scGoods.shoppingCarGoodsPrice;
        
    }else{
        cell.shoppingCarGoodsPrice.text=@" ";
    }
    
    if (![scGoods.shoppingCarGoodsDiscount isKindOfClass:[NSNull class]]) {
        cell.shoppingCarDiscount.text=scGoods.shoppingCarGoodsDiscount;
        
    }else{
        cell.shoppingCarDiscount.text=@" ";
    }
    
    //计算折扣后的单价
    float price=[scGoods.shoppingCarGoodsPrice floatValue];
    float discount=[scGoods.shoppingCarGoodsDiscount intValue];
    NSString *discountPrice=[NSString stringWithFormat:@"%.1f",price*discount/10];
    cell.shoppingDiscountThanPrice.text=discountPrice;
    
    
    for (Picture  *picture in scGoods.shoppingCarGoodsImage) {
//        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
//            cell.shoppingCarImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//        }else{
//            cell.shoppingCarImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
        NSURL *picURL = [NSURL URLWithString:picture.pictureURL];
        [cell.shoppingCarImage sd_setImageWithURL:picURL placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
        
    }
    
    
    //计算单个总价
    cell.shoppingAllPrice.text=discountPrice;
    
    cell.shoppingCarDeleteBtn.shoppingCarGoods=scGoods;
    
    [cell.shoppingCarDeleteBtn addTarget:self action:@selector(deleteGoodsFromShoppingCar:) forControlEvents:UIControlEventTouchUpInside];

    [cell setContentWithString:[cell.textDisplay.text intValue]];
    
    //  问题可能在这。默认是1
    
    cell.textDisplay.text=@"1";
    
    
    
    cell.shoppingCarDeleteBtn.tag=indexPath.row;
    cell.tag=indexPath.row;
    
    [_cellArray addObject:cell];
    NSLog(@"cellarray=%@",_cellArray);
    return cell;
}


#pragma mark - 删除某个商品订单
-(void)deleteGoodsFromShoppingCar:(MyButton *)btn{
    /*
    NSArray *visibleCells=[self.tableView visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if (cell.tag==btn.tag) {
            [_cellArray removeObjectAtIndex:[cell tag]];
            [self.tableView reloadData];
            break;
        }
    }
    
    NSLog(@"cellarray1=%@",_cellArray);
    */
    
    ShoppingCarGoods *good=[[ShoppingCarGoods alloc] init];
    good.shoppingCarGoodsId=btn.shoppingCarGoods.shoppingCarGoodsId;
    
    tempSCGoodsID=good.shoppingCarGoodsId;
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"是否删除购物车中该商品?" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"确定", nil];
    
    [alert  show];
    
}



#pragma mark - 删除之后再计算
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
//    NSLog(@"-------------------%@---------------",self.shopGoods.shoppingCarGoodsDiscount); // null
    
    if (buttonIndex == 0){
        
    }else if (buttonIndex == 1){
        //做删除购物车商品操作
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        if ([api deleteShoppingCarGoods:[User getUserID] withGoodsId:tempSCGoodsID]) {
    /*******************************************************************************************/
            // 总金额需要减去删去商品的总金额..问题 删除这个商品之后，下次增加还会加上删除商品的单个价格
            
            NSLog(@"%@的%@商品被删除了",[User getUserID],tempSCGoodsID);
            
        }
 
    }
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];

    currentUserAllShoppingCarGoods=[api queryShoppingCar:[User getUserID]];
    
    [self.tableView reloadData];
    
   
    //知道问题的原因了[_cellarray ]也要对应删除
    
    
    tempInt2=0;
    for (int i = 0; i<currentUserAllShoppingCarGoods.count; i++)
    {
        ShoppingCarGoods *m = [currentUserAllShoppingCarGoods objectAtIndex:i];
        float discount=[m.shoppingCarGoodsDiscount intValue];
        float price=[m.shoppingCarGoodsPrice floatValue];
        NSString *discountPrice=[NSString stringWithFormat:@"%.1f",price*discount/10];
        tempInt2 += [discountPrice floatValue];
        
    }
    
//    //  测试一下  报错
//    [_cellArray delete:tempSCGoodsID];
    
    NSString *string=[NSString stringWithFormat:@"%.1f",tempInt2];
    theAllMoney.text=string;
    
    
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    s=self.tableView.frame.size.height;
    y=_footerView1.frame.size.height;
    _footerView1.frame=CGRectMake(_footerView1.frame.origin.x, s+self.tableView.contentOffset.y-y, _footerView1.frame.size.width, _footerView1.frame.size.height);

}



#pragma mark - 点击结算之后，跳到提交订单界面.submitVC
- (IBAction)settlementBtnClick:(id)sender {
    if ([theAllMoney.text isEqualToString:@"0.0"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"没有订单" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        //  这时应该到提交界面
        SubmitOrdersViewController *subvc=[self.storyboard instantiateViewControllerWithIdentifier:@"subOrdersVC"];
        [self.navigationController pushViewController:subvc animated:YES];
    
    }
   
}



@end
