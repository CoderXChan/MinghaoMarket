//
//  MyReleaseViewController.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/30.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MyReleaseViewController.h"
#import "VPImageCropperViewController.h"
#import "LSNet.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "MingHaoApiService.h"
#import "HouseServiceTableViewController.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@interface MyReleaseViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>
{
    NSString *tempstring;
    NSString *string;
    int choose;
    int choose1;
    NSString *line;
    
}


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *MyReleaseActivity;




//发布按钮
- (IBAction)releaseBtnClick:(id)sender;




@property (strong, nonatomic) IBOutlet UIImageView *myReleaseImage;




- (IBAction)closeKBClick:(id)sender;


//我的发布详情图片
@property (strong, nonatomic) IBOutlet UIImageView *myReleaseImage1;

@property (strong, nonatomic) IBOutlet UIImageView *myReleaseImage2;

@property (strong, nonatomic) IBOutlet UIImageView *myReleaseImage3;

@property (strong, nonatomic) IBOutlet UIImageView *myReleaseImage4;

@property (strong, nonatomic) IBOutlet UIImageView *myReleaseImage5;


//商品详情图片
@property (copy,nonatomic) NSString *theReleaseImages;



@property (nonatomic, strong) UIImageView *portraitImageView;

@end

@implementation MyReleaseViewController
@synthesize msgDesc,msgName,msgPrice,theStoreImageName,goodFoods;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_MyReleaseActivity setHidden:YES];
    
    _theReleaseImages=[[NSMutableString alloc] init];
    
    if ([string isEqualToString:@"0"]) {
        [_myReleaseImage1 setHidden:YES];
        [_myReleaseImage2 setHidden:YES];
        [_myReleaseImage3 setHidden:YES];
        [_myReleaseImage4 setHidden:YES];
        [_myReleaseImage5 setHidden:YES];
    }else{
        [_myReleaseImage2 setHidden:YES];
        [_myReleaseImage3 setHidden:YES];
        [_myReleaseImage4 setHidden:YES];
        [_myReleaseImage5 setHidden:YES];
    }
    
    
    
    
    
    //_myReleaseImage.layer.cornerRadius = _myReleaseImage.frame.size.width / 2;
    //_myReleaseImage.clipsToBounds = YES;
    
    _myReleaseImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_myReleaseImage addGestureRecognizer:portraitTap];

    
    //详情图
    _myReleaseImage1.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_myReleaseImage1 addGestureRecognizer:portraitTap1];
    
    
    _myReleaseImage2.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_myReleaseImage2 addGestureRecognizer:portraitTap2];
    
    
    _myReleaseImage3.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_myReleaseImage3 addGestureRecognizer:portraitTap3];
    
    
    _myReleaseImage4.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_myReleaseImage4 addGestureRecognizer:portraitTap4];
    
    
    _myReleaseImage5.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *portraitTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)];
    [_myReleaseImage5 addGestureRecognizer:portraitTap5];
    
    
    //[self.view addSubview:self.portraitImageView];
    [self loadPortrait];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"我的发布";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds=CGRectMake(0, 0, 40, 40);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"logoBtn"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=back;
    
    
    
    string=goodFoods.type;
    NSLog(@"string=%@",string);
    tempstring=goodFoods.typeId;
    NSLog(@"tempstringtempstring===%@",tempstring);
}

- (void)loadPortrait {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        //NSURL *portraitUrl = [NSURL URLWithString:@"http://photo.l99.com/bigger/31/1363231021567_5zu910.jpg"];
        //UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
        UIImage *protraitImg = [UIImage imageNamed:@"tianjia"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.myReleaseImage.image = protraitImg;
            
            //详情图
            self.myReleaseImage1.image=protraitImg;
            self.myReleaseImage2.image=protraitImg;
            self.myReleaseImage3.image=protraitImg;
            self.myReleaseImage4.image=protraitImg;
            self.myReleaseImage5.image=protraitImg;
        });
    });
}




