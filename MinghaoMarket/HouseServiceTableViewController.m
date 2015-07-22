//
//  HouseServiceTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/27.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "HouseServiceTableViewController.h"
#import "HouseServiceTableViewCell.h"
#import "MyReleaseViewController.h"
#import "MingHaoApiService.h"
#import "Picture.h"
#import "UserLoginViewController.h"
#import "Store.h"
#import "MessageDescViewController.h"
#import "MenuSixthViewController.h"
#import "MenuSeventhViewController.h"
#import "GoodFoodsDescTableViewController.h"
@interface HouseServiceTableViewController (){
    NSString *string;
    NSString *tempstring;
}

@end

@implementation HouseServiceTableViewController
@synthesize goodFoods,goodFoodsArray,messageGoodsArray,myStoreMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的发布" style:UIBarButtonItemStylePlain target:self action:@selector(OnRightButton:)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    */
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(OnRightButton:)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    
    
    
    //goodFoodsArray=[[NSMutableArray alloc]init];
    string=goodFoods.type;
    NSLog(@"string=%@",string);
    tempstring=goodFoods.typeId;
    NSLog(@"tempstring===%@",tempstring);
    if ([string isEqualToString:@"0"]) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        messageGoodsArray=[api showMessageGoods:tempstring];
        NSLog(@"messageGoodsArray==%@",messageGoodsArray);
    }else{
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        goodFoodsArray=[api showGoodFoods:tempstring];
        NSLog(@"goodfoodarray==%@",goodFoodsArray);

    }
}

-(void)goBackAction{
    if ([string isEqualToString:@"0"]) {
        MenuSixthViewController *metvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuSixthTVC"];
        [self.navigationController pushViewController:metvc animated:YES];

    }else{
        MenuSeventhViewController *metvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuseventhTVC"];
        [self.navigationController pushViewController:metvc animated:YES];

    }}


