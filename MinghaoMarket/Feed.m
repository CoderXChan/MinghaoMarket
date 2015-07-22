//
//  Feed.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/7.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "Feed.h"
#import "Goods.h"
#import "Utility.h"
#import "TFHpple.h"
#import "NSError+Extentions.h"
#import "NSDate+Extentions.h"
#import "JsonParser.h"
#import "StarShopTableViewController.h"
#import "FlashGoods.h"
@interface Feed(){
    BOOL _load;
    NSOperationQueue *_queue;//排队
    NSMutableArray *_goods;
    NSMutableArray *discountArray;
    NSMutableArray *_flashGoods;
}

-(void)loadGoodsPage:(NSInteger)page size:(NSInteger)size;


//限时活动
-(void)loadFlashGoodsPage:(NSInteger)fpage size:(NSInteger)fsize;//==
-(NSArray *)parseFlashGoodsFromJson:(NSData *)data;




-(NSArray *)parseGoodsFromJson:(NSData *)data;




- (void) onDidStartLoadGoods;
- (void) onDidFinishLoadGoods:(NSArray *) goods;
- (void) onDidFailLoadWithError:(NSError *) error;




@end
@implementation Feed


- (instancetype)initWithName:(NSString *)name note:(NSString *)note imageURL:(NSString *)imageURL homeURL:(NSString *)homeURL pageURL:(NSString *)pageURL{
    if (self=[super init]) {
        self.name=name;
        self.note=note;
        self.imageURL=imageURL;
        self.homeURL=homeURL;
        self.pageURL=pageURL;
        _goods= [[NSMutableArray alloc] init];
        _flashGoods=[[NSMutableArray alloc] init];
    }
    return self;
}


-(void)loadPage:(NSInteger)page size:(NSInteger)size{
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc] init];
    }
    
    [self loadGoodsPage:page size:size];

}

//限时活动
-(void)loadFlashPage:(NSInteger)fpage size:(NSInteger)fsize{//==
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc] init];
    }
    [self loadFlashGoodsPage:fpage  size:fsize];
}



-(void)stopLoad{
    if (_queue) {
        [_queue cancelAllOperations];
    }
}

-(void)loadGoodsPage:(NSInteger)page size:(NSInteger)size{
    [self onDidStartLoadGoods];
    NSString *urlString = [NSString stringWithFormat:self.pageURL,size,page];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [Utility sendAsynchronousRequest:req queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self onDidFailLoadWithError:error];
        }else{
            NSArray *newGoods=[self parseGoodsFromJson:data];
            
            if (newGoods!=nil) {
                if (page==0) {
                    [_goods removeAllObjects];
                }
                [_goods addObjectsFromArray:newGoods];
                
            }
            [self onDidFinishLoadGoods:newGoods];
        }
    }];
}



//限时活动
-(void)loadFlashGoodsPage:(NSInteger)fpage size:(NSInteger)fsize{
    [self onDidStartLoadGoods];
    self.pageURL=@"http://183.56.148.109:8080/minghao/getAllproductTypeByDis.do";
    NSString *urlString = [NSString stringWithFormat:self.pageURL,fsize,fpage];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [Utility sendAsynchronousRequest:req queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self onDidFailLoadWithError:error];
        }else{
            NSArray *newGoods=[self parseFlashGoodsFromJson:data];
            
            if (newGoods!=nil) {
                if (fpage==0) {
                    [_flashGoods removeAllObjects];
                }
                [_flashGoods addObjectsFromArray:newGoods];
                
            }
            [self onDidFinishLoadGoods:newGoods];
        }
    }];


}



