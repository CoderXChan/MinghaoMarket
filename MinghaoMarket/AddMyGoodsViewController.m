//
//  AddMyGoodsViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/5/16.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "AddMyGoodsViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "LSNet.h"
#import "MyUiview.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectionCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "MingHaoApiService.h"
#import "GoodsType.h"
#import "Store.h"
#import "MyStoreViewController.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@interface AddMyGoodsViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,VPImageCropperDelegate>{
    NSString *goodsTypeString;
    int choose;
    int choose1;
    NSString *line;
}



//商品显示图片
@property (strong, nonatomic) IBOutlet UIImageView *goodsOneImage;



//商品滚动图片

@property (strong, nonatomic) IBOutlet UIImageView *goodsManyImage1;

@property (strong, nonatomic) IBOutlet UIImageView *goodsManyImage2;

@property (strong, nonatomic) IBOutlet UIImageView *goodsManyImage3;

@property (strong, nonatomic) IBOutlet UIImageView *goodsManyImage4;

@property (strong, nonatomic) IBOutlet UIImageView *goodsManyImage5;


//商品滚动图片
@property (copy,nonatomic) NSMutableString *theGoodsImageNames;

@property (nonatomic, strong) UIImageView *portraitImageView;


//商品详情图片
@property (strong, nonatomic) IBOutlet UIImageView *goodsDescImage6;

@property (strong, nonatomic) IBOutlet UIImageView *goodsDescImage7;

@property (strong, nonatomic) IBOutlet UIImageView *goodsDescImage8;

@property (strong, nonatomic) IBOutlet UIImageView *goodsDescImage9;

@property (strong, nonatomic) IBOutlet UIImageView *goodsDescImage10;
//商品详情图片
@property (copy,nonatomic) NSMutableString *theGoodsDescImages;



@end

@implementation AddMyGoodsViewController
@synthesize theGoodsShowImageName,goodsName,goodsPrice,goodsBrand,goodsDesc,goodsDiscount,goodsPlace,goodsStyle,goodsTypeArray,myStoreArray;
@synthesize theGoodsDescImageName1,theGoodsDescImageName2,theGoodsDescImageName3,theGoodsDescImageName4,theGoodsDescImageName5;

@synthesize theGoodsDescImageName6,theGoodsDescImageName7,theGoodsDescImageName8,theGoodsDescImageName9,theGoodsDescImageName10;
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
    _theGoodsImageNames=[[NSMutableString alloc] init];
    _theGoodsDescImages=[[NSMutableString alloc] init];
    
    
    [_goodsManyImage2 setHidden:YES];
    [_goodsManyImage3 setHidden:YES];
    [_goodsManyImage4 setHidden:YES];
    [_goodsManyImage5 setHidden:YES];
    
    
    
    [_goodsDescImage7 setHidden:YES];
    [_goodsDescImage8 setHidden:YES];
    [_goodsDescImage9 setHidden:YES];
    [_goodsDescImage10 setHidden:YES];
    
    
    
    
    
    MingHaoApiService *api=[[MingHaoApiService alloc] init];
    goodsTypeArray=[api getGoodsType];
    
    
    isOpened=NO;
    [_tb initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return  [@"5" integerValue];
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        GoodsType *typeGoods;
        typeGoods=[goodsTypeArray objectAtIndex:indexPath.row];
        //[cell.lb setText:[NSString stringWithFormat:@"Select %ld",(long)indexPath.row]];
        [cell.lb setText:typeGoods.productTypeName];
        [cell.GoodsTypeId setText:typeGoods.productTypeId];
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _inputTextField.text=cell.lb.text;
        NSLog(@"_inputTextField=%@",_inputTextField.text);
        _typeID.text=cell.GoodsTypeId.text;
        goodsTypeString=_typeID.text;
        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    
    [_tb.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tb.layer setBorderWidth:2];
    
    
    
    
    //单图
    _goodsOneImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsOneImage addGestureRecognizer:portraitTap];
    [self loadPortrait];
    
    
    //滚动多图
    _goodsManyImage1.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsManyImage1 addGestureRecognizer:portraitTap1];
    
    
    _goodsManyImage2.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsManyImage2 addGestureRecognizer:portraitTap2];
    
    
    _goodsManyImage3.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsManyImage3 addGestureRecognizer:portraitTap3];
    
    _goodsManyImage4.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsManyImage4 addGestureRecognizer:portraitTap4];
    
    _goodsManyImage5.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsManyImage5 addGestureRecognizer:portraitTap5];

    
    
    
    
    
    
    //详情多图
    _goodsDescImage6.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsDescImage6 addGestureRecognizer:portraitTap6];
    
    
    _goodsDescImage7.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsDescImage7 addGestureRecognizer:portraitTap7];
    
    
    _goodsDescImage8.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsDescImage8 addGestureRecognizer:portraitTap8];
    
    _goodsDescImage9.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsDescImage9 addGestureRecognizer:portraitTap9];
    
    _goodsDescImage10.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_goodsDescImage10 addGestureRecognizer:portraitTap10];

    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"添加商品";
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(OnRightButton:)];
    rightButtonItem.tintColor=[UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
}



- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        //NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
        //UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        UIImage *protraitImg = [UIImage imageNamed:@"tianjia"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            //单图
            self.goodsOneImage.image = protraitImg;
            
            //滚动图
            self.goodsManyImage1.image = protraitImg;
            self.goodsManyImage2.image = protraitImg;
            self.goodsManyImage3.image = protraitImg;
            self.goodsManyImage4.image = protraitImg;
            self.goodsManyImage5.image = protraitImg;

            //详情图
            self.goodsDescImage6.image = protraitImg;
            self.goodsDescImage7.image = protraitImg;
            self.goodsDescImage8.image = protraitImg;
            self.goodsDescImage9.image = protraitImg;
            self.goodsDescImage10.image = protraitImg;

        });
    });
}


- (void)editPortrait :(UITapGestureRecognizer *)sender{
    if (sender.view.tag==0) {
        choose=0;
    }else if(sender.view.tag==1){
        choose=1;
        choose1=22;
    }else if(sender.view.tag==2){
        choose=2;
        choose1=22;
    }else if(sender.view.tag==3){
        choose=3;
        choose1=22;
    }else if(sender.view.tag==4){
        choose=4;
        choose1=22;
    }else if(sender.view.tag==5){
        choose=5;
        choose1=22;
    }else if (sender.view.tag==6){
        choose=6;
        choose1=66;
    }else if (sender.view.tag==7){
        choose=7;
        choose1=66;
    }else if (sender.view.tag==8){
        choose=8;
        choose1=66;
    }else if (sender.view.tag==9){
        choose=9;
        choose1=66;
    }else if (sender.view.tag==10){
        choose=10;
        choose1=66;
    }
    
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    if (choose==0) {
        self.goodsOneImage.image = editedImage;
    }else if (choose==1){
        self.goodsManyImage1.image=editedImage;
        [_goodsManyImage2 setHidden:NO];
    }else if (choose==2){
        self.goodsManyImage2.image=editedImage;
        [_goodsManyImage3 setHidden:NO];
    }else if (choose==3){
        self.goodsManyImage3.image=editedImage;
        [_goodsManyImage4 setHidden:NO];
    }else if (choose==4){
        self.goodsManyImage4.image=editedImage;
        [_goodsManyImage5 setHidden:NO];
    }else if (choose==5){
        self.goodsManyImage5.image=editedImage;
    }else if (choose==6){
        self.goodsDescImage6.image=editedImage;
        [_goodsDescImage7 setHidden:NO];
    }else if (choose==7){
        self.goodsDescImage7.image=editedImage;
        [_goodsDescImage8 setHidden:NO];
    }else if (choose==8){
        self.goodsDescImage8.image=editedImage;
        [_goodsDescImage9 setHidden:NO];
    }else if (choose==9){
        self.goodsDescImage9.image=editedImage;
        [_goodsDescImage10 setHidden:NO];
    }else if (choose==10){
        self.goodsDescImage10.image=editedImage;
    }
    
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        
        LSNet * mNet = [[LSNet alloc]initWithURL:@"http://183.56.148.109:8080/minghao/upload.do"];
        NSMutableDictionary * params = [[ NSMutableDictionary alloc]init];
        [params setValue:[NSString stringWithFormat:@"%ld", time(0)] forKey:@"time"];
        
        [mNet Post:params withImage:editedImage];
        
        if (choose==0) {
            theGoodsShowImageName= mNet.imageName;
            NSLog(@"0=%@",theGoodsShowImageName);
        }else if(choose1==22){
            line=@"/";
            mNet.imageName=[mNet.imageName stringByAppendingString:line];
            _theGoodsImageNames=[_theGoodsImageNames stringByAppendingString:mNet.imageName];
            NSLog(@"images=%@",_theGoodsImageNames);
        }else if (choose1==66){
            line=@"/";
            mNet.imageName=[mNet.imageName stringByAppendingString:line];
            _theGoodsDescImages=[_theGoodsDescImages stringByAppendingString:mNet.imageName];
            NSLog(@"desc=%@",_theGoodsDescImages);
        
        }
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
            
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark - image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}





