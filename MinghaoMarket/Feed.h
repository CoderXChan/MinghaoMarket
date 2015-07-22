//
//  Feed.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/7.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Feed;
@class Picture;
@class Goods;
@class StarShopTableViewController;
@protocol FeedDelegate <NSObject>

@optional
//body page
-(void)feedDidStartLoadGoods:(Feed *)feed;

-(void)feed:(Feed *)feed didFinishLoadGoods:(NSArray *)goods;



//失败
-(void)feed:(Feed *)feed feedFileLoadWithError:(NSError *)error;

@end

@interface Feed : NSObject

- (instancetype)initWithName:(NSString *) name note:(NSString *) note imageURL:(NSString *) imageURL homeURL:(NSString *) homeURL pageURL:(NSString *) pageURL;

/*
//打包请求参数
-(NSMutableString *)packageReqParams:(NSMutableDictionary *)reqParams;

//发送请求(返回json字符串)
-(NSString *)sendHTTPRequest:(NSString *)urlString :(NSMutableDictionary *)reqParams;

-(BOOL)starShop:(StarShopTableViewController *)sShop;*/



@property(weak,nonatomic)id <FeedDelegate>delegate;

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *note;
@property (copy,nonatomic) NSString *imageURL;
@property (copy,nonatomic) NSString *homeURL;
@property (copy,nonatomic) NSString *pageURL;

@property(copy,nonatomic)NSString *pubUrl;

@property(readonly)NSArray *goods;
@property(readonly)NSArray *flashGoods;
@property(readonly)NSArray *focusGoods;


-(void)stopLoad;

-(void)loadPage:(NSInteger)page size:(NSInteger)size;


//限时活动
-(void)loadFlashPage:(NSInteger)fpage size:(NSInteger)fsize;



//代码块的方式回调取值
-(void)loadPicture:(Picture *)picture putOffLoadHandler:(void(^)(NSData *data))handler;

-(void)loadFocusImageForGoods:(Goods *)article putOffLoadHandler:(void(^)(NSData *data))handler;
@end
