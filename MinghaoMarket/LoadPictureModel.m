//
//  LoadPictureModel.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/6/26.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "LoadPictureModel.h"
#import "Utility.h"
#import "TFHpple.h"
#import "NSError+Extentions.h"
#import "NSDate+Extentions.h"
#import "JsonParser.h"
#import "Goods.h"
@interface LoadPictureModel(){
    BOOL _load;
    NSOperationQueue *_queue;//排队
    NSMutableArray *_imageArray;
}

//加载明星店铺广告图片
-(void)loadStarHeadImage;



- (void) onDidFailLoadWithError:(NSError *) error;
@end

@implementation LoadPictureModel

- (instancetype)initWithImageName:(NSString *) name{
    if (self=[super init]) {
        self.name=name;
        
        _flashGoods=[[NSMutableArray alloc] init];
    }
    return self;


}



-(void)loadImage{
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc] init];
    }
    
    [self loadStarHeadImage];
}



//限时活动
-(void)loadStarHeadImage{
    //[self onDidStartLoadGoods];
    NSString *imageUrl=@"http://183.56.148.109:8080/minghao/getbusinessshopBylevel.do?id=1";
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [Utility sendAsynchronousRequest:req queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            //[self onDidFailLoadWithError:error];
            NSLog(@"错误");
        }else{
            NSArray *newGoods=[self parseImageFromJson:data];
            
            if (newGoods!=nil) {
                
                [_imageArray addObjectsFromArray:newGoods];
                
            }
            //[self onDidFinishLoadGoods:newGoods];
        }
    }];
    
    
}


-(NSArray *)parseImageFromJson:(NSData *)data{
    NSString *_pubUrl=@"http://183.56.148.109:8080";
    NSMutableArray *flashGoods=nil;
    NSError *error=nil;
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    //NSLog(@"dictionary=%@",dictionary);
    if (error) {
        [self onDidFailLoadWithError:[NSError errorWithDomain:PARSING_ERROR_DOMAIN code:kParseJSONFailed errmsg:@"Invalid JSON data" innerError:error]];
    }else{
        
        id items=[dictionary valueForKey:@"msg1"];
        
        if (items!=[NSNull null]) {
            flashGoods=[NSMutableArray arrayWithCapacity:32];
            Goods *flashGood;
            
            flashGood=[[Goods alloc] init];
            NSString *flashImageUrl=[items valueForKey:@"photoAdverName"];
            if (![flashImageUrl isKindOfClass:[NSNull class]]) {
                NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
                flashGood.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
                
                [flashGoods addObject:flashGood];
                NSLog(@"tt==%@",flashGood.thumbPicture);
            }

            
            
        }
        
    }
    
    
    return flashGoods;
    
}



//块  的方式回调取值
-(void)loadPicture:(Picture *)picture putOffLoadHandler:(void(^)(NSData *data))handler{
    NSURLRequest *req=[NSURLRequest requestWithURL:[NSURL URLWithString:picture.pictureURL]];
    [Utility sendAsynchronousRequest:req queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self onDidFailLoadWithError:error];
        }else{
            picture.pictureData = data;
            handler(data);
            
        }
    }];

}


- (void) onDidFailLoadWithError:(NSError *) error{
    NSLog(@"DidFailLoadWithError");
    NSLog(@"%@",error);
    //if (self.delegate && [self.delegate respondsToSelector:@selector(feed:feedFileLoadWithError:)]) {
      //  [self.delegate feed:self feedFileLoadWithError:error];
    //}
    
    
}



@end