-(void)OnRightButton:(id)sender{
    if ([User getCurrentUser]!=NULL) {
        if (![string isEqualToString:@"2"]) {
            MyReleaseViewController *myRelease=[self.storyboard instantiateViewControllerWithIdentifier:@"myReleaseVC"];
            string=goodFoods.type;
            tempstring=goodFoods.typeId;
            
            myRelease.goodFoods=goodFoods;
            [self.navigationController pushViewController:myRelease animated:YES];
            NSLog(@"我的发布");
        }else{
            MingHaoApiService *api=[[MingHaoApiService alloc]init];
            myStoreMsg=[api showMyStoreMsg:[User getUserID]];
            Store *st=[myStoreMsg objectAtIndex:0];
            NSString *moneyGiveYesOrNo=st.moneyGiveYesOrNo;
            NSLog(@"momo=%@",moneyGiveYesOrNo);
            if ([[User getUserShop ]isEqualToString:@"1"] && [moneyGiveYesOrNo isEqualToString:@"2"]) {
                NSLog(@"做发布美食的操作");
                MyReleaseViewController *myRelease=[self.storyboard instantiateViewControllerWithIdentifier:@"myReleaseVC"];
                
                string=goodFoods.type;
                tempstring=goodFoods.typeId;
                
                myRelease.goodFoods=goodFoods;
                [self.navigationController pushViewController:myRelease animated:YES];
                NSLog(@"我的发布");

            
            }else{
                UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时无法发布美食，请确认您的是否开店或店铺是否激活。" delegate:nil cancelButtonTitle:@"确定"        otherButtonTitles:nil, nil];
                [av show];
            }
        }
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController pushViewController:ulvc animated:YES];
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{

    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([string isEqualToString:@"0"]) {
        return [messageGoodsArray count];
    }else{
        return [goodFoodsArray count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HouseServiceTableViewCell *houseServiceCell = [tableView dequeueReusableCellWithIdentifier:@"houseServiceCell" forIndexPath:indexPath];
    if (houseServiceCell==nil) {
        houseServiceCell=[[[NSBundle mainBundle]loadNibNamed:@"houseServiceCell" owner:self options:nil] lastObject];
        
        tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        houseServiceCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    
    if ([string isEqualToString:@"0"]) {
        Goods *goods;
        goods=[messageGoodsArray objectAtIndex:indexPath.row];
        
        Picture *picture=goods.thumbPicture;
        if (picture) {
            if (picture.pictureURL) {
                houseServiceCell.houseServiceImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
                
            }else{
                houseServiceCell.houseServiceImage.image=[UIImage imageNamed:@"wemall_picture_default"];
            }
        }
        
        
        
        if (![goods.goodsName isKindOfClass:[NSNull class]]) {
            houseServiceCell.houseServiceTitle.text=goods.goodsName;
        }else{
            houseServiceCell.houseServiceTitle.text=@"null";
        }
        
        
        if (![goods.goodsDesc isKindOfClass:[NSNull class]]) {
            houseServiceCell.houseServiceSubTitle.text=goods.goodsDesc;
        }else{
            houseServiceCell.houseServiceSubTitle.text=@"null";
        }
        
        
        if (![goods.goodsPrice isKindOfClass:[NSNull class]]) {
            houseServiceCell.houseServicePrice.text=goods.goodsPrice;
        }else{
            houseServiceCell.houseServicePrice.text=@"null";
        }
        
        
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15]};
        houseServiceCell.houseServiceTitle.attributedText=[[NSAttributedString alloc]initWithString: houseServiceCell.houseServiceTitle.text attributes:attributes];
        
        
        houseServiceCell.descBtn.goods=goods;
        [houseServiceCell.descBtn addTarget:self action:@selector(showDesc:) forControlEvents:UIControlEventTouchUpInside];
        

        
        
        return houseServiceCell;

    }else{
        Goods *goods;
        goods=[goodFoodsArray objectAtIndex:indexPath.row];
        
        Picture *picture=goods.thumbPicture;
        if (picture) {
            if (picture.pictureURL) {
                houseServiceCell.houseServiceImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
                
            }else{
                houseServiceCell.houseServiceImage.image=[UIImage imageNamed:@"wemall_picture_default"];
            }
        }
        
        
        
        if (![goods.goodsName isKindOfClass:[NSNull class]]) {
            houseServiceCell.houseServiceTitle.text=goods.goodsName;
        }else{
            houseServiceCell.houseServiceTitle.text=@"null";
        }
        
        
        if (![goods.goodsDesc isKindOfClass:[NSNull class]]) {
            houseServiceCell.houseServiceSubTitle.text=goods.goodsDesc;
        }else{
            houseServiceCell.houseServiceSubTitle.text=@"null";
        }
        
        
        if (![goods.goodsPrice isKindOfClass:[NSNull class]]) {
            houseServiceCell.houseServicePrice.text=goods.goodsPrice;
        }else{
            houseServiceCell.houseServicePrice.text=@"null";
        }
        
        
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15]};

        houseServiceCell.houseServiceTitle.attributedText=[[NSAttributedString alloc]initWithString: houseServiceCell.houseServiceTitle.text attributes:attributes];
        
        
        
        houseServiceCell.descBtn.goods=goods;
        [houseServiceCell.descBtn addTarget:self action:@selector(showDesc2:) forControlEvents:UIControlEventTouchUpInside];
        
        return houseServiceCell;

    
    }

}


-(void)showDesc:(MyButton *)btn{
    NSLog(@"准备进入信息详情");
    NSLog(@"tempstring=%@",tempstring);
    
    MessageDescViewController *myBtn=[[self storyboard] instantiateViewControllerWithIdentifier:@"messageDescVC"];
    
    Goods *good=[[Goods alloc] init];
    
    myBtn.goods=btn.goods;
    good.goodsID=btn.goods.goodsID;
    
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=tempstring;
    myBtn.goodFoods=gfoods;
    [self.navigationController pushViewController:myBtn animated:YES];
    
}


-(void)showDesc2:(MyButton *)btn{
    NSLog(@"准备进入美食详情");
    NSLog(@"tempstring2=%@",tempstring);
    
    GoodFoodsDescTableViewController *myBtn=[[self storyboard] instantiateViewControllerWithIdentifier:@"goodFoodsDescTVC"];
    
    Goods *good=[[Goods alloc] init];
    
    myBtn.goods=btn.goods;
    good.goodsID=btn.goods.goodsID;
    
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.typeId=tempstring;
    myBtn.goodFoods=gfoods;
    [self.navigationController pushViewController:myBtn animated:YES];
    
}



@end
