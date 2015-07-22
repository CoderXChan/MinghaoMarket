//
//  InTheSaleTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/20.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "InTheSaleTableViewController.h"
#import "InTheSaleTableViewCell.h"
#import "MingHaoApiService.h"
#import "Store.h"
#import "UIImageView+WebCache.h"
@interface InTheSaleTableViewController ()

@end

@implementation InTheSaleTableViewController
@synthesize myStoreGoodsMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setEdgesForExtendedLayout:UIRectEdgeBottom];// important!解决tableview与标题之间空白   以及界面显示和操作存在的问题
    
    
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        myStoreGoodsMsg=[api inTheSaleGoods:[User getUserID]];
    }

    
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
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
    return [myStoreGoodsMsg count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"inTheSaleCell";
    InTheSaleTableViewCell *inTheSaleCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (inTheSaleCell==nil) {
        
        inTheSaleCell=[[InTheSaleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Store *store=[myStoreGoodsMsg objectAtIndex:indexPath.row];
 
    
    if (![store.storeGoodsName isKindOfClass:[NSNull class]]) {
        inTheSaleCell.InTheSaleGoodsName.text=store.storeGoodsName;
    }else{
        inTheSaleCell.InTheSaleGoodsName.text=@"null";
    }
            
            
    if (![store.storeGoodsPrice isKindOfClass:[NSNull class]]) {
        inTheSaleCell.InTheSaleGoodsPrice.text=store.storeGoodsPrice;
    }else{
        inTheSaleCell.InTheSaleGoodsPrice.text=@"null";
    }
            
            
            
    if (![store.storeGoodsDesc isKindOfClass:[NSNull class]]) {
        inTheSaleCell.InTheSaleGoodsNote.text=store.storeGoodsDesc;
    }else{
        inTheSaleCell.InTheSaleGoodsNote.text=@"null";
    }
            
            
    Picture *picture=store.storeGoodsImage;
        if (picture) {
            
            [inTheSaleCell.InTheSaleGoodsImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
//            if (picture.pictureURL) {
//                inTheSaleCell.InTheSaleGoodsImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//                    
//            }else{
//                inTheSaleCell.InTheSaleGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
    }

    
    return inTheSaleCell;

}



@end
