//
//  BeautyMakeupBoutiqueTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/9.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "BeautyMakeupBoutiqueTableViewController.h"
#import "BeautyMakeupBoutiqueTableViewCell.h"
#import "GoodsListCollectionViewController.h"
#import "Feed.h"
#import "Goods.h"
#import "GoodsDetailsTableViewController.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface BeautyMakeupBoutiqueTableViewController ()<FeedDelegate>{
    NSInteger _page;
    
}


@property (strong, nonatomic) IBOutlet UIView *moreView;



@property (weak, nonatomic) IBOutlet UIImageView *bmbHeaderImage;


@property(nonatomic)BOOL hasMore;

@end

@implementation BeautyMakeupBoutiqueTableViewController
@synthesize homePageImage;
-(void)setHasMore:(BOOL)hasMore{
    _hasMore=hasMore;
    self.moreView.hidden=!hasMore;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bmbHeaderImage.image=[UIImage imageNamed:@"c8"];
    
    /*
    self.bmbHeaderImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsListCollection:)];
    [self.bmbHeaderImage addGestureRecognizer:singleTap];*/
    
    
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
    homePageImage=[api showBeautyHeaderImage];
    Goods *goods=[homePageImage objectAtIndex:0];
    Picture *picture=goods.thumbPicture;
    if (picture) {
        if (picture.pictureURL) {
            _bmbHeaderImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
            
        }else{
            _bmbHeaderImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        }
    }
    
    
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}


-(void)updateDoing{
    _page=0;
    //self.feed.delegate=self;
    [self.feed loadPage:_page size:self.pageSize];
    NSLog(@"self.channel==%@",self.feed);
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
    NSLog(@"self.beauty.feed.goods.count==%lu",(unsigned long)[self.feed.goods count]);
    return [self.feed.goods count];
}


//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91.0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"bmbcell";
    BeautyMakeupBoutiqueTableViewCell *bmbCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (bmbCell==nil) {
        bmbCell=[[BeautyMakeupBoutiqueTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    Goods *good=[self.feed.goods objectAtIndex:indexPath.row];
    
    

    
    //Goods *good=[self.feed.goods objectAtIndex:indexPath.row];
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:15]};
    //BeautyMakeupBoutiqueTableViewCell  *bmbCell=(BeautyMakeupBoutiqueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"bmbcell" forIndexPath:indexPath];
    
    //bmbCell.bmbGoodsImage.image=[UIImage imageNamed:@"a"];
    
    bmbCell.bmbPersonImage.image=[UIImage imageNamed:@"c"];
    bmbCell.bmbBuyPersonNum.text=@"1450";
    bmbCell.bmbShopCar.image=[UIImage imageNamed:@"b"];
    //bmbCell.bmbGoodsDescribe.text=@"花糧 白茶祛黄美白面膜组合(白茶祛黄防辐射亮白美颜)";
    
    if (![good.shopName isKindOfClass:[NSNull class]]) {
        bmbCell.bmbGoodsDescribe.text=good.shopName;
    }else{
        bmbCell.bmbGoodsDescribe.text=@"null";
    }
    
    
    //NSLog(@"bmbCell.bmbGoodsDescribe.text=%@",bmbCell.bmbGoodsDescribe.text);
    
    bmbCell.bmbGoodsDescribe.attributedText=[[NSAttributedString alloc]initWithString: bmbCell.bmbGoodsDescribe.text attributes:attributes];//设置字体大小

    //bmbCell.nowPrice.text=@"47";
    if (![good.goodsPrice isKindOfClass:[NSNull class]]) {
        bmbCell.nowPrice.text=good.goodsPrice;
    }else{
        bmbCell.nowPrice.text=@"null";
    }
    
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"148"];
  
    [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 3)];
    bmbCell.bmbGoodsOldPrice.attributedText=str;
  
        //  开通子线程
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //  加载
    dispatch_async(queue, ^{
        for (Picture *picture  in good.thumbPictures) {
            if (picture.pictureData) {
                UIImage *bmbGoodsImageDownLoad = [UIImage imageWithData:picture.pictureData];
//                bmbCell.bmbGoodsImage.image=[UIImage imageWithData:picture.pictureData];
                //  回到主线程设置图片
                dispatch_async(dispatch_get_main_queue(), ^{
                    [bmbCell.bmbGoodsImage setImage:bmbGoodsImageDownLoad];
                });
            }else{
                bmbCell.bmbGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
                [self.feed loadPicture:picture putOffLoadHandler:^(NSData *data){
                    bmbCell.bmbGoodsImage.image=[UIImage imageWithData:data];
                }];
            }
            
        }
        
    });
    
    
    
//    for (Picture *picture  in good.thumbPictures) {
//        if (picture.pictureData) {
//            bmbCell.bmbGoodsImage.image=[UIImage imageWithData:picture.pictureData];
//        }else{
//            bmbCell.bmbGoodsImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//            [self.feed loadPicture:picture putOffLoadHandler:^(NSData *data){
//                bmbCell.bmbGoodsImage.image=[UIImage imageWithData:data];
//            }];
//        }
//    }
//    
    
    
    bmbCell.beautyBtn.goods=good;
    
    
    [bmbCell.beautyBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    bmbCell.bmbGoodsImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsListCollection:)];
    [bmbCell.bmbGoodsImage addGestureRecognizer:singleTap];
    */
    return bmbCell;
    
}


-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"美妆商品列表");
    
    
    GoodsDetailsTableViewController *myBtn=[[self storyboard] instantiateViewControllerWithIdentifier:@"goodsDetailsTVC"];
    
    Goods *good=[[Goods alloc] init];
    
    myBtn.goods=btn.goods;
    good.goodsID=btn.goods.goodsID;
    
    
    NSLog(@"latestgoodsid=%@",btn.goods.goodsID);
    NSLog(@"latestgoodsid222=%@",good.goodsID);
    
    LatestOnlineGoodsMsgService *logService=[[LatestOnlineGoodsMsgService alloc] init];
    [logService showLatestOnlineGoodsMsg:good.goodsID];
    
    
    [self.navigationController pushViewController:myBtn animated:YES];
    
    
    
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"100%专柜正品";
}





@end
