//
//  MingHaoHomePageViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/7.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MingHaoHomePageViewController.h"
#import "Feed.h"
#import "FeedService.h"
#import "LatestOnlineTableViewController.h"
#import "StarShopTableViewController.h"
#import "FlashTableViewController.h"
#import "BeautyMakeupBoutiqueTableViewController.h"
#import "HelpTheStoreTableViewController.h"
#import "ShoppingCarTableViewController.h"
#import "MenuFirstTableViewController.h"
#import "LeftMenuViewController.h"
#import "MenuEighthTableViewController.h"
#import "CollectionTableViewController.h"
#import "User.h"
#import "UserLoginViewController.h"
#import "SearchGoodsTableViewController.h"
#import "ProvincesViewController.h"


@interface MingHaoHomePageViewController ()<UIScrollViewDelegate>{
    UIImage *leftBtn;
    UIImage *rightBtn;
    UIColor *testColor;
    UIColor *testColor1;
     __weak IBOutlet UILabel *province;
    
}


//@property (strong, nonatomic) IBOutlet UIView *threeBtnView;

//@property (strong, nonatomic) IBOutlet UIButton *mineBtn;


//我的
- (IBAction)mineBtnClick:(id)sender;


//收藏
- (IBAction)heartBtnClick:(id)sender;

//购物车
- (IBAction)shopCarBtnClick:(id)sender;





- (IBAction)goToSearchClick:(id)sender;





@property (strong, nonatomic) IBOutlet UIImageView *threeBtnImage;



@property(strong,nonatomic)NSArray *mhTitleArray;

@property(assign,nonatomic)NSInteger theTitleIndex;

@property (strong, nonatomic) IBOutlet UIScrollView *mhTitleScrollView;


@property (strong, nonatomic) IBOutlet UIScrollView *mhBodyPageScrollView;


@property (strong, nonatomic)UIProgressView *redProgressView;

@end

@implementation MingHaoHomePageViewController