//限时活动
-(NSArray *)parseFlashGoodsFromJson:(NSData *)data{
    _pubUrl=@"http://183.56.148.109:8080";
    NSMutableArray *flashGoods=nil;
    NSError *error=nil;
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    //NSLog(@"dictionary=%@",dictionary);
    if (error) {
        [self onDidFailLoadWithError:[NSError errorWithDomain:PARSING_ERROR_DOMAIN code:kParseJSONFailed errmsg:@"Invalid JSON data" innerError:error]];
    }else{
        
        id items=[dictionary valueForKey:@"msg"];
        
        if (items!=[NSNull null]) {
            flashGoods=[NSMutableArray arrayWithCapacity:32];
            FlashGoods *flashGood;
            for (NSDictionary *item in  items) {
                flashGood=[[FlashGoods alloc] init];
                
                if (![flashGood.flashGoodsName isKindOfClass:[NSNull class]]) {
                    flashGood.flashGoodsName=[item valueForKeyPath:@"message.productTypeName"];
                }else{
                    flashGood.flashGoodsName=@"null";
                }
                
                
                if (![flashGood.flashGoodsDiscount isKindOfClass:[NSNull class]]) {
                    flashGood.flashGoodsDiscount=[item valueForKey:@"ProductDiscount"];
                }else{
                    flashGood.flashGoodsDiscount=@"null";
                }
                
                
                if (![flashGood.flashGoodsDiscountTime isKindOfClass:[NSNull class]]) {
                    flashGood.flashGoodsDiscountTime=[item valueForKey:@"DiscountTime"];
                }else{
                    flashGood.flashGoodsDiscountTime=@"null";
                }

                
                if (![flashGood.flashGoodsID isKindOfClass:[NSNull class]]) {
                    flashGood.flashGoodsID=[item valueForKeyPath:@"message.productTypeID"];
                }else{
                    flashGood.flashGoodsID=@"null";
                }
                
                
                
                
                NSString *flashImageUrl=[item valueForKeyPath:@"message.productTypeImage"];
                if (![flashImageUrl isKindOfClass:[NSNull class]]) {
                    NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
                    flashGood.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
                }
                
                
                [flashGoods addObject:flashGood];

                
            }

        }
        
    }
    return flashGoods;
    
}







