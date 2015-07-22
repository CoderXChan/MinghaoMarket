//
//  MessageDescViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/7/1.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MessageDescViewController.h"
#import "MingHaoApiService.h"
#import "MessageDesc.h"
#import "HouseServiceTableViewController.h"
@interface MessageDescViewController (){
    //NSString *string;
    NSString *tempString;
}


@property (strong, nonatomic) IBOutlet UIImageView *messageDescImage;

@property (strong, nonatomic) IBOutlet UILabel *messageDescName;


@property (strong, nonatomic) IBOutlet UILabel *messageDescDesc;


@property (strong, nonatomic) IBOutlet UILabel *messageDescType;


@property (strong, nonatomic) IBOutlet UILabel *messageDescTime;


@property (strong, nonatomic) IBOutlet UILabel *messageDescPrice;


@end

@implementation MessageDescViewController
@synthesize messageDescArray,goods,goodFoods;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"信息详情";
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;

    
    
    tempString=goodFoods.typeId;
    //string=goodFoods.type;
    NSLog(@"goodsidasd==%@",tempString);
    
    MingHaoApiService *api=[[MingHaoApiService alloc]init];
    messageDescArray=[api showMsgDesc:goods.goodsID];
    MessageDesc *desc=[messageDescArray objectAtIndex:0];
    
    if (![desc.messageDescName isKindOfClass:[NSNull class]]) {
        _messageDescName.text=desc.messageDescName;
    }else{
         _messageDescName.text=@"null";
    }
    
    
    if (![desc.messageDescDesc isKindOfClass:[NSNull class]]) {
        _messageDescDesc.text=desc.messageDescDesc;
    }else{
        _messageDescDesc.text=@"null";
    }

    
    if (![desc.messageDescType isKindOfClass:[NSNull class]]) {
        _messageDescType.text=desc.messageDescType;
    }else{
        _messageDescPrice.text=@"null";
    }
    
    
    if (![desc.messageDescMoney isKindOfClass:[NSNull class]]) {
        _messageDescPrice.text=desc.messageDescMoney;
    }else{
        _messageDescPrice.text=@"null";
    }
    
    
    
    if (![desc.messageDescTime isKindOfClass:[NSNull class]]) {
        _messageDescTime.text=desc.messageDescTime;
    }else{
        _messageDescTime.text=@"null";
    }
    
    
    if (![desc.messageDescImage.pictureURL isKindOfClass:[NSNull class]]) {
        _messageDescImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:desc.messageDescImage.pictureURL]]];
    }else{
        _messageDescImage.image=[UIImage imageNamed:@"wemall_picture_default"];
    }
    
    
    //_messageDescImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:desc.messageDescImage.pictureURL]]];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)goBackAction{
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.type=@"0";
    gfoods.typeId=tempString;
    HouseServiceTableViewController *metvc=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    metvc.goodFoods=gfoods;
    [self.navigationController pushViewController:metvc animated:YES];
}



@end