- (void)editPortrait :(UITapGestureRecognizer *)sender{
    if (sender.view.tag==11) {
        choose=11;
    }else if(sender.view.tag==12){
        choose=12;
        choose1=2;
    }else if(sender.view.tag==13){
        choose=13;
        choose1=2;
    }else if(sender.view.tag==14){
        choose=14;
        choose1=2;
    }else if(sender.view.tag==15){
        choose=15;
        choose1=2;
    }else if(sender.view.tag==16){
        choose=16;
        choose1=2;
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
    if (choose==11) {
        self.myReleaseImage.image = editedImage;
    }else if (choose==12){
        self.myReleaseImage1.image=editedImage;
        [_myReleaseImage2 setHidden:NO];
    }else if (choose==13){
        self.myReleaseImage2.image=editedImage;
        [_myReleaseImage3 setHidden:NO];
    }else if (choose==14){
        self.myReleaseImage3.image=editedImage;
        [_myReleaseImage4 setHidden:NO];
    }else if (choose==15){
        self.myReleaseImage4.image=editedImage;
        [_myReleaseImage5 setHidden:NO];
    }else if (choose==16){
        self.myReleaseImage5.image=editedImage;
    }
    
    
    //self.myReleaseImage.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        
        LSNet * mNet = [[LSNet alloc]initWithURL:@"http://183.56.148.109:8080/minghao/upload.do"];
        NSMutableDictionary * params = [[ NSMutableDictionary alloc]init];
        [params setValue:[NSString stringWithFormat:@"%ld", time(0)] forKey:@"time"];
        
        [mNet Post:params withImage:editedImage];
        
        
        if (choose==11) {
            theStoreImageName=mNet.imageName;
        }else if (choose1==2){
            line=@"/";
            mNet.imageName=[mNet.imageName stringByAppendingString:line];
            _theReleaseImages=[_theReleaseImages stringByAppendingString:mNet.imageName];
            NSLog(@"images=%@",_theReleaseImages);

        
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

#pragma mark image scale utility
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goBackAction{
    
    // 在这里增加返回按钮的自定义动作
    
    [self.navigationController popViewControllerAnimated:YES];
    //[_sideSlipView switchMenu];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)releaseBtnClick:(id)sender {
    NSLog(@"st=%@",theStoreImageName);
    if (theStoreImageName==nil) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请上传图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if ([msgName.text isEqualToString:@""]) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"信息名称不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    }else if([msgDesc.text isEqualToString:@"介绍下物品状况、来源、转让原因"]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"描述不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else if([msgPrice.text isEqualToString:@""]){
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"转让价格不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
    }else{
        [self.view setAlpha:0.8];
        [self.navigationController.navigationBar setAlpha:0.8];
        [_MyReleaseActivity setColor:[UIColor grayColor]];
        [_MyReleaseActivity setHidden:NO];
        [_MyReleaseActivity startAnimating];
        [self.view addSubview:_MyReleaseActivity];
        [self performSelector:@selector(stop) withObject:nil afterDelay:1];
        

    }
  
}



-(void)stop{
    //停止转动
    [_MyReleaseActivity stopAnimating];
    _MyReleaseActivity.hidden=YES;
    
    //恢复透明度
    [self.view setAlpha:1];
    [self.navigationController.navigationBar setAlpha:1];
    
    if ([string isEqualToString:@"0"]) {
        NSLog(@"做发布信息接口操作");
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        [api userReleaseMsg:[User getUserID] withInfoName:msgName.text withInfoTypeId:tempstring withImageName:theStoreImageName withInfoContent:msgDesc.text withInfoMoney:msgPrice.text];
    }else{
        NSLog(@"做发布美食接口操作");
        MingHaoApiService *api=[[MingHaoApiService alloc] init];
        [api userReleaseFood:[User getUserID] withInfoName:msgName.text withInfoTypeId:tempstring withImageName:theStoreImageName withInfoContent:msgDesc.text withInfoMoney:msgPrice.text withImagePaths:_theReleaseImages];

    
    }
    
    
    
    UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"提示" message:@"发布成功，点击确认将跳到我的发布" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [av show];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *s=[alertView buttonTitleAtIndex:buttonIndex];
    if ([s isEqualToString:@"确认"]){
        HouseServiceTableViewController *msvc=[self.storyboard instantiateViewControllerWithIdentifier:@"houseServiceTVC"];
        string=goodFoods.type;
        tempstring=goodFoods.typeId;
        msvc.goodFoods=goodFoods;
        [self.navigationController  pushViewController:msvc animated:YES];
        
    }
}


- (IBAction)closeKBClick:(id)sender {
    [msgPrice resignFirstResponder];
    [msgName resignFirstResponder];
    [msgDesc resignFirstResponder];
}
@end