-(NSArray *)parseGoodsFromJson:(NSData *)data{
    _pubUrl=@"http://183.56.148.109:8080/";
    NSMutableArray *goods=nil;
    NSError *error=nil;
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        [self onDidFailLoadWithError:[NSError errorWithDomain:PARSING_ERROR_DOMAIN code:kParseJSONFailed errmsg:@"Invalid JSON data" innerError:error]];
    }else{
        id items=[dictionary valueForKey:@"msg"];
        if (items!=[NSNull null]) {
            goods=[NSMutableArray arrayWithCapacity:32];
            Goods *good;
            for (NSDictionary *item in items) {
                good=[[Goods alloc] init];
                
                //最新上线
                if (![good.shopName isKindOfClass:[NSNull class]]) {
                    good.shopName=[item valueForKey:@"pName"];
                }else{
                    good.shopName=@"null";
                }
                
                if (![good.goodsDiscount isKindOfClass:[NSNull class]]) {
                    good.goodsDiscount=[item valueForKey:@"productDiscount"];
                }else{
                    good.goodsDiscount=@"null";
                }
                
                
                if (![good.goodsID isKindOfClass:[NSNull class]]) {
                    good.goodsID=[[item valueForKey:@"productID"] stringValue];
                }else{
                    good.goodsID=@"null";
                }
                
                
                
                
                NSString *gPictureUrl;
                NSMutableArray *gArray=[NSMutableArray array];
                for (NSString *s in [item valueForKeyPath:@"productimageslist.pIName"]) {
                    if (![s isKindOfClass:[NSNull class]]) {
                        gPictureUrl= [_pubUrl stringByAppendingString:s];
                        [gArray addObject:[[Picture alloc] initWithURL:gPictureUrl]];
                    }
                    
                }
                good.thumbPictures=gArray;
                
                
                //明星店铺
                if (![good.starShopName isKindOfClass:[NSNull class]]) {
                    good.starShopName=[item valueForKey:@"bSName"];
                }else{
                    good.starShopName=@"null";
                }
                
                
                
                if (![good.shopLevelId isKindOfClass:[NSNull class]]) {
                    good.shopLevelId=[[item valueForKey:@"levelID"] stringValue];
                }else{
                    good.shopLevelId=@"";
                }
                
                
                if (![good.shopDetail isKindOfClass:[NSNull class]]) {
                    good.shopDetail=[item valueForKey:@"bSDetail"];
                }else{
                    good.shopDetail=@"";
                }
                
                
                if (![good.starShopId isKindOfClass:[NSNull class]]) {
                    good.starShopId=[item valueForKey:@"businessShopID"];
                }else{
                    good.starShopId=@"null";
                
                }
                
                
                
                
                //这里
                NSString *sPictureUrl=[item valueForKey:@"img"];
                if (sPictureUrl) {
                    NSString *starPictureUrl=[_pubUrl stringByAppendingString:sPictureUrl];
                    good.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
                }
                
                

                
                //美妆精选
                if (![good.shopName isKindOfClass:[NSNull class]]) {
                    good.shopName=[item valueForKey:@"pName"];
                }else{
                    good.shopName=@"null";
                }
                
                
                if (![good.goodsPrice isKindOfClass:[NSNull class]]) {
                    good.goodsPrice=[item valueForKey:@"productPrice"];
                }else{
                    good.goodsPrice=@"null";
                }
                
                
                
                if (![good.goodsDiscount isKindOfClass:[NSNull class]]) {
                    good.goodsDiscount=[item valueForKey:@"productDiscount"];
                }else{
                    good.goodsDiscount=@"null";
                }
                
                
                
                NSString *bPictureUrl;
                NSMutableArray *bArray=[NSMutableArray array];
                for (NSString *b in [item valueForKeyPath:@"productimageslist.pIName"]) {
                    if (![b isKindOfClass:[NSNull class]]) {
                        bPictureUrl=[_pubUrl stringByAppendingString:b];
                        [bArray addObject:[[Picture alloc] initWithURL:bPictureUrl]];
                    }
                    
                }
                good.thumbPictures=bArray;
                
                
                
                
                //帮扶店铺
                if (![good.goodsName isKindOfClass:[NSNull class]]) {
                    good.goodsName=[item valueForKey:@"bSName"];
                }else{
                    good.goodsName=@"null";
                }
                
                
                
                if (![good.shopDetail isKindOfClass:[NSNull class]]) {
                    good.shopDetail=[item valueForKey:@"bSDetail"];
                }else{
                    good.shopDetail=@"null";
                }
                
                
                
                
                
                //这里
                NSString *hPictureUrl=[item valueForKey:@"img"];
                if (sPictureUrl) {
                    NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                    good.thumbPicture=[[Picture alloc] initWithURL:helpPictureUrl];
                }


                
                [goods addObject:good];
                
            }
            
            
        }
        
        
    }

    return goods;
}

#pragma mark - 频道的商品图片
-(void)loadPicture:(Picture *)picture putOffLoadHandler:(void (^)(NSData *))handler{
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

#pragma mark - 广告图
-(void)loadFocusImageForGoods:(Goods *)article putOffLoadHandler:(void (^)(NSData *))handler{
    

}


- (void) onDidStartLoadGoods{
    if (self.delegate && [self.delegate respondsToSelector:@selector(feedDidStartLoadGoods:)]) {
        [self.delegate feedDidStartLoadGoods:self];
    }


}
- (void) onDidFinishLoadGoods:(NSArray *) goods{
    if (self.delegate && [self.delegate respondsToSelector:@selector(feed:didFinishLoadGoods:)]) {
        [self.delegate feed:self didFinishLoadGoods:goods];
    }


}
- (void) onDidFailLoadWithError:(NSError *) error{
    NSLog(@"DidFailLoadWithError");
    NSLog(@"%@",error);
    if (self.delegate && [self.delegate respondsToSelector:@selector(feed:feedFileLoadWithError:)]) {
        [self.delegate feed:self feedFileLoadWithError:error];
    }


}





@end
