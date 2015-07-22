//
//  OffTheShelvesTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/20.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "OffTheShelvesTableViewController.h"
#import "OffTheShelvesTableViewCell.h"
#import "MingHaoApiService.h"
#import "Store.h"
#import "UIImageView+WebCache.h"
@interface OffTheShelvesTableViewController ()

@end

@implementation OffTheShelvesTableViewController
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
        myStoreGoodsMsg=[api outTheSaleGoods:[User getUserID]];
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

    return [myStoreGoodsMsg count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"offTheShelvesCell";
    OffTheShelvesTableViewCell *offTheSaleCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (offTheSaleCell==nil) {
        
        offTheSaleCell=[[OffTheShelvesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Store *store=[myStoreGoodsMsg objectAtIndex:indexPath.row];
  
            
    if (![store.storeGoodsName isKindOfClass:[NSNull class]]) {
        offTheSaleCell.offTheShelvesGoodsName.text=store.storeGoodsName;
    }else{
        offTheSaleCell.offTheShelvesGoodsName.text=@"null";
    }
            
            
    if (![store.storeGoodsDesc isKindOfClass:[NSNull class]]) {
        offTheSaleCell.offTheShelvesGoodsState.text=store.storeGoodsDesc;
    }else{
        offTheSaleCell.offTheShelvesGoodsState.text=@"null";
    }
            
            
    Picture *picture=store.storeGoodsImage;
    if (picture) {
//        if (picture.pictureURL) {
//            offTheSaleCell.offTheShelvesImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//                    
//        }else{
//            offTheSaleCell.offTheShelvesImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
        [offTheSaleCell.offTheShelvesImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
    }
            
            
  
 
    return offTheSaleCell;

}


@end
