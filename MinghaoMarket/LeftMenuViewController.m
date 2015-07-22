//
//  LeftMenuViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/15.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "MenuLeftTableViewCell.h"
#import "User.h"
#import "UserLoginViewController.h"
@interface LeftMenuViewController ()

- (IBAction)myBtnClick:(id)sender;


- (IBAction)collectionBtnClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *myImage;


@property (strong, nonatomic) IBOutlet UIImageView *collectionImage;



@end

@implementation LeftMenuViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self.slideOutAnimationEnabled=NO;
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.scrollEnabled=NO;
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
    
    
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftMenu.jpg"]];
    //self.tableView.backgroundView = imageView;
    
    self.view.layer.borderWidth = .6;
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    

    self.myImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myBtnClick:)];
    [self.myImage addGestureRecognizer:singleTap];
    
    
    self.collectionImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionBtnClick:)];
    [self.collectionImage addGestureRecognizer:singleTap1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43.0;
    
}




#pragma mark - 左侧栏目内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    //MenuLeftTwoTableViewCell *cellTwo=[tableView dequeueReusableCellWithIdentifier:@"leftMenuTwoCell"];
    switch (indexPath.row)
    {
        case 0:
            cell.menuLeftTitle.text = @"首页";
            //cell.menuLeftTitle.textColor=[UIColor whiteColor];
            cell.menuLeftImage.image=[UIImage imageNamed:@"home"];
            break;
            
        case 1:
            cell.menuLeftTitle.text = @"美妆";
            
            cell.menuLeftImage.image=[UIImage imageNamed:@"meizhuang"];
            break;
        
        case 2:
            cell.menuLeftTitle.text = @"服饰";
            cell.menuLeftImage.image=[UIImage imageNamed:@"fushi"];
            break;
            
        case 3:
            cell.menuLeftTitle.text = @"居家";
            cell.menuLeftImage.image=[UIImage imageNamed:@"jiaju"];
            break;
        
        case 4:
            cell.menuLeftTitle.text = @"汽车";
            cell.menuLeftImage.image=[UIImage imageNamed:@"car"];
            break;
        
        case 5:
            cell.menuLeftTitle.text = @"旅游";
            cell.menuLeftImage.image=[UIImage imageNamed:@"airport"];
            break;
        
        case 6:
            cell.menuLeftTitle.text = @"信息";
            cell.menuLeftImage.image=[UIImage imageNamed:@"information"];
            break;
        
        case 7:
            cell.menuLeftTitle.text = @"美食";
            cell.menuLeftImage.image=[UIImage imageNamed:@"food"];
            break;
            
            /*
        
        case 8:
            
            cell.menuLeftTitle.text = @"我的";
            cell.menuLeftImage.image=[UIImage imageNamed:@"p8"];
            break;
        
        case 9:
            cell.menuLeftTitle.text = @"收藏";
            cell.menuLeftImage.image=[UIImage imageNamed:@"p9"];
            break;
             */
    }
    
    
    cell.selectedBackgroundView=[[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:31/255.0 green:33/255.0 blue:36/255.0 alpha:1];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.menuLeftTitle.textColor=[UIColor whiteColor];
    return cell;
}

#pragma mark - 点击哪个cell跳转到VC
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    UIViewController *vc ;
    
    switch (indexPath.row)
    {
        case 0:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"hpvc"];
            break;
            
        case 1:
            
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuFirstBtvc"];
            break;
        
        case 2:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuSecondTVC"];
            break;
        
        case 3:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuThirdTVC"];
            break;
        
        case 4:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuFourthTVC"];
            break;
            
        case 5:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuFifthTVC"];
            break;
        
        case 6:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuSixthTVC"];
            break;
        case 7:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuseventhTVC"];
            break;
            /*
        case 8:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuEighthTVC"];
            break;
        case 9:
            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuNinthTVC"];
            break;*/
        
        case 8:
            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
            [[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
            return;
            break;
    }
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
}



- (IBAction)myBtnClick:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    UIViewController *vc ;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuEighthTVC"];
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
}

- (IBAction)collectionBtnClick:(id)sender {
    if ([User getCurrentUser]!=NULL) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        UIViewController *vc ;
        vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"menuNinthTVC"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];
    }else{
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle: nil];
        
        UIViewController *vc ;
        vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"userLoginVC"];
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                         andCompletion:nil];

    }

    
    
    }
@end
