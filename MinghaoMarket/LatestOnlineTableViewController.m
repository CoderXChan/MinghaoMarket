//
//  LatestOnlineTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/7.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#define ZCGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define ZCMainQueue dispatch_get_main_queue()
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)//设备宽

#import "LatestOnlineTableViewController.h"
#import "CycleScrollView.h"
#import "PageIndicator.h"
#import "Feed.h"
#import "SpecialTableViewCell.h"
#import "OrdinaryTableViewCell.h"
#import "GoodsDetailsTableViewController.h"
#import "Picture.h"
#import "GoodsListCollectionViewController.h"
#import "Goods.h"
#import "MyButton.h"
#import "LatestOnlineGoodsMsgService.h"
#import "UIImageView+WebCache.h"
@interface LatestOnlineTableViewController ()<FeedDelegate,CycleScrollViewDelegate,UIScrollViewDelegate>{
    NSMutableArray *tempArray;
    NSInteger _page;
    NSMutableArray *focusImageArray;
    NSMutableArray *twoSmallFocusImageArray;
    UIColor *testColor;
}



@property (strong, nonatomic) IBOutlet UIView *moreView;




//焦点图片
@property (strong, nonatomic) IBOutlet UIScrollView *focusImageScrollView;


//加载
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *focusImageActivityIndi;


@property (weak, nonatomic) IBOutlet CycleScrollView *cycleView;

@property (weak, nonatomic) IBOutlet PageIndicator *indiView;


@property(nonatomic)BOOL hasMore;
@end

@implementation LatestOnlineTableViewController
@synthesize homePageHeaderImage,homePageTwoSmallImage;
-(void)setHasMore:(BOOL)hasMore{
    _hasMore=hasMore;
    self.moreView.hidden=!hasMore;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    [_focusImageScrollView setScrollEnabled:YES];
    [_focusImageScrollView setPagingEnabled:YES];
    
//    self.cycleView.frame = CGRectMake(self.cycleView.frame.origin.x, self.cycleView.frame.origin.x, [UIScreen mainScreen].bounds.size.width, self.cycleView.frame.size.height);
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    
    _focusImageActivityIndi.hidden=YES;
    
    
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    homePageHeaderImage=[api showLatestOnlineHeaderImage];
    NSLog(@"home=%@",homePageHeaderImage);
    focusImageArray=[[NSMutableArray alloc] init];
    Goods *goods=[homePageHeaderImage objectAtIndex:0];
    for (Picture *picture in goods.thumbPictures) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [focusImageArray addObject:picture.pictureURL];
        }
    }

    
    //MingHaoApiService *api=[[MingHaoApiService alloc] init];
    homePageTwoSmallImage=[api showLatestOnlineTwoSmallImage];
    NSLog(@"home=%@",homePageTwoSmallImage);
    twoSmallFocusImageArray=[[NSMutableArray alloc] init];
    goods=[homePageTwoSmallImage objectAtIndex:0];
    for (Picture *picture in goods.thumbPictures) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [twoSmallFocusImageArray addObject:picture.pictureURL];
            
        }
    }
    

    
    
    /*
    focusImageArray=[[NSMutableArray alloc] init];
    [focusImageArray addObject:@"c1"];
    [focusImageArray addObject:@"c2"];
    [focusImageArray addObject:@"c6"];
    [focusImageArray addObject:@"c9"];
    */
    _page=0;
    self.indiView.currentPageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_active"];
    self.indiView.pageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_inactive"];
    self.indiView.sizeOfIndicator = CGSizeMake(8.0f, 12.0f);
    self.indiView.space=3.0f;

    
    self.feed.delegate=self;
    
    
    self.hasMore=NO;
    
     self.indiView.numberOfPages=focusImageArray.count;
     self.indiView.currentPage=0;
     [self.cycleView reload];
    
    MingHaoApiService *aApi=[[MingHaoApiService alloc] init];
    homePageHeaderImage=[aApi showLatestOnlineHeaderImage];
    [self.tableView reloadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
//    MingHaoApiService *api=[[MingHaoApiService alloc] init];
//    homePageHeaderImage=[api showLatestOnlineHeaderImage];
//    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}


-(void)updateDoing{
    _page=0;
    //self.feed.delegate=self;
    [self.feed loadPage:_page size:self.pageSize];
    NSLog(@"self.latest.feed==%@",self.feed);
}



//多少页
-(NSInteger) numberOfPages:(CycleScrollView *) cycleScrollView{
    NSLog(@"f=%lu",(unsigned long)[focusImageArray count]);
    return [focusImageArray count];
    
}

- (UIView *) cycleScrollView:(CycleScrollView *) cycleScrollView viewForPage:(NSInteger)page reusingView:(UIView *) view{
    UIImageView *focusImageView;
    if (view) {
        focusImageView=(UIImageView *)view;
    }else{
        focusImageView=[[UIImageView alloc] init];
    }
    
    focusImageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[focusImageArray objectAtIndex:page]]]];
    return focusImageView;
}

