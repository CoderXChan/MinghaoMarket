//
//  MyStoreViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/20.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MyStoreViewController.h"
#import "InTheSaleTableViewController.h"
#import "OffTheShelvesTableViewController.h"
#import "MyStoreFeed.h"
#import "MyStoreFeedService.h"
#import "MenuEighthTableViewController.h"
#import "AddMyGoodsViewController.h"
#import "MingHaoApiService.h"
#import "Store.h"
@interface MyStoreViewController ()<UIScrollViewDelegate>{
    NSString *moneyGiveYesOrNo;

}



@property (strong, nonatomic) IBOutlet UIScrollView *myStoreTitleScrollView;



@property (strong, nonatomic) IBOutlet UIScrollView *myStoreGoodsScrolView;

@property(strong,nonatomic)NSArray *myStoreTitleArray;//出售中  已下架

@property(assign,nonatomic)NSInteger theTitleIndex;

@property (strong, nonatomic) IBOutlet UIImageView *myStoreImage;


@property (strong, nonatomic) IBOutlet UILabel *myStoreName;



@end

@implementation MyStoreViewController
@synthesize store,myStoreMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"我的店铺";

    self.myStoreTitleArray=[[[MyStoreFeedService alloc] init] allMyStoreFeeds];
    
    
    NSLog(@"ms%@",self.myStoreTitleArray);
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(OnRightButton:)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    //self.myStoreName.text=self.store.storeName;
    
    
    
    //显示我的店铺的一些信息
    if ([User getCurrentUser]!=NULL) {
        MingHaoApiService *api=[[MingHaoApiService alloc]init];
        myStoreMsg=[api showMyStoreMsg:[User getUserID]];
        Store *st=[myStoreMsg objectAtIndex:0];
        
        
        
        if (![st.myStoreName isKindOfClass:[NSNull class]]) {
            _myStoreName.text=st.myStoreName;
        }else{
            _myStoreName.text=@"**";
        }
        
        
        if (![st.myStorePicture.pictureURL isKindOfClass:[NSNull class]]) {
            _myStoreImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:st.myStorePicture.pictureURL]]];
        }else{
            _myStoreImage.image=[UIImage imageNamed:@"wemall_picture_default"];
        }
        
        
        
        moneyGiveYesOrNo=st.moneyGiveYesOrNo;
        NSLog(@"moneygiveyesorno=%@",moneyGiveYesOrNo);

        //设置图片为圆
        _myStoreImage.layer.cornerRadius = _myStoreImage.frame.size.width / 2;
        _myStoreImage.clipsToBounds = YES;
    
    }
    
    
    
}


-(void)OnRightButton:(id)sender{
    if (![moneyGiveYesOrNo isEqualToString:@"2"]) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"店铺未激活，请激活。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [av show];
        
    }else{
        AddMyGoodsViewController *addMyGoods=[self.storyboard instantiateViewControllerWithIdentifier:@"addMyGoodsVC"];
        [self.navigationController pushViewController:addMyGoods animated:YES];
    }
}


