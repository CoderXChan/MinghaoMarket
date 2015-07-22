//
//  MyStoreFeedService.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/21.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MyStoreFeedService.h"
#import "MyStoreFeed.h"
@implementation MyStoreFeedService
- (NSArray *) allMyStoreFeeds{

    MyStoreFeed *item0=[[MyStoreFeed alloc] initWithName:@"出售中" note:@"正在出售的商品" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/news-114_114.png" homeURL:@"http://news.sina.cn/?vt=4&pos=108" pageURL:@"http://interface.sina.cn/news/feed_top_news.d.json?version=toutiao&ch=app_news&col=app_news&show_num=%i&page=%i"];
    MyStoreFeed *item1=[[MyStoreFeed alloc] initWithName:@"已下架" note:@"已经下架的商品" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/fra-114_114.png" homeURL:@"http://finance.sina.cn/?vt=4&pos=108" pageURL:@"http://interface.sina.cn/ent/feed.d.json?ch=finance&col=finance&show_num=%i&page=%i"];
        //还可以再添加
    return @[item0,item1];



}
@end
