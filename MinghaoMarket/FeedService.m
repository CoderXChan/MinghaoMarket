//
//  FeedService.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/7.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "FeedService.h"
#import "Feed.h"
@implementation FeedService

- (NSArray *)allSubscribeFeeds{
    Feed *item0=[[Feed alloc] initWithName:@"最新上线" note:@"最新上线商品" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/news-114_114.png" homeURL:@"http://news.sina.cn/?vt=4&pos=108" pageURL:@"http://183.56.148.109:8080/minghao/getnewproduct.do"];
    Feed *item1=[[Feed alloc] initWithName:@"明星店铺" note:@"质量以及信誉销量全部好评的商家" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/fra-114_114.png" homeURL:@"http://finance.sina.cn/?vt=4&pos=108" pageURL:@"http://183.56.148.109:8080/minghao/getbusinessshopBylevel.do?id=1"];
    Feed *item2=[[Feed alloc] initWithName:@"限时活动" note:@"在一定时间内，可以抢购到的打折商品" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/mil-114_114.png" homeURL:@"http://mil.sina.cn/?vt=4&pos=108" pageURL:@"http://minghao.18gg.cn:8080/minghao/gettypeprobuctByDis.do"];
    Feed *item3=[[Feed alloc] initWithName:@"美妆精选" note:@"化妆品系列的精品，品牌以及质量保证协议填写过后交过消费保证金的店铺" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/ent-114_114.png" homeURL:@"http://ent.sina.cn/?vt=4&pos=108" pageURL:@"http://183.56.148.109:8080/minghao/getMeiZhuangjx.do?pid=1&id=2"];
    Feed *item4=[[Feed alloc] initWithName:@"帮扶店铺" note:@"一种活动特有的店面" imageURL:@"http://mjs.sinaimg.cn/wap/public/addToHome/201404101830/images/sports-114_114.png" homeURL:@"http://sports.sina.cn/?vt=4&pos=108" pageURL:@"http://183.56.148.109:8080/minghao/getbusinessshopBylevel.do?id=3"];
    
    
    //还可以再添加
    return @[item0,item1,item2,item3,item4];
}

@end