-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    if (![self.myStoreName.text isEqualToString:@""]) {
        MenuEighthTableViewController *metvc=[self.storyboard instantiateViewControllerWithIdentifier:@"menuEighthTVC"];
        [self.navigationController pushViewController:metvc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
    
    
    
    //[_sideSlipView switchMenu];
}



-(void)setMyStoreTitleArray:(NSArray *)myStoreTitleArray{
    if (myStoreTitleArray!=_myStoreTitleArray) {
        _myStoreTitleArray=myStoreTitleArray;
        [self myStoreTitleBtnDo];
        [self myStoreBodyPagesInit];
        [self loadMyStoreFeedWithIndex:0];
    }

}


-(void)loadMyStoreFeedWithIndex:(NSInteger)index{
    InTheSaleTableViewController *itstvc=[self.childViewControllers objectAtIndex:index];
    
    
    //[lotvc updateDoing];
    CGPoint point=itstvc.tableView.frame.origin;
    [self.myStoreGoodsScrolView  setContentOffset:point animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//初始化头部按钮--
-(void)myStoreTitleBtnDo{
    [_myStoreTitleScrollView.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];//移除原来视图
    
    if (self.myStoreTitleArray &&self.myStoreTitleArray.count>0) {
        
        
        UIFont *fontSize=[UIFont systemFontOfSize:15];
        CGRect size=CGRectZero;//给个容器
        NSDictionary *attrs=@{NSFontAttributeName:fontSize};
        //测试两个长度字符串的宽度
        NSString *tempString=@"出售中";
        CGSize strSize=[tempString sizeWithAttributes:attrs];
        size.origin.y=(_myStoreTitleScrollView.bounds.size.height-strSize.height)/2;//确定标题的y坐标  频道在scroview Y  居中
        size.size.height=strSize.height;
        
        int allWidth=0;
        size.origin.x=80;
        
        _myStoreTitleScrollView.pagingEnabled=NO;
        _myStoreTitleScrollView.showsHorizontalScrollIndicator=NO;
        _myStoreTitleScrollView.bounces=YES;//靠齐左右边缘
        
        MyStoreFeed *feed;//
        
        for (int i=0; i<self.myStoreTitleArray.count; i++){
            UIButton *headTitleBtn=[[UIButton alloc]init];
            feed=[self.myStoreTitleArray objectAtIndex:i];
            
            allWidth=[feed.name sizeWithAttributes:attrs].width;
            
            size.size.width=allWidth;
            headTitleBtn.frame=size;
            [headTitleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            
            [headTitleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            headTitleBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            [headTitleBtn setTitle:feed.name forState:UIControlStateNormal];
            headTitleBtn.tag=100+i;
            
            [headTitleBtn addTarget:self action:@selector(headTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_myStoreTitleScrollView addSubview:headTitleBtn];
            size.origin.x+=120+allWidth;//频道相邻字间隔距离
            
            //设置titlescrollview  contentsize
            CGSize cgsize=self.myStoreTitleScrollView.bounds.size;
            cgsize.width=headTitleBtn.frame.origin.x+headTitleBtn.frame.size.width;
            _myStoreTitleScrollView.contentSize=cgsize;
        }
        
        
        
        [self.view addSubview:_myStoreTitleScrollView];
        UIButton *selectBtn=(UIButton *)[self.view viewWithTag:100];
        selectBtn.selected=YES;
        
        
        
    }
}



-(void)myStoreBodyPagesInit{
    //移除原来布局约束
    NSArray *constraintsItems=self.myStoreGoodsScrolView.constraints;
    [_myStoreGoodsScrolView removeConstraints:constraintsItems];
    [_myStoreGoodsScrolView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //移除子视图布局约束
    NSArray *childConstraintsItems=self.childViewControllers;
    for (UIViewController *item in childConstraintsItems) {
        [item removeFromParentViewController];
    }
    
    _myStoreGoodsScrolView.delegate=self;//执行这个方法时，它的代理方法会执行
    _myStoreGoodsScrolView.pagingEnabled=YES;
    _myStoreGoodsScrolView.bounces=NO;
    _myStoreGoodsScrolView.showsHorizontalScrollIndicator=NO;
    //_mhBodyPageScrollView.showsVerticalScrollIndicator=NO;
    //_mhBodyPageScrollView.scrollEnabled=NO;是否可以滚动
    
    if (self.myStoreTitleArray &&self.myStoreTitleArray.count>0) {
        
        UIScrollView *bodyScrollView=self.myStoreGoodsScrolView;
        
        //禁止系统自动产生约束
        bodyScrollView.translatesAutoresizingMaskIntoConstraints=NO;
        //加入tablecontroller子控制器
        //LatestOnlineTableViewController *lotvc;
        //StarShopTableViewController *sstvc;//--
        
        
        NSMutableDictionary *tableViewDic=[NSMutableDictionary dictionary];
        [tableViewDic setObject:_myStoreGoodsScrolView forKey:@"mhbodyScrollView"];
        NSInteger count=self.myStoreTitleArray.count;
        
        UIViewController *viewCon;
        for (int i=0; i<count; i++) {
            //lotvc.feed=[self.mhTitleArray objectAtIndex:i];
            if (i==0) {
                viewCon=[[InTheSaleTableViewController alloc] init];
                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"inTheSaleVC"];
                
                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
                
            }
            
            if (i==1) {
                viewCon=[[OffTheShelvesTableViewController alloc] init];
                viewCon=[[self storyboard] instantiateViewControllerWithIdentifier:@"offTheShelvesTVC"];
                
                viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
            }
            
            
            viewCon.view.tag=1000+i;
            
            
            viewCon.view.translatesAutoresizingMaskIntoConstraints=NO;
            
            
            [self addChildViewController:viewCon];
            
            
            [_myStoreGoodsScrolView addSubview:viewCon.view];
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

//标题频道选中点击事件--
-(void)headTitleBtnClick:(id)sender{
    UIButton *btn=(UIButton *)sender;
    [self setTheTitleIndex:btn.tag-100];

}


-(void)setTheTitleIndex:(NSInteger)theTitleIndex{
    if (_theTitleIndex!=theTitleIndex) {
        UIButton *nowBtn=(UIButton *)[self.view viewWithTag:_theTitleIndex+100];
        UIButton *nextBtn=(UIButton *)[self.view viewWithTag:theTitleIndex+100];
        
        _theTitleIndex=theTitleIndex;
        [nowBtn setSelected:NO];
        [nextBtn setSelected:YES];
    
        //定位
        _myStoreGoodsScrolView.contentOffset=CGPointMake(theTitleIndex*self.view.bounds.size.width, 0);
    
        [self loadMyStoreFeedWithIndex:theTitleIndex];
    }





}

#pragma mark - 滑动时调用的方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


//判断SCROLLVIEW趋向哪一边--
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.theTitleIndex=targetContentOffset->x/scrollView.frame.size.width;
    
}






@end
