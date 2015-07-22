//
//  MenuGoodsListCollectionViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/22.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MenuGoodsListCollectionViewController.h"
#import "MenuGoodsListCollectionViewCell.h"
#import "GoodsDetailsTableViewController.h"
@interface MenuGoodsListCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>{
    NSMutableArray *tempGoodsListArray;
    int i;
}


@end

@implementation MenuGoodsListCollectionViewController

static NSString * const reuseIdentifier = @"menuGoodsListCvCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    tempGoodsListArray=[[NSMutableArray alloc]init];
    for (i=1; i<=8; i++) {
        [tempGoodsListArray addObject:[[NSString alloc ]initWithFormat: @"gridview%i.png",i]];
    }
    
    NSLog(@"%@",tempGoodsListArray);
    /*
     UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(OnBackButton)];
     leftButtonItem.tintColor=[UIColor blackColor];
     self.navigationItem.backBarButtonItem=leftButtonItem;
     */
    
    //自定义返回按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
}


-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuGoodsListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.menuGoodsListImage.image=[UIImage imageNamed:[tempGoodsListArray objectAtIndex:indexPath.row]];
    
    cell.menuGoodsListImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsListCollection:)];
    [cell.menuGoodsListImage addGestureRecognizer:singleTap];
    return cell;
}


-(void)showGoodsListCollection:()sender{
    NSLog(@"商品详情");
    
}

/*
- (void)imageViewTap:(UITapGestureRecognizer *)sender {
    self.view.backgroundColor = [UIColor greenColor];
    NSLog(@"单击手势");
    return;
}*/

#pragma mark <UICollectionViewDelegate>


//决定单个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(135, 210);
}


//决定cell的前后左右的长度
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(7.5, 15, 7.5, 15);
    
    
}


//行与行的上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

//左右
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


/*
 //头部的高度，假如是另外一种竖着的方式的话，则为（100，0）
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
 return CGSizeMake(0, 100);
 
 }
 
 - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
 return CGSizeMake(0, 100);
 }*/


//当前选中
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /*NSInteger row = [indexPath row];
     [tempArray removeObjectAtIndex:row];
     NSArray *deleteItems = @[indexPath];
     [self.collectionView deleteItemsAtIndexPaths:deleteItems];
     
     */
        
    
    //footReusaview.image2.image=[UIImage imageNamed:[tempArray objectAtIndex:indexPath.row]];
    NSLog(@"%@",[tempGoodsListArray objectAtIndex:indexPath.row]);
    
    //image
    
}




/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
