//
//  StarShopTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#define ZCGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define ZCMainQueue dispatch_get_main_queue()

#import "StarShopTableViewController.h"
#import "StarShopTableViewCell.h"
#import "GoodsListCollectionViewController.h"
#import "Goods.h"
#import "Feed.h"
#import "Picture.h"
#import "MyButton.h"
#import "StarShopGoodsService.h"
#import "MingHaoApiService.h"
#import "UIImageView+WebCache.h"

@interface StarShopTableViewController ()<FeedDelegate>{
    NSInteger _page;
}


@property (strong, nonatomic) IBOutlet UIView *moreView;

@property (weak, nonatomic) IBOutlet UIImageView *focusImage;

@property(nonatomic)BOOL hasMore;

@end

@implementation StarShopTableViewController
@synthesize homePageImage;
-(void)setHasMore:(BOOL)hasMore{
    _hasMore=hasMore;
    self.moreView.hidden=!hasMore;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //star shop focusimage
    self.focusImage.image=[UIImage imageNamed:@"as100"];
    
    _page=0;
    self.feed.delegate=self;
    self.hasMore=NO;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    homePageImage=[api showStarShopHeaderImage];
    Goods *goods=[homePageImage objectAtIndex:0];
    Picture *picture=goods.thumbPicture;
    if (picture) {
        if (picture.pictureURL) {
            _focusImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
            
        }else{
            _focusImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        }
    }
    
    
    [self.tableView reloadData];
    
    
    [super viewWillAppear:animated];
}


-(void)updateDoing{
    _page=0;
    
    [self.feed loadPage:_page size:self.pageSize];
    NSLog(@"self.stat.feed==%@",self.feed);
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
    self.hasMore=goods!=nil;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.feed.goods count]==0) {
        return 0;
    }
    NSLog(@"star count==%lu",(unsigned long)[self.feed.goods count]);
    return [self.feed.goods count];
    
}

#pragma mark - 定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0;
    
}


#pragma mark - 图片加载
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"sstcell";
    StarShopTableViewCell *sstcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (sstcell==nil) {
        sstcell=[[StarShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *good=[self.feed.goods objectAtIndex:indexPath.row];
    
    
    sstcell.goodsImage.image=[UIImage imageNamed:@"start"];
    sstcell.shopImage.image=[UIImage imageNamed:@"start_touxiang"];
    //sstcell.shopNameLable.text=@"7号公主名店";
    sstcell.fansNum.text=@"6824";
    sstcell.scoreNum.text=@"4.8";
        

    
    if (![good.starShopName isKindOfClass:[NSNull class]]) {
        sstcell.shopNameLable.text=good.starShopName;
    }else{
        sstcell.shopNameLable.text=@"**";
    }
    
    
    
    if (![good.shopLevelId isKindOfClass:[NSNull class]]) {
        sstcell.salesNum.text=good.shopLevelId;
    }else{
        sstcell.salesNum.text=@"**";
    }

    
    if (![good.shopDetail isKindOfClass:[NSNull class]]) {
        sstcell.goodsNum.text=good.shopDetail;
    }else{
        sstcell.goodsNum.text=@"**";
    }
    
         
    Picture *picture=good.thumbPicture;
    if (picture) {
        if (picture.pictureData) {
            dispatch_async(ZCGlobalQueue, ^{
                UIImage *image = [UIImage imageWithData:picture.pictureData];
                dispatch_async(ZCMainQueue, ^{
                    [sstcell.goodsImage setImage:image];
                });
            });
//            sstcell.goodsImage.image=[UIImage imageWithData:picture.pictureData];
        }else{
            sstcell.goodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
            [self.feed loadPicture:picture putOffLoadHandler:^(NSData *data){
                    sstcell.goodsImage.image=[UIImage imageWithData:data];
         
            }];
        }
    }

    
    sstcell.showGoods.starGoods=good;
    [sstcell.showGoods addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    return sstcell;

}


-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"明星店铺商品列表");
    
    GoodsListCollectionViewController *glc=[self.storyboard instantiateViewControllerWithIdentifier:@"glcvc"];
    Goods *good=[[Goods alloc] init];
    glc.goods=btn.starGoods;
    good.starShopId=btn.starGoods.starShopId;
    
    NSLog(@"good.starShopId=%@",good.starShopId);
    NSLog(@"btn.goods.starShopId=%@",btn.starGoods.starShopId);
    
    //调查看明星店铺商品接口（传店铺id）
    StarShopGoodsService *starService=[[StarShopGoodsService alloc] init];
    [starService showStarShopGoods:good.starShopId];

    [self.navigationController  pushViewController:glc animated:YES];
    
    
}




@end
