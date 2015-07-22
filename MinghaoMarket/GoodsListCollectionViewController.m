//
//  GoodsListCollectionViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/11.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "GoodsListCollectionViewController.h"
#import "GoodsListCollectionViewCell.h"
#import "GoodsDetailsTableViewController.h"
#import "StarShopGoods.h"
#import "StarGoodsDetailsTableViewController.h"
#import "StarShopGoodsService.h"
#import "UIImageView+WebCache.h"
@interface GoodsListCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSMutableArray *tempGoodsListArray;
    int i;
}



@end

@implementation GoodsListCollectionViewController
@synthesize goods;
static NSString * const reuseIdentifier = @"glcvcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    tempGoodsListArray=[[NSMutableArray alloc]init];
    for (i=1; i<=6; i++) {
        [tempGoodsListArray addObject:[[NSString alloc ]initWithFormat: @"as%i.png",i]];
    }
    
    NSLog(@"%@",tempGoodsListArray);*/
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

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"goodsliststarshopid=%@",goods.starShopId);
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    tempGoodsListArray=[api showStarShopGoods:goods.starShopId];
    
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
    
    if ([tempGoodsListArray count]==0) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"该店铺暂时没有商品" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [av show];
    }

    
    return [tempGoodsListArray count];
}
#pragma mark - 图片下载使用了SD,可修改
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    StarShopGoods *starGoods=[tempGoodsListArray objectAtIndex:indexPath.row];
    

    /*
    if (![starGoods.starShopGoodsImage isKindOfClass:[NSNull class]]) {
        for (Picture *picture in starGoods.starShopGoodsImage) {
            if (picture.pictureURL) {
                NSString *purl=picture.pictureURL;
                cell.goodsListImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:purl]]];
                
            }
        }
    }else{
        cell.goodsListImage.image=[UIImage imageNamed:@"wemall_picture_default"];
    
    }*/
    
    
    Picture *picture=starGoods.thumbPicture;
    
//    if (picture) {
//        if (picture.pictureURL) {
//            
            [cell.goodsListImage sd_setImageWithURL:[NSURL URLWithString:picture.pictureURL] placeholderImage:[UIImage imageNamed:@"wemall_picture_default"]];
//            cell.goodsListImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:picture.pictureURL]]];
//            
//        }else{
//            cell.goodsListImage.image=[UIImage imageNamed:@"wemall_picture_default"];
//        }
//    }

    
    
    
    
    if (![starGoods.starShopGoodsName isKindOfClass:[NSNull class]]) {
        cell.goodsListName.text=starGoods.starShopGoodsName;
    }else{
        cell.goodsListName.text=@"null";
    }
    
    
    if (![starGoods.starShopGoodsDiscount isKindOfClass:[NSNull class]]) {
        cell.goodsListDiscount.text=starGoods.starShopGoodsDiscount;
    }else{
        cell.goodsListDiscount.text=@"null";
    }
    
    
    
    
    // Configure the cell
    //cell.goodsListImage.image=[UIImage imageNamed:[tempGoodsListArray objectAtIndex:indexPath.row]];
    cell.starShopGoodsBtn.trueStarGoods=starGoods;
    
    
    //cell.goodsListImage.userInteractionEnabled=YES;
    //UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGoodsListCollection:)];
    //[cell.goodsListImage addGestureRecognizer:singleTap];
    
    [cell.starShopGoodsBtn addTarget:self action:@selector(showStarShopGoodsDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}


-(void)showStarShopGoodsDetails:(MyButton *)btn{
    NSLog(@"明星店铺商品详情");
    
    StarGoodsDetailsTableViewController *g=[self.storyboard instantiateViewControllerWithIdentifier:@"starGoodsDetailsTVC"];
    StarShopGoods *sg=[[StarShopGoods alloc] init];
    g.starGoods=btn.trueStarGoods;
    g.starGoods=btn.trueStarGoods;
    sg.starShopGoodsId=btn.trueStarGoods.starShopGoodsId;
    
    
    NSLog(@"stargoodsid==%@",btn.trueStarGoods.starShopGoodsId);
    NSLog(@"stargoodsid==%@",sg.starShopGoodsId);
    
    StarShopGoodsService *starService=[[StarShopGoodsService alloc] init];
    [starService showStarShopGOODSMsg:sg.starShopGoodsId];
    
    [self.navigationController  pushViewController:g animated:YES];
}


//决定单个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(140, 192);
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


#pragma mark <UICollectionViewDelegate>

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
