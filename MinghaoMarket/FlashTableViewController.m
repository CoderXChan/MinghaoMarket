//
//  FlashTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#define ZCGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define ZCMainQueue dispatch_get_main_queue()


#import "FlashTableViewController.h"
#import "FlashTableViewCell.h"
#import "GoodsListCollectionViewController.h"
#import "Goods.h"
#import "Feed.h"
#import "Picture.h"
#import "FlashGoods.h"
#import "FlashGoodsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"

@interface FlashTableViewController ()<FeedDelegate>{
    NSInteger _page;
    UIColor *testColor;
}

@end

@implementation FlashTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _page=0;
    
    self.feed.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)updateDoing{
    _page=0;
    //[self.feed loadPage:_page size:self.pageSize];
    [self.feed loadFlashPage:_page size:self.pageSize];
    NSLog(@"self.flash.feed==%@",self.feed);
}


-(void)feed:(Feed *)feed didFinishLoadGoods:(NSArray *)goods{
    if (_page==0) {
        [self.tableView reloadData];
        self.tableView.contentInset=UIEdgeInsetsZero;
    }else{
        NSMutableArray *arr=[NSMutableArray arrayWithCapacity:goods.count];
        NSInteger start=_page * _pageSize;
        for (NSInteger i=0; i<goods.count; i++) {
            [arr addObject:[NSIndexPath indexPathForRow:i+start inSection:0]];
            
        }
        [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
    }
    //self.hasMore=goods!=nil;
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return 10;
    if ([self.feed.flashGoods count]==0) {
        return 0;
    }
    NSLog(@"self.flash.feed.goods.count==%lu",(unsigned long)[self.feed.goods count]);
    return [self.feed.flashGoods count];
}

//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200.0;
    
}


#pragma mark - cell填充
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"fcell";
    FlashTableViewCell *flashCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (flashCell==nil) {
        flashCell=[[FlashTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    FlashGoods *good=[self.feed.flashGoods objectAtIndex:indexPath.row];
    
    
    

    //FlashGoods *good=[self.feed.flashGoods objectAtIndex:indexPath.row];
    //FlashTableViewCell  *flashCell=(FlashTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"fcell" forIndexPath:indexPath];

    if (![good.flashGoodsName isKindOfClass:[NSNull class]]) {
        flashCell.flashTitle.text=good.flashGoodsName;
    }else{
        flashCell.flashTitle.text=@" ";
    }
    
    
    if (![good.flashGoodsDiscount isKindOfClass:[NSNull class]]) {
        flashCell.flashDiscount.text=good.flashGoodsDiscount;
    }else{
        flashCell.flashDiscount.text=@" ";
    }
    
    
    if (![good.flashGoodsDiscountTime isKindOfClass:[NSNull class]]) {
        flashCell.flashRestTime.text=good.flashGoodsDiscountTime;
    }else{
        flashCell.flashRestTime.text=@" ";
    }
    
    
    Picture *picture=good.thumbPicture;
    if (picture) {
        
        if (picture.pictureData) {
            //  开通子线程加载图片
            dispatch_async(ZCGlobalQueue, ^{
                UIImage *image = [UIImage imageWithData:picture.pictureData];
                dispatch_async(ZCMainQueue, ^{
                    [flashCell.flashImage setImage:image];
                });
            });
//            flashCell.flashImage.image=[UIImage imageWithData:picture.pictureData];
        }else{
            flashCell.flashImage.image=[UIImage imageNamed:@"wemall_picture_default"];
            [self.feed loadPicture:picture putOffLoadHandler:^(NSData *data){
                flashCell.flashImage.image=[UIImage imageWithData:data];
                
            }];
        }
    }


    //按钮传值
    flashCell.flashBtn.flashGoods=good;
    [flashCell.flashBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return flashCell;
    
    
}



-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"限时活动商品列表");
    FlashGoodsTableViewController *g=[self.storyboard instantiateViewControllerWithIdentifier:@"flashGoodsTVC"];
    FlashGoods *flashGood=[[FlashGoods alloc] init];
    g.fgoods=btn.flashGoods;
    flashGood.flashGoodsID=btn.flashGoods.flashGoodsID;
    NSLog(@"btn.flashGoods.flashGoodsID=%@",btn.flashGoods.flashGoodsID);
    NSLog(@"flashGoods.flashGoodsID=%@",flashGood.flashGoodsID);
    
    LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
    [logService showFlashGoods:flashGood.flashGoodsID];

    
    
    [self.navigationController  pushViewController:g animated:YES];

    
}





@end
