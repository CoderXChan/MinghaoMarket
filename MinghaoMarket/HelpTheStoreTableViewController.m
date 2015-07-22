//
//  HelpTheStoreTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/10.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "HelpTheStoreTableViewController.h"
#import "HelpTheStoreTableViewCell.h"
#import "GoodsListCollectionViewController.h"
#import "Feed.h"
#import "Goods.h"
#import "StarShopGoodsService.h"
#import "MingHaoApiService.h"
#import "UIImageView+WebCache.h"
@interface HelpTheStoreTableViewController ()<FeedDelegate>{
    NSInteger _page;
    
}


@property (strong, nonatomic) IBOutlet UIView *moreView;

@property(nonatomic)BOOL hasMore;


@property (strong, nonatomic) IBOutlet UIImageView *headerImage;


@end

@implementation HelpTheStoreTableViewController
@synthesize homePageImage;
-(void)setHasMore:(BOOL)hasMore{
    _hasMore=hasMore;
    self.moreView.hidden=!hasMore;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //star shop focusimage
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
    homePageImage=[api showHelpShopHeaderImage];
    Goods *goods=[homePageImage objectAtIndex:0];
    Picture *picture=goods.thumbPicture;
    
    //  加载图片
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
//    if (picture) {
//        if (picture.pictureURL) {
//            _headerImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//            
//        }else{
//            _headerImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
//    }
    

    [super viewWillAppear:animated];
}

-(void)updateDoing{
    _page=0;
    //self.feed.delegate=self;
    [self.feed loadPage:_page size:self.pageSize];
    NSLog(@"self.help.feed==%@",self.feed);
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
    NSLog(@"self.help.feed.count==%lu",(unsigned long)[self.feed.goods count]);
    return [self.feed.goods count];
   
}


//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150.0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"htscell";
    HelpTheStoreTableViewCell *htscell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (htscell==nil) {
        htscell=[[HelpTheStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *good=[self.feed.goods objectAtIndex:indexPath.row];
    
    
    
    //Goods *good=[self.feed.goods objectAtIndex:indexPath.row];
    //HelpTheStoreTableViewCell *htscell=(HelpTheStoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"htscell" forIndexPath:indexPath];
    
    //htscell.htsGoodsImage.image=[UIImage imageNamed:@"start"];
    htscell.htsShopImage.image=[UIImage imageNamed:@"start_touxiang"];
    //htscell.htsShopName.text=@"8号公主名店";
    
    if (![good.goodsName isKindOfClass:[NSNull class]]) {
        htscell.htsShopName.text=good.goodsName;
    }else{
        
        htscell.htsShopName.text=@"null";
    }
    
    
    if (![good.shopDetail isKindOfClass:[NSNull class]]) {
        htscell.htsFansNum.text=good.shopDetail;
    }else{
        
        htscell.htsFansNum.text=@"null";
    }
    
    
    
    //htscell.htsFansNum.text=@"2342";
    
    htscell.htsGoodsNum.text=@"456";
    htscell.htsSaleNum.text=@"2365";
    htscell.htsScore.text=@"4.9";
    
    
    
    Picture *picture=good.thumbPicture;
    if (picture) {
        if (picture.pictureData) {
            htscell.htsGoodsImage.image=[UIImage imageWithData:picture.pictureData];
        }else{
            htscell.htsGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
            [self.feed loadPicture:picture putOffLoadHandler:^(NSData *data){
                htscell.htsGoodsImage.image=[UIImage imageWithData:data];
                
            }];
        }
    }

    
    htscell.helpShopBtn.starGoods=good;
    [htscell.helpShopBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    /*
    htscell.htsGoodsImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsListCollection:)];
    [htscell.htsGoodsImage addGestureRecognizer:singleTap];*/
    return htscell;
    
}



-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"帮扶店铺商品列表");
    
    GoodsListCollectionViewController *g=[self.storyboard instantiateViewControllerWithIdentifier:@"glcvc"];
    
    
    
    Goods *good=[[Goods alloc] init];
    g.goods=btn.starGoods;
    good.starShopId=btn.starGoods.starShopId;
    
    NSLog(@"good.starShopId=%@",good.starShopId);
    NSLog(@"btn.goods.starShopId=%@",btn.starGoods.starShopId);
    
    //调查看明星店铺商品接口（传店铺id）
    StarShopGoodsService *starService=[[StarShopGoodsService alloc] init];
    [starService showStarShopGoods:good.starShopId];
 

    [self.navigationController  pushViewController:g animated:YES];
    
    
}


@end