- (void) cycleScrollView:(CycleScrollView *) cycleScrollView scrollToPage:(NSInteger) page{
    
    self.indiView.currentPage=page;
}

//#pragma mark hhhh
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
   
    //return 6;
    
    if ([self.feed.goods count]==0) {
        return 0;
    }
     NSLog(@"self.feed.goods.count==%lu",(unsigned long)[self.feed.goods count]);
    return [self.feed.goods count]+1;
    
   

}

//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([ indexPath indexAtPosition: 1 ] == 0){
        return 150.0;
    }else{
        return 200.0;
    }

}



#pragma mark - 在这里改加载图片的操作
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0){
        SpecialTableViewCell *sCell=(SpecialTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"stcell" forIndexPath:indexPath];
        sCell.sTitle.text=@"新特卖 · 每天早10晚8点上新";
        [sCell.sTitle.font fontWithSize:14.0];
        
        //  新特卖2张图片的加载
        
        //  开通子线程
        dispatch_async(ZCGlobalQueue, ^{
            // 子线程下载图片
            UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[twoSmallFocusImageArray objectAtIndex:0]]]];
            UIImage *image2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[twoSmallFocusImageArray objectAtIndex:1]]]];
//            [NSThread currentThread].name = [NSString stringWithFormat:@"子线程"];
//            NSLog(@"----------------%@------------------",[NSThread currentThread]);
            //  回到主线程设置图片
            dispatch_async(ZCMainQueue, ^{
                [sCell.sImage1 setImage:image1];
                [sCell.sImage2 setImage:image2];
//                NSLog(@"-----------------------%@------------------",[NSThread currentThread]);
            });
        });
        
//        sCell.sImage1.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[twoSmallFocusImageArray objectAtIndex:0]]]];
//        sCell.sImage2.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[twoSmallFocusImageArray objectAtIndex:1]]]];
       
        
        sCell.sImage1.userInteractionEnabled=YES;
        sCell.sImage2.userInteractionEnabled=YES;
        return sCell;
    }else{
        static NSString *CellIdentifier = @"otcell";
        OrdinaryTableViewCell *oCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (oCell==nil) {
            oCell=[[OrdinaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        Goods *good=[self.feed.goods objectAtIndex:indexPath.row-1];
        
        //Goods *good=[self.feed.goods objectAtIndex:indexPath.row-1];
        testColor= [UIColor colorWithRed:255/255.0 green:110/255.0 blue:255/255.0 alpha:1];
        
        if (![good.shopName isKindOfClass:[NSNull class]]) {
            oCell.oTitle.text=good.shopName;
        }else{
            oCell.oTitle.text=@" ";
        }
        
        
        if (![good.goodsDiscount isKindOfClass:[NSNull class]]) {
            oCell.oDisCount.text=good.goodsDiscount;
        }else{
            oCell.oDisCount.text=@" ";
        }
        
        

        
        oCell.oDisCount.textColor=testColor;

        for (Picture *picture in good.thumbPictures) {
            if (picture.pictureData) {
//                dispatch_async(ZCGlobalQueue, ^{
//                    UIImage *image = [UIImage imageWithData:picture.pictureData];
//                    dispatch_async(ZCMainQueue, ^{
//                        [oCell.oImage setImage:image];
//                    });
//                });
                oCell.oImage.image=[UIImage imageWithData:picture.pictureData];
            }else{
                
            // 调用feed里的频道方法
                oCell.oImage.image=[UIImage imageNamed:@"wemall_picture_default"];
                [self.feed loadPicture:picture putOffLoadHandler:^(NSData *data){
                    oCell.oImage.image=[UIImage imageWithData:data];
                }];
            }
        }
        
        //自定义按钮传值
        oCell.showMsgBtn.goods=good;
        
        [oCell.showMsgBtn addTarget:self action:@selector(showGoodsListCollection:) forControlEvents:UIControlEventTouchUpInside];
        
        return oCell;
    }
    
    return nil;
    
}

-(void)showGoodsListCollection1{
    GoodsDetailsTableViewController *g=[self.storyboard instantiateViewControllerWithIdentifier:@"goodsDetailsTVC"];
    [self.navigationController  pushViewController:g animated:YES];



}


-(void)showGoodsListCollection:(MyButton *)btn{
    NSLog(@"商品列表");

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


// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = _indiView.currentPage; // 获取当前的page
    //[_focusImageScrollView scrollRectToVisible:CGRectMake(375*(page+1),0,375,160) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
    [_focusImageScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*page,0) animated:YES];
    NSLog(@"page==%li",(long)page);
    
}

#pragma mark - 定时器 绑定的方法
- (void)runTimePage
{
    NSInteger page = _indiView.currentPage; // 获取当前的page
    page++;
    page = page > 5 ? 0 : page ;
    _indiView.currentPage = page;
    [self turnPage];
}






@end