#pragma mark - 上传商品提示

-(void)OnRightButton:(id)sender{
    NSLog(@"st=%@",theGoodsShowImageName);
    if (theGoodsShowImageName==nil) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请上传商品图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([goodsDesc.text isEqualToString:@""]) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品描述不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if([goodsName.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品名称不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else if([goodsPrice.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品价格不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else if([goodsBrand.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品品牌不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else if([goodsDiscount.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品折扣不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else if([goodsStyle.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品风格不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else if([goodsPlace.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"商品产地不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else{
        
        
        NSLog(@"做上传商品的操作");
        NSLog(@"gts=%@",goodsTypeString);
        NSString *desc=goodsDesc.text;
        NSString *name=goodsName.text;
        NSString *price=goodsPrice.text;
        NSString *brand=goodsBrand.text;
        NSString *discount=goodsDiscount.text;
        NSString *style=goodsStyle.text;
        NSString *place=goodsPlace.text;
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        
        NSLog(@"shopid==%@",[Store getShopId]);
        
        if ([User getUserShop]!=NULL) {
            myStoreArray=[api showMyStoreMsg:[User getUserID]];
            Store *st=[myStoreArray objectAtIndex:0];
            NSString *shopid=st.storeId;
            
            NSLog(@"shopid=%@",shopid);
            [api userAddGoods:name withGoodsTypeId:goodsTypeString withStoreId:shopid withGoodsBrand:brand withGoodsStyle:style withGoodsPlace:place withGoodsPrice:price withGoodsDiscount:discount withGoodsContent:desc withGoodsImgPath1:theGoodsShowImageName withGoodsImagePaths:_theGoodsImageNames withGoodsImageInfoPaths:_theGoodsDescImages];
            UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"添加商品成功，点击确认将跳到我的店" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [av show];
            
        }else{
            [api userAddGoods:name withGoodsTypeId:goodsTypeString withStoreId:[Store getShopId] withGoodsBrand:brand withGoodsStyle:style withGoodsPlace:place withGoodsPrice:price withGoodsDiscount:discount withGoodsContent:desc withGoodsImgPath1:theGoodsShowImageName withGoodsImagePaths:_theGoodsImageNames withGoodsImageInfoPaths:_theGoodsDescImages];
            UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"添加商品成功，点击确认将跳到我的店" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [av show];
        }
        
    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *s=[alertView buttonTitleAtIndex:buttonIndex];
    if ([s isEqualToString:@"确认"]){

        MyStoreViewController *msvc=[self.storyboard instantiateViewControllerWithIdentifier:@"mystoreVC"];
        
        //msvc.store=store;
        [self.navigationController  pushViewController:msvc animated:YES];
        
    }
}



-(void)goBackAction{
 
    [self.navigationController popViewControllerAnimated:YES];
        

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


- (IBAction)changeStauts:(id)sender {
    
    if (isOpened) {
        [UIView animateWithDuration:1 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            
            frame.size.height=1;
            [_tb setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:1 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_tb.frame;
            
            frame.size.height=150;
            [_tb setFrame:frame];
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
        
        
    }

}
@end