- (void)viewDidLoad {
    self.scrollView.contentSize=CGSizeMake(self.view.frame.size.width, 503);
    [SlideNavigationController sharedInstance].portraitSlideOffset = 80;
    
    
    
    //改导航栏字体颜色
    testColor= [UIColor colorWithRed:255/255.0 green:110/255.0 blue:255/255.0 alpha:1];
    testColor1=[UIColor colorWithRed:31/255.0 green:33/255.0 blue:36/255.0 alpha:1];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:testColor}];
    
    
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    
    //设置左右按钮图片
    leftBtn=[UIImage imageNamed:@"20150407040053162_easyicon_net_32"];
    rightBtn=[UIImage imageNamed:@"20150505110928218_easyicon_net_24"];
    [self.navigationItem.leftBarButtonItem setImage:[leftBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationItem.rightBarButtonItem setImage:[rightBtn imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.mhTitleScrollView.backgroundColor=testColor1;
    
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeBottom];// important!解决tableview与标题之间空白   以及界面显示和操作存在的问题
    
    self.mhTitleArray=[[[FeedService alloc] init] allSubscribeFeeds];
    
    
    self.threeBtnImage.alpha=0.7;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *UD = [NSUserDefaults standardUserDefaults];
    if ([UD objectForKey:@"mainProvince"]) {
        province.text = [UD objectForKey:@"mainProvince"];
    }else{
        province.text = @"广东";
        [UD setObject:province.text forKey:@"mainProvince"];
        [UD synchronize];
    }
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

/*
- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return YES;
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//--
-(void)setMhTitleArray:(NSArray *)mhTitleArray{
    if (mhTitleArray!=_mhTitleArray) {
        _mhTitleArray=mhTitleArray;
        [self headTitleInit];
        [self bodyPagesInit];
        [self loadFeedWithIndex:0];
    }
}



//--
-(void)loadFeedWithIndex:(NSInteger)index{
    LatestOnlineTableViewController *lotvc=[self.childViewControllers objectAtIndex:index];
    
    
    [lotvc updateDoing];
    CGPoint point=lotvc.tableView.frame.origin;
    
    [self.mhBodyPageScrollView  setContentOffset:point animated:YES];
}


//初始化头部按钮--
-(void)headTitleInit{
    [_mhTitleScrollView.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];//移除原来视图
    
    if (self.mhTitleArray &&self.mhTitleArray.count>0) {
        
        
        UIFont *fontSize=[UIFont systemFontOfSize:15];
        CGRect size=CGRectZero;//给个容器
        NSDictionary *attrs=@{NSFontAttributeName:fontSize};
        //测试两个长度字符串的宽度
        NSString *tempString=@"新闻";
        CGSize strSize=[tempString sizeWithAttributes:attrs];
        size.origin.y=(_mhTitleScrollView.bounds.size.height-strSize.height)/2;//确定标题的y坐标  频道在scroview Y  居中
        size.size.height=strSize.height;
        
        int allWidth=0;
        size.origin.x=10;
        
        _mhTitleScrollView.pagingEnabled=NO;
        _mhTitleScrollView.showsHorizontalScrollIndicator=NO;
        _mhTitleScrollView.bounces=NO;//靠齐左右边缘
        
        Feed *feed;//
        
        for (int i=0; i<self.mhTitleArray.count; i++){
            UIButton *headTitleBtn=[[UIButton alloc]init];
            feed=[self.mhTitleArray objectAtIndex:i];
            
            allWidth=[feed.name sizeWithAttributes:attrs].width;
            
            size.size.width=allWidth;
            headTitleBtn.frame=size;
            [headTitleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            [headTitleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            headTitleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
            [headTitleBtn setTitle:feed.name forState:UIControlStateNormal];
            headTitleBtn.tag=100+i;
            
            [headTitleBtn addTarget:self action:@selector(headTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_mhTitleScrollView addSubview:headTitleBtn];
            size.origin.x+=20+allWidth;//频道相邻字间隔距离
            
            //设置titlescrollview  contentsize
            CGSize cgsize=self.mhTitleScrollView.bounds.size;
            cgsize.width=headTitleBtn.frame.origin.x+headTitleBtn.frame.size.width;
            _mhTitleScrollView.contentSize=cgsize;
        }
        
        
        
        [self.view addSubview:_mhTitleScrollView];
        UIButton *selectBtn=(UIButton *)[self.view viewWithTag:100];
        selectBtn.selected=YES;
        
        
        //滚动条
        //#FF1493
        //testColor= [UIColor colorWithRed:255/255.0 green:00/255.0 blue:255/255.0 alpha:1];
        _redProgressView=[[UIProgressView alloc] init];
        CGRect rect1=selectBtn.frame;
        _redProgressView.progress=1;
        _redProgressView.progressTintColor=testColor;
        _redProgressView.trackTintColor=testColor;
        rect1.origin.y=_mhTitleScrollView.bounds.size.height-8.0f;
        rect1.origin.x=selectBtn.frame.origin.x;//初始位置
        _redProgressView.frame=rect1;
        [_mhTitleScrollView addSubview:_redProgressView];
    }
}




//--
-(void)bodyPagesInit{
    //移除原来布局约束
    NSArray *constraintsItems=self.mhBodyPageScrollView.constraints;
    [_mhBodyPageScrollView removeConstraints:constraintsItems];
    [_mhBodyPageScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //移除子视图布局约束
    NSArray *childConstraintsItems=self.childViewControllers;
    for (UIViewController *item in childConstraintsItems) {
        [item removeFromParentViewController];
    }
    
    _mhBodyPageScrollView.delegate=self;//执行这个方法时，它的代理方法会执行
    _mhBodyPageScrollView.pagingEnabled=YES;
    _mhBodyPageScrollView.bounces=NO;
    _mhBodyPageScrollView.showsHorizontalScrollIndicator=NO;
    //_mhBodyPageScrollView.showsVerticalScrollIndicator=NO;
    //_mhBodyPageScrollView.scrollEnabled=NO;是否可以滚动
    
    if (self.mhTitleArray &&self.mhTitleArray.count>0) {
        
        UIScrollView *bodyScrollView=self.mhBodyPageScrollView;
        
        //禁止系统自动产生约束
        bodyScrollView.translatesAutoresizingMaskIntoConstraints=NO;
        
        
        NSMutableDictionary *tableViewDic=[NSMutableDictionary dictionary];
        [tableViewDic setObject:_mhBodyPageScrollView forKey:@"mhbodyScrollView"];
        NSInteger count=self.mhTitleArray.count;
        
        
        UIViewController *viewCon;

        for (int i=0; i<count; i++) {
            if (i==0) {
                viewCon=[[LatestOnlineTableViewController alloc] init];

                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"lotvc"];
                
                
                LatestOnlineTableViewController *lotvc=(LatestOnlineTableViewController *)viewCon;
                lotvc.feed=[self.mhTitleArray objectAtIndex:0];
                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
                
                
            }
            if (i==1) {
                viewCon=(StarShopTableViewController *)[[StarShopTableViewController alloc] init];
                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"sstvc"];
                
                
                StarShopTableViewController *sstvc=(StarShopTableViewController *)viewCon;
                sstvc.feed=[self.mhTitleArray objectAtIndex:1];
                
                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
                
                
                
            }
            
            if (i==2) {
                viewCon=(FlashTableViewController *)[[FlashTableViewController alloc] init];
                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"ftvc"];
                FlashTableViewController *ftvc=(FlashTableViewController *)viewCon;
                ftvc.feed=[self.mhTitleArray objectAtIndex:2];

                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
            }
            
            
            if (i==3) {
                viewCon=(BeautyMakeupBoutiqueTableViewController *)[[BeautyMakeupBoutiqueTableViewController alloc] init];
                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"bmbtvc"];
                
                BeautyMakeupBoutiqueTableViewController *bmbtvc=(BeautyMakeupBoutiqueTableViewController *)viewCon;
                bmbtvc.feed=[self.mhTitleArray objectAtIndex:3];
                
                
                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
            }
            
            if (i==4) {
                viewCon=(HelpTheStoreTableViewController *)[[HelpTheStoreTableViewController alloc] init];
                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"htstvc"];
                
                HelpTheStoreTableViewController *htstvc=(HelpTheStoreTableViewController *)viewCon;
                htstvc.feed=[self.mhTitleArray objectAtIndex:4];
                
                
                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
                
            }
            
            
            viewCon.view.tag=1000+i;
            
            
            viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;

            
            [self addChildViewController:viewCon];
            
           
            [_mhBodyPageScrollView addSubview:viewCon.view];
            viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
            //lotvc.view.backgroundColor=i%2==0?[UIColor blackColor]:[UIColor redColor];//分颜色
            [tableViewDic setObject:viewCon.view forKey:[NSString stringWithFormat:@"tableView_%i",i]];
        }
        
        //添加自动布局约束
        //横向对齐到左右
        [bodyScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView_0(==mhbodyScrollView)]" options:0 metrics:0 views:tableViewDic]];
        
        //纵向对齐到上下
        [bodyScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView_0(==mhbodyScrollView)]|" options:0 metrics:0 views:tableViewDic]];
        
        for (int i=1; i<count; i++) {
            [bodyScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[tableView_%i(==mhbodyScrollView)]",i] options:0 metrics:0 views:tableViewDic]];
            [bodyScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[tableView_%i(==mhbodyScrollView)]|",i] options:0 metrics:0 views:tableViewDic]];
            
            //设置相邻两个tableview间距
            [bodyScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[tableView_%i][tableView_%i]",i-1,i] options:0 metrics:0 views:tableViewDic]];
        }
        
        //最后一个tableview
        [bodyScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[tableView_%li]|",count-1] options:0 metrics:0 views:tableViewDic]];
        
    }
}



#pragma mark - 标题频道选中点击事件
-(void)headTitleBtnClick:(id)sender{
    UIButton *btn=(UIButton *)sender;
    [self setTheTitleIndex:btn.tag-100];
}



//--
-(void)setTheTitleIndex:(NSInteger)theTitleIndex{
    if (_theTitleIndex!=theTitleIndex) {
        UIButton *nowBtn=(UIButton *)[self.view viewWithTag:_theTitleIndex+100];
        UIButton *nextBtn=(UIButton *)[self.view viewWithTag:theTitleIndex+100];
        
        _theTitleIndex=theTitleIndex;
        [nowBtn setSelected:NO];
        [nextBtn setSelected:YES];
        
        CGRect rect=nextBtn.frame;
        rect.origin.y=_mhTitleScrollView.frame.size.height-8.0f;
        _redProgressView.frame=rect;
        
        //定位
        _mhBodyPageScrollView.contentOffset=CGPointMake(theTitleIndex*self.view.bounds.size.width, 0);
        
        //遮住字则移动()
        CGPoint point=self.mhTitleScrollView.contentOffset;
        CGFloat leftx=rect.origin.x-point.x;//得到左边隐藏了多少长度
        CGFloat rightx=(point.x+_mhTitleScrollView.frame.size.width)-(rect.origin.x+rect.size.width);//得到右边隐藏多少长度  为负数的话，就是隐藏了
        if (leftx<0) {
            point.x=point.x-8+leftx;
            [self.mhTitleScrollView setContentOffset:point animated:YES];
        }else if(rightx<0){
            point.x=point.x+8-rightx;
            [self.mhTitleScrollView setContentOffset:point animated:YES];
        }
        [self loadFeedWithIndex:theTitleIndex];
    }
}


//滑动时调用的方法--
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currIndex=self.theTitleIndex;
    
    if (_mhBodyPageScrollView==scrollView) {
        CGFloat width=self.mhBodyPageScrollView.frame.size.width;
        CGFloat scrollViewSetX=scrollView.contentOffset.x;
        CGFloat value=(scrollViewSetX-currIndex*width)/width;
        if (value!=0) {
            UIButton *currBtn=[_mhTitleScrollView.subviews objectAtIndex:currIndex];
            NSInteger targIndex=value >0 ? currIndex+1:currIndex-1;
            if (targIndex>=0 && targIndex<self.mhTitleArray.count) {
                UIButton *targBtn=[_mhTitleScrollView.subviews objectAtIndex:targIndex];
                
                CGRect rect=_redProgressView.frame;
                rect.size.width=(targBtn.frame.size.width-currBtn.frame.size.width)*fabs(value)+currBtn.frame.size.width;
                rect.origin.x=(targBtn.frame.origin.x-currBtn.frame.origin.x)*fabs(value)+currBtn.frame.origin.x;
                _redProgressView.frame=rect;
                
                //当红线滑到边缘被遮住时，titleScrollView随着移动
                CGFloat tempValue=_mhTitleScrollView.contentOffset.x;
                CGFloat redLineLeft=rect.origin.x-tempValue;
                CGFloat redLineRight=(tempValue+_mhTitleScrollView.frame.size.width)-(rect.origin.x+rect.size.width);
                if (redLineLeft<0) {
                    tempValue=tempValue+redLineLeft;
                    [self.mhTitleScrollView setContentOffset:CGPointMake(tempValue, 0) animated:NO];
                }else if(redLineRight<0){
                    tempValue=tempValue-redLineRight;
                    [self.mhTitleScrollView setContentOffset:CGPointMake(tempValue, 0) animated:NO];
                }
            }
        }
    }
}


//判断SCROLLVIEW趋向哪一边--
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.theTitleIndex=targetContentOffset->x/scrollView.frame.size.width;
    
}







- (IBAction)mineBtnClick:(id)sender {
    MenuEighthTableViewController *metvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuEighthTVC"];
    [self.navigationController pushViewController:metvc animated:YES];

}

- (IBAction)heartBtnClick:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        CollectionTableViewController *ctvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuNinthTVC"];
        [self.navigationController pushViewController:ctvc animated:YES];
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];
        
        
    }

    
    
}

- (IBAction)shopCarBtnClick:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        ShoppingCarTableViewController *sctvc=[self.storyboard instantiateViewControllerWithIdentifier:@"shopCarTVC"];
        [self.navigationController pushViewController:sctvc animated:YES];
        
    }else{
        UserLoginViewController *ulvc=[self.storyboard instantiateViewControllerWithIdentifier:@"userLoginVC"];
        [self.navigationController  pushViewController:ulvc animated:YES];
        
        
    }
}

- (IBAction)goToSearchClick:(id)sender {
    SearchGoodsTableViewController *eetvc=[self.storyboard instantiateViewControllerWithIdentifier:@"searchGoodsTVC"];
    [self.navigationController pushViewController:eetvc animated:YES];
    
    
    
}
- (IBAction)getProvine:(id)sender {
    ProvincesViewController *vc = [[ProvincesViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
