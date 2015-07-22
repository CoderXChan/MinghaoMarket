//
//  AddMyGoodsViewController.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/16.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"
@class TableViewWithBlock;
@interface AddMyGoodsViewController : UIViewController{
    BOOL isOpened;
}


@property (strong, nonatomic) IBOutlet UITextView *goodsDesc;

@property (strong, nonatomic) IBOutlet UITextField *goodsName;

@property (strong, nonatomic) IBOutlet UITextField *goodsPrice;

@property (strong, nonatomic) IBOutlet UITextField *goodsBrand;

@property (strong, nonatomic) IBOutlet UITextField *goodsDiscount;

@property (strong, nonatomic) IBOutlet UITextField *goodsStyle;

@property (strong, nonatomic) IBOutlet UITextField *goodsPlace;


//一张图片
@property (copy,nonatomic) NSString *theGoodsShowImageName;


//商品滚动图片
@property (copy,nonatomic) NSString *theGoodsDescImageName1;
@property (copy,nonatomic) NSString *theGoodsDescImageName2;
@property (copy,nonatomic) NSString *theGoodsDescImageName3;
@property (copy,nonatomic) NSString *theGoodsDescImageName4;
@property (copy,nonatomic) NSString *theGoodsDescImageName5;




//商品详情图片
@property (copy,nonatomic) NSString *theGoodsDescImageName6;
@property (copy,nonatomic) NSString *theGoodsDescImageName7;
@property (copy,nonatomic) NSString *theGoodsDescImageName8;
@property (copy,nonatomic) NSString *theGoodsDescImageName9;
@property (copy,nonatomic) NSString *theGoodsDescImageName10;



//下拉选择
@property (retain, nonatomic) IBOutlet UITextField *inputTextField;



@property (strong, nonatomic) IBOutlet UILabel *typeID;



@property (retain, nonatomic) IBOutlet UIButton *openButton;


@property (retain, nonatomic) IBOutlet TableViewWithBlock *tb;


- (IBAction)changeStauts:(id)sender;




@property(retain,nonatomic)NSMutableArray *goodsTypeArray;



@property(retain,nonatomic)NSMutableArray *myStoreArray;








@end
