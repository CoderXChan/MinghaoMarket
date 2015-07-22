//
//  GoodFoodsDescTableViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/7/1.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "GoodFoodsDescTableViewController.h"
#import "MingHaoApiService.h"
#import "GoodFoods.h"
#import "GoodFoodsFirstTableViewCell.h"
#import "HouseServiceTableViewController.h"
#import "GoodFoodsSecondTableViewCell.h"
#import "CycleScrollView.h"
#import "PageIndicator.h"
#import "Picture.h"
@interface GoodFoodsDescTableViewController ()<UIScrollViewDelegate,CycleScrollViewDelegate>{
    //NSString *string;
    NSMutableArray *focusImageArray;
    NSString *tempString;
    int s;
    int y;
    NSMutableArray *focusImageArray2;
}


@property (strong, nonatomic) IBOutlet UIView *footerView;


@property (strong, nonatomic) IBOutlet UIView *buyNowView;






@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewImage;



@property (strong, nonatomic) IBOutlet CycleScrollView *cycleView;


@property (strong, nonatomic) IBOutlet PageIndicator *indiView;

@end

@implementation GoodFoodsDescTableViewController
@synthesize goodFoodsDetails,goodFoods,goods;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollViewImage setScrollEnabled:YES];
    
    //_headerImage.image=[UIImage imageNamed:@"wemall_picture_default"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    tempString=goodFoods.typeId;
    
    
    NSLog(@"asdas=%@",goods.goodsID);
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    goodFoodsDetails=[api showFoodsDesc:goods.goodsID];
    
    
    _buyNowView.layer.cornerRadius=3;
    _buyNowView.layer.masksToBounds=YES;
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.bounces=NO;
    
    
    
    focusImageArray=[[NSMutableArray alloc] init];
    GoodFoods *gfoods;
    gfoods=[goodFoodsDetails objectAtIndex:0];
    //NSLog(@"lolgoods==%@",lolGoods.thumbPictures);
    for (Picture *picture in gfoods.thumbPictures) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [focusImageArray addObject:picture.pictureURL];
            
        }
    }
    
    
    
    
    focusImageArray2=[[NSMutableArray alloc] init];
    for (Picture *picture in gfoods.thumbPictures2) {
        if (![picture.pictureURL isKindOfClass:[NSNull class]]) {
            //NSLog(@"pu==%@",picture.pictureURL);
            [focusImageArray2 addObject:picture.pictureURL];
            
        }
    }
    NSLog(@"focusImageArray2=%@",focusImageArray2);

    
    
    
    self.indiView.currentPageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_active"];
    self.indiView.pageImage = [UIImage imageNamed:@"feed_focus_pagecontrol_inactive"];
    self.indiView.sizeOfIndicator = CGSizeMake(8.0f, 12.0f);
    self.indiView.space=3.0f;
    
    
    //NSLog(@"ssd=%lu",(unsigned long)[focusImageArray count]);
    
    self.indiView.numberOfPages=[focusImageArray count];
    self.indiView.currentPage=0;
    [self.cycleView reload];

    
    
    
}

//多少页
-(NSInteger) numberOfPages:(CycleScrollView *) cycleScrollView{
    
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


-(void)goBackAction{
    GoodFoods *gfoods=[[GoodFoods alloc] init];
    gfoods.type=@"2";
    gfoods.typeId=tempString;
    HouseServiceTableViewController *metvc=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
    metvc.goodFoods=gfoods;
    [self.navigationController pushViewController:metvc animated:YES];
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
    NSLog(@"goodscount=%lu",(unsigned long)[goodFoodsDetails count]);
    return 1+[focusImageArray2 count];
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _footerView.layer.borderWidth=1.0;
    _footerView.layer.borderColor=[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    
    return _footerView;
    
}



//定义cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([ indexPath indexAtPosition: 1 ] == 0){
        return 96.0;
    }else if([indexPath indexAtPosition:2]==1){
        return 197.0;
    }
    return 197.0;
    
}



-(void)viewWillAppear:(BOOL)animated{
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    goodFoodsDetails=[api showFoodsDesc:goods.goodsID];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        GoodFoods *gfoods;
        gfoods=[goodFoodsDetails objectAtIndex:indexPath.row];
        GoodFoodsFirstTableViewCell *oneCell=(GoodFoodsFirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"goodFoodsFirstCell" forIndexPath:indexPath];
        
        if (![gfoods.foodsDescName isKindOfClass:[NSNull class]]) {
            oneCell.foodsFirstName.text=gfoods.foodsDescName;
        }else{
            oneCell.foodsFirstName.text=@"null";
        }
        
        
        if(![gfoods.foodsDescMoney isKindOfClass:[NSNull class]]){
            oneCell.foodsFirstMoney.text=gfoods.foodsDescMoney;
        }else{
            oneCell.foodsFirstMoney.text=@"null";
        }
        
        if (![gfoods.foodsDescDesc isKindOfClass:[NSNull class]]) {
            oneCell.foodsFirstDesc.text=gfoods.foodsDescDesc;
        }else{
            oneCell.foodsFirstDesc.text=@"null";
        }
        
        //oneCell.collectionBtn.imageView.image=[UIImage imageNamed:@"2015042702082798_easyicon_net_33.0217706821"];
        oneCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return oneCell;
    }else{
        GoodFoodsSecondTableViewCell *threeCell=(GoodFoodsSecondTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"goodFoodsSecondCell" forIndexPath:indexPath];
        threeCell.selectionStyle=UITableViewCellSelectionStyleNone;

        for (int i=0;i<[focusImageArray2 count];i++) {
            NSString *s1=[focusImageArray2 objectAtIndex:i];
            NSLog(@"s=%@",s1);
            threeCell.goodFoodsSecondImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[focusImageArray2 objectAtIndex:indexPath.row-1]]]];
        }

        
        
        //threeCell.goodFoodsSecondImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        return threeCell;
    }
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    s=self.tableView.frame.size.height;
    y=_footerView.frame.size.height;
    _footerView.frame=CGRectMake(_footerView.frame.origin.x, s+self.tableView.contentOffset.y-y, _footerView.frame.size.width, _footerView.frame.size.height);
    
}



@end
