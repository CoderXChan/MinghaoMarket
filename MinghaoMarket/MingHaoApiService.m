//
//  MingHaoApiService.m
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import "MingHaoApiService.h"
#import "JsonParser.h"
#import "Goods.h"
#import "LatestOnlineGoods.h"
#import "Picture.h"
#import "Utility.h"
#import "ShoppingCarGoods.h"
#import "StarShopGoods.h"
#import "MenuGoods.h"
#import "FlashGoods.h"
#import "AddAddress.h"
#import "Store.h"
#import "GoodsType.h"
#import "MessageDesc.h"
#import "GoodFoods.h"
NSString *publicUrl=@"http://183.56.148.109:8080/minghao/";
NSString *_pubUrl=@"http://183.56.148.109:8080";


@implementation MingHaoApiService

//打包请求参数
-(NSMutableString *)packageReqParams:(NSMutableDictionary *)reqParams{
    NSMutableString *pString=[[NSMutableString alloc]init];
    int i=1;
    for(NSObject *key in reqParams) {
        if (i==1) {
            [pString appendFormat:@"%@=%@",key,[reqParams objectForKey:key]];
        }else{
            [pString appendFormat:@"&%@=%@",key,[reqParams objectForKey:key]];
        }
        i++;
    }
    
    return pString;
}

//发送请求
-(NSString *)sendHTTPRequest:(NSString *)urlString :(NSMutableDictionary *)reqParams{
    NSString *resJsonMsg=nil;
    @try {
        NSURL *url=[[NSURL alloc]initWithString:urlString];
        //创建请求对象
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
        
        //请求的内容类型
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPMethod:@"POST"];
        
        //加载请求参数
        NSMutableString *paramsString=[self packageReqParams:reqParams];//@"reqcode='U01'&format='json'&version='1.0'&message='{\"message\":{\"username\":\"admin\",\"pwd\":\"123456\"}}'";
        
        [request setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
        
        //发送同步请求,得到返回的数据
        NSData *resData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        resJsonMsg=[[NSString alloc]initWithData:resData encoding:NSUTF8StringEncoding];
        
    }
    @catch (NSException *exception) {
        NSLog(@"发送请求错误,error:%@",exception);
    }
    @finally {
        return resJsonMsg;
    }
}


// 用户注册
-(BOOL)registed:(User *)user{
    NSString *string2=@"saveorupdataUser.do";
    NSString *registerServiceUrl = [publicUrl stringByAppendingString:string2];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:user.userPhoneNumber forKey:@"phone"];
    [reqParams setObject:user.userName forKey:@"name"];
    [reqParams setObject:user.userPassWord forKey:@"pwd"];
    [reqParams setObject:user.userEmail forKey:@"email"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:registerServiceUrl :reqParams];
    
    NSMutableDictionary *result=[JsonParser parseJsonStrToDict:[[NSMutableString alloc]initWithString:jsonString]];

    //处理返回数据
    NSString  *resmsg= [result objectForKey:@"msg"];
    
    if (![resmsg isEqualToString:@"1"]) {
        NSLog(@"注册失败");
        return NO;
    }
    
    
    return YES;

}



//用户登录U01
-(NSMutableArray *)login:(User *)user{
    NSString *string2=@"login.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string2];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:user.userPhoneNumber forKey:@"uphone"];
    [reqParams setObject:user.userPassWord forKey:@"password"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];

    //解析Json
    NSMutableDictionary *result=[JsonParser parseJsonStrToDict:[[NSMutableString alloc]initWithString:jsonString]];
    
    User *user1;
     _userList=[NSMutableArray arrayWithCapacity:32];
    //处理返回数据
    id  resmsg= [result objectForKey:@"msg"];
    if (resmsg!=[NSNull null]) {
       
        user1=[[User alloc] initWithUserId:[resmsg valueForKey:@"usersID"] withPhoneNumber:[resmsg valueForKey:@"uPhone"] withName:[resmsg valueForKey:@"uName"] withPwd:[resmsg valueForKey:@"uPwd"] withEmail:[resmsg valueForKey:@"uEmail"] withPoints:[[resmsg valueForKey:@"scoring"] stringValue ] withUserVip:[[resmsg valueForKeyPath:@"vipModel.uVip"] stringValue]];
        
        [_userList addObject:user1];
        
    }
    
    
    NSString *msg1=[result objectForKey:@"msg1"];
    
    if ([msg1 isEqualToString:@"1"]) {
        user1.userShopYesOrNo=msg1;
        NSLog(@"该用户有店！msg1=%@",user1.userShopYesOrNo);
        [_userList addObject:user1];
    }
    
    NSLog(@"登录返回信息：%@",resmsg);
    NSString *errCode=[result objectForKey:@"check"];
    
    if (![errCode isEqualToString:@"1"]) {
        NSLog(@"登录失败!errCode:%@",errCode);
        return  nil;
    }
    return _userList;
}





//最新上线显示详情
-(NSMutableArray *)showLatestOnlineGoodsMsg:(NSString *)goodId{
    NSError *error=nil;
    NSString *string3=@"getproductById.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string3];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:goodId forKey:@"id"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];

    if (items!=[NSNull null]) {
        _goodsDetails=[NSMutableArray arrayWithCapacity:32];
        LatestOnlineGoods *lgoods;
            
        lgoods=[[LatestOnlineGoods alloc] init];
        
        if (![lgoods.latestOnlineGoodsName isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsName=[items valueForKey:@"pName"];
        }else{
            lgoods.latestOnlineGoodsName=@"null";
        }
        
        if (![lgoods.latestOnlineGoodsPrice isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsPrice=[items valueForKey:@"productPrice"];
        }else{
            lgoods.latestOnlineGoodsPrice=@"null";
        }
        
        if (![lgoods.latestOnlineGoodsDiscount isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsDiscount=[items valueForKey:@"productDiscount"];
        }else{
            lgoods.latestOnlineGoodsDiscount=@"null";
        }
        
        
        if (![lgoods.latestOnlineGoodsDiscountTime isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsDiscountTime=[items valueForKey:@"discountTime"];
        }else{
            lgoods.latestOnlineGoodsDiscountTime=@"null";
        }
        
        
        if (![lgoods.latestOnlineGoodsBrand isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsBrand=[items valueForKey:@"productBrand"];
        }else{
            lgoods.latestOnlineGoodsBrand=@"null";
        }
        
        
        if (![lgoods.latestOnlineGoodsStyle isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsStyle=[items valueForKey:@"productStyle"];
        }else{
            lgoods.latestOnlineGoodsStyle=@"null";
        }
        
        
        if (![lgoods.latestOnlineGoodsPlace isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsPlace=[items valueForKey:@"productPlace"];
        }else{
            lgoods.latestOnlineGoodsPlace=@"null";
        }
        
        
        if (![lgoods.latestOnlineGoodsID isKindOfClass:[NSNull class]]) {
            lgoods.latestOnlineGoodsID=[[items valueForKey:@"productID"] stringValue];
        }else{
            lgoods.latestOnlineGoodsID=@"null";
        }
        

        NSString *gPictureUrl;
        NSMutableArray *gArray=[NSMutableArray array];
        for (NSString *s in [items valueForKeyPath:@"productimageslist.pIName"]) {
            if (![s isKindOfClass:[NSNull class]]) {
                gPictureUrl= [_pubUrl stringByAppendingString:s];
                [gArray addObject:[[Picture alloc] initWithURL:gPictureUrl]];

            }
                
        }
        lgoods.thumbPictures=gArray;
        
        
        
        
        //商品详情图片
        NSString *PictureUrl;
        NSMutableArray *Array=[NSMutableArray array];
        for (NSString *s in [items valueForKeyPath:@"productinfoimagesModelslist.productinfoimagesName"]) {
            if (![s isKindOfClass:[NSNull class]]) {
                PictureUrl= [_pubUrl stringByAppendingString:s];
                [Array addObject:[[Picture alloc] initWithURL:PictureUrl]];
                
            }
            
        }
        lgoods.thumbPictures2=Array;
        
        NSLog(@"thumbPictures2=%@",lgoods.thumbPictures2);
        
        [_goodsDetails addObject:lgoods];
            
        
    }

     return _goodsDetails;

}



//加入购物车传userid和goodsid
-(BOOL)addLatestOnlineGoodsToShoppingCar:(NSString *)userId withGoodsId:(NSString *)goodsId{
    NSString *string4=@"addShopCart.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string4];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    [reqParams setObject:goodsId forKey:@"pid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"加入购物车失败");
        return NO;
    }
    
    
    return YES;
}




//加入收藏传userid和goodsid
-(BOOL)addLatestOnlineGoodsCollection:(NSString *)userId withGoodsId:(NSString *)goodsId{
    NSString *string4=@"addCollection.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string4];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    [reqParams setObject:goodsId forKey:@"pid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"加入收藏失败");
        return NO;
    }
    
    
    return YES;
}

#pragma mark -查询收藏夹商品
-(NSMutableArray *)queryCollection:(NSString *)userId{
    NSError *error=nil;
    NSString *string5=@"getCollection.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string5];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    if (items!=[NSNull null]) {
        _shoppingCarGoods=[NSMutableArray arrayWithCapacity:32];
        Goods *shoppingCarGoods;
        
        for (NSDictionary *item in  items) {
            shoppingCarGoods=[[Goods alloc] init];
            
            if (![shoppingCarGoods.goodsID isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.goodsID=[item valueForKey:@"productID"];
            }else{
                shoppingCarGoods.goodsID=@"null";
            }
            
            if (![shoppingCarGoods.goodsName isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.goodsName=[item valueForKey:@"pName"];
            }else{
                shoppingCarGoods.goodsName=@"null";
            }
            
            
            if (![shoppingCarGoods.goodsDesc isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.goodsDesc=[item valueForKey:@"description"];
            }else{
                shoppingCarGoods.goodsDesc=@"null";
            }
            
            
            if (![shoppingCarGoods.goodsPrice isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.goodsPrice=[item valueForKey:@"productPrice"];
            }else{
                shoppingCarGoods.goodsPrice=@"null";
            }
            
            
            
            //折扣
            if (![shoppingCarGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.goodsDiscount=[item valueForKey:@"productDiscount"];
            }else{
                shoppingCarGoods.goodsDiscount=@"null";
            }
            
            
            
            
            NSString *scPictureUrl;
            NSMutableArray *scArray=[NSMutableArray array];
            for (NSString *s in [item valueForKeyPath:@"productimageslist.pIName"]) {
                if (![s isKindOfClass:[NSNull class]]) {
                    scPictureUrl=[_pubUrl stringByAppendingString:s];
                    [scArray addObject:[[Picture alloc] initWithURL:scPictureUrl]];
                }
                
            }
            shoppingCarGoods.thumbPictures=scArray;
            
            
            
            [_shoppingCarGoods addObject:shoppingCarGoods];
        }
    }
    return _shoppingCarGoods;
}




//删除收藏的商品
-(BOOL)deleteCollectionGoods:(NSString *)userId withGoodsId:(NSString *)goodsId{
    NSString *string5=@"delCollection.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string5];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    [reqParams setObject:goodsId forKey:@"pid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"删除收藏商品失败");
        return NO;
    }
    
    return YES;
}

#pragma mark - 查询购物车商品
-(NSMutableArray *)queryShoppingCar:(NSString *)userId{
    NSError *error=nil;
    NSString *string5=@"getAllShopCart.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string5];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];

    if (items!=[NSNull null]) {
        _shoppingCarGoods=[NSMutableArray arrayWithCapacity:32];
        ShoppingCarGoods *shoppingCarGoods;

        for (NSDictionary *item in  items) {
            shoppingCarGoods=[[ShoppingCarGoods alloc] init];
            
            if (![shoppingCarGoods.shoppingCarGoodsId isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.shoppingCarGoodsId=[item valueForKey:@"productID"];
            }else{
                shoppingCarGoods.shoppingCarGoodsId=@"null";
            }
            
            if (![shoppingCarGoods.shoppingCarGoodsName isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.shoppingCarGoodsName=[item valueForKey:@"pName"];
            }else{
                shoppingCarGoods.shoppingCarGoodsName=@"null";
            }
            
            
            if (![shoppingCarGoods.shoppingCarGoodsDescribe isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.shoppingCarGoodsDescribe=[item valueForKey:@"description"];
            }else{
                shoppingCarGoods.shoppingCarGoodsDescribe=@"null";
            }
            
            
            if (![shoppingCarGoods.shoppingCarGoodsPrice isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.shoppingCarGoodsPrice=[item valueForKey:@"productPrice"];
            }else{
                shoppingCarGoods.shoppingCarGoodsPrice=@"null";
            }
            
            
            
            //折扣
            if (![shoppingCarGoods.shoppingCarGoodsDiscount isKindOfClass:[NSNull class]]) {
                shoppingCarGoods.shoppingCarGoodsDiscount=[item valueForKey:@"productDiscount"];
            }else{
                shoppingCarGoods.shoppingCarGoodsDiscount=@"null";
            }
            
            
            
            
            NSString *scPictureUrl;
            NSMutableArray *scArray=[NSMutableArray array];
            for (NSString *s in [item valueForKeyPath:@"productimageslist.pIName"]) {
                if (![s isKindOfClass:[NSNull class]]) {
                    scPictureUrl=[_pubUrl stringByAppendingString:s];
                    [scArray addObject:[[Picture alloc] initWithURL:scPictureUrl]];
                }
                
            }
            shoppingCarGoods.shoppingCarGoodsImage=scArray;
            
            
            
            [_shoppingCarGoods addObject:shoppingCarGoods];
        }
    }
    return _shoppingCarGoods;
}



//删除购物车商品
-(BOOL)deleteShoppingCarGoods:(NSString *)userId withGoodsId:(NSString *)goodsId{
    NSString *string5=@"delShopCart.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string5];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    [reqParams setObject:goodsId forKey:@"pid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"删除购物车商品失败");
        return NO;
    }
    
    return YES;

}


//显示明星店铺商品
-(NSMutableArray *)showStarShopGoods:(NSString *)shopID{
    NSError *error=nil;
    NSString *string6=@"getproductByBusId.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string6];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:shopID forKey:@"id"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];

    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    if (items!=[NSNull null] && ![items isEqual:@"2"]) {
        _starShopGoods=[NSMutableArray arrayWithCapacity:32];
        StarShopGoods *sGoods;
        for (NSDictionary *item in  items) {
        
            sGoods=[[StarShopGoods alloc] init];
        
            
            if (![sGoods.starShopGoodsName isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsName=[item valueForKey:@"pName"];
            }else{
                sGoods.starShopGoodsName=@"null";
            }
            
            if (![sGoods.starShopGoodsPrice isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsPrice=[item valueForKey:@"productPrice"];
            }else{
                sGoods.starShopGoodsPrice=@"null";
            }
            
            
            if (![sGoods.starShopGoodsDiscount isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsDiscount=[item valueForKey:@"productDiscount"];
            }else{
                sGoods.starShopGoodsDiscount=@"null";
            }
            
            
            if (![sGoods.starShopGoodsDiscountTime isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsDiscountTime=[item valueForKey:@"discountTime"];
            }else{
                sGoods.starShopGoodsDiscountTime=@"null";
            }
            
            
            if (![sGoods.starShopGoodsBrand isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsBrand=[item valueForKey:@"productBrand"];
            }else{
                sGoods.starShopGoodsBrand=@"null";
            }
            
            
            if (![sGoods.starShopGoodsStyle isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsStyle=[item valueForKey:@"productStyle"];
            }else{
                sGoods.starShopGoodsStyle=@"null";
            }
            
            
            
            if (![sGoods.starShopGoodsPlace isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsPlace=[item valueForKey:@"productPlace"];
            }else{
                sGoods.starShopGoodsPlace=@"null";
            }
            
            
            if (![sGoods.starShopGoodsId isKindOfClass:[NSNull class]]) {
                sGoods.starShopGoodsId=[[item valueForKey:@"productID"] stringValue];
            }else{
                sGoods.starShopGoodsId=@"null";
            }
            
            
            NSString *flashImageUrl=[item valueForKey:@"productImage"];
            if (![flashImageUrl isKindOfClass:[NSNull class]]) {
                NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
                sGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
                
            }
        
            [_starShopGoods addObject:sGoods];
        }
        
    }

    
    return _starShopGoods;
    
}


//显示明星店铺商品详情
-(NSMutableArray *)showStarShopGoodsMsg:(NSString *)goodsID{
    NSError *error=nil;
    NSString *string7=@"getproductById.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string7];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:goodsID forKey:@"id"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];

    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    if (items!=[NSNull null]) {
        _starShopGoodsgoodsDetails=[NSMutableArray arrayWithCapacity:32];
        StarShopGoods *sgoods;
        
        sgoods=[[StarShopGoods alloc] init];
        
        
        if (![sgoods.starShopGoodsName isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsName=[items valueForKey:@"pName"];
        }else{
            sgoods.starShopGoodsName=@"null";
        }
        
        
        
        if (![sgoods.starShopGoodsPrice isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsPrice=[items valueForKey:@"productPrice"];
        }else{
            sgoods.starShopGoodsPrice=@"null";
        }
        
        
        if (![sgoods.starShopGoodsDiscount isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsDiscount=[items valueForKey:@"productDiscount"];
        }else{
            sgoods.starShopGoodsDiscount=@"null";
        }
        
        
        if (![sgoods.starShopGoodsDiscountTime isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsDiscountTime=[items valueForKey:@"discountTime"];
        }else{
            sgoods.starShopGoodsDiscountTime=@"null";
        }
        
        
        if (![sgoods.starShopGoodsBrand isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsBrand=[items valueForKey:@"productBrand"];
        }else{
            sgoods.starShopGoodsBrand=@"null";
        }
        
        
        if (![sgoods.starShopGoodsStyle isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsStyle=[items valueForKey:@"productStyle"];
        }else{
            sgoods.starShopGoodsStyle=@"null";
        }
        
        
        if (![sgoods.starShopGoodsPlace isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsPlace=[items valueForKey:@"productPlace"];
        }else{
            sgoods.starShopGoodsPlace=@"null";
        }
        
        
        
        if (![sgoods.starShopGoodsId isKindOfClass:[NSNull class]]) {
            sgoods.starShopGoodsId=[[items valueForKey:@"productID"] stringValue];
        }else{
            sgoods.starShopGoodsId=@"null";
        }
        
        
        NSString *gPictureUrl;
        NSMutableArray *gArray=[NSMutableArray array];
        for (NSString *s in [items valueForKeyPath:@"productimageslist.pIName"]) {
            if (![s isKindOfClass:[NSNull class]]) {
                gPictureUrl= [_pubUrl stringByAppendingString:s];
                [gArray addObject:[[Picture alloc] initWithURL:gPictureUrl]];
            }
            
        }
        sgoods.starShopGoodsImage=gArray;
        
        
        
        //商品详情图片
        NSString *PictureUrl;
        NSMutableArray *Array=[NSMutableArray array];
        for (NSString *s in [items valueForKeyPath:@"productinfoimagesModelslist.productinfoimagesName"]) {
            if (![s isKindOfClass:[NSNull class]]) {
                PictureUrl= [_pubUrl stringByAppendingString:s];
                [Array addObject:[[Picture alloc] initWithURL:PictureUrl]];
                
            }
            
        }
        sgoods.thumbPicture2=Array;
        
        NSLog(@"thumbPictures2=%@",sgoods.thumbPicture2);

        
        
        
        
        [_starShopGoodsgoodsDetails addObject:sgoods];
        
    }
    
    
    return _starShopGoodsgoodsDetails;


}



//显示侧滑商品共用接口
-(NSMutableArray *)showMenuGoods:(NSString *)idType{
    NSError *error=nil;
    NSString *string8=@"getAllproductBytypeId.do?id=";
    NSString *trueUrl=[string8 stringByAppendingString:idType];
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:trueUrl];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];

    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    id items=[dictionary valueForKey:@"msg"];

    if (items!=[NSNull null]) {
        _menuGoods=[NSMutableArray arrayWithCapacity:32];
        Goods *menuGoods;

        for (NSDictionary *item in  items) {
            menuGoods=[[Goods alloc] init];
            
            if (![menuGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
                menuGoods.goodsDiscount=[item valueForKey:@"productDiscount"];
            }else{
                menuGoods.goodsDiscount=@"null";
            }
            
            
            if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
                menuGoods.goodsName=[item valueForKey:@"pName"];
            }else{
                menuGoods.goodsName=@"null";
            }
            
            if (![menuGoods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
                menuGoods.goodsDiscountTime=[item valueForKey:@"discountTime"];
            }else{
                menuGoods.goodsDiscountTime=@"null";
            }
            
            
            if (![menuGoods.goodsID isKindOfClass:[NSNull class]]) {
                menuGoods.goodsID=[[item valueForKey:@"productID"] stringValue];
            }else{
                menuGoods.goodsID=@"null";
            }
            
            
            if (![menuGoods.goodsPrice isKindOfClass:[NSNull class]]) {
                menuGoods.goodsPrice=[item valueForKey:@"productPrice"];
            }else{
                menuGoods.goodsPrice=@"null";
            }
            
            
            if (![menuGoods.goodsStyle isKindOfClass:[NSNull class]]) {
                menuGoods.goodsStyle=[item valueForKey:@"productStyle"];
            }else{
                menuGoods.goodsStyle=@"null";
            }
            
            
            if (![menuGoods.goodsPlace isKindOfClass:[NSNull class]]) {
                menuGoods.goodsPlace=[item valueForKey:@"productPlace"];
            }else{
                menuGoods.goodsPlace=@"null";
            }
            
            
            if (![menuGoods.goodsBrand isKindOfClass:[NSNull class]]) {
                menuGoods.goodsBrand=[item valueForKey:@"productBrand"];
            }else{
                menuGoods.goodsBrand=@"null";
            }
            
            
            NSString *scPictureUrl;
            NSMutableArray *scArray=[NSMutableArray array];
            for (NSString *s in [item valueForKeyPath:@"productimageslist.pIName"]) {
                if (![s isKindOfClass:[NSNull class]]) {
                    scPictureUrl=[_pubUrl stringByAppendingString:s];
                    [scArray addObject:[[Picture alloc] initWithURL:scPictureUrl]];
                }
                
            }
            menuGoods.thumbPictures=scArray;
 
            [_menuGoods addObject:menuGoods];
        }
    }


    return _menuGoods;
}



//美食商品显示公用接口
-(NSMutableArray *)showGoodFoods:(NSString *)idType{
    NSError *error=nil;
    NSString *string8=@"getFoodByTypeID.do?typeID=";
    NSString *trueUrl=[string8 stringByAppendingString:idType];
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:trueUrl];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    NSLog(@"itemsss=%@",items);
    if (items!=[NSNull null]) {
        _goodFoods=[NSMutableArray arrayWithCapacity:32];
        Goods *menuGoods;
        
        for (NSDictionary *item in  items) {
            menuGoods=[[Goods alloc] init];
            
            
            if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
                menuGoods.goodsName=[item valueForKey:@"foodName"];
            }else{
                menuGoods.goodsName=@"null";
            }
            
            
            if (![menuGoods.goodsID isKindOfClass:[NSNull class]]) {
                menuGoods.goodsID=[[item valueForKey:@"foodID"] stringValue];
            }else{
                menuGoods.goodsID=@"null";
            }

            
            if (![menuGoods.goodsPrice isKindOfClass:[NSNull class]]) {
                menuGoods.goodsPrice=[item valueForKey:@"foodPrice"];
            }else{
                menuGoods.goodsPrice=@"null";
            }
            
            
            if (![menuGoods.goodsDesc isKindOfClass:[NSNull class]]) {
                menuGoods.goodsDesc=[item valueForKey:@"description"];
            }else{
                menuGoods.goodsDesc=@"null";
            }
            
            
            
            
            NSString *hPictureUrl=[item valueForKey:@"image"];
            if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                menuGoods.thumbPicture=[[Picture alloc] initWithURL:helpPictureUrl];
            }

            
            [_goodFoods addObject:menuGoods];
        }
    }
    
    
    return _goodFoods;


}


//信息商品显示公用接口
-(NSMutableArray *)showMessageGoods:(NSString *)idType{
    NSError *error=nil;
    NSString *string9=@"getInfoMsgByTypeID.do?typeID=";
    NSString *trueUrl=[string9 stringByAppendingString:idType];
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:trueUrl];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg1"];//置顶的信息
    id items1=[dictionary valueForKey:@"msg"];//未置顶的信息

    _msgGoods=[NSMutableArray arrayWithCapacity:32];
    Goods *menuGoods;
    if (items!=[NSNull null]) {
        
        
        for (NSDictionary *item in  items) {
            menuGoods=[[Goods alloc] init];
            if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
                menuGoods.goodsName=[item valueForKey:@"infoName"];
            }else{
                menuGoods.goodsName=@"null";
            }
            
            
            if (![menuGoods.goodsID isKindOfClass:[NSNull class]]) {
                menuGoods.goodsID=[[item valueForKey:@"infoID"] stringValue];
            }else{
                menuGoods.goodsID=@"null";
            }
            
            
            if (![menuGoods.goodsPrice isKindOfClass:[NSNull class]]) {
                menuGoods.goodsPrice=[item valueForKey:@"money"];
            }else{
                menuGoods.goodsPrice=@"null";
            }
            
            
            if (![menuGoods.goodsDesc isKindOfClass:[NSNull class]]) {
                menuGoods.goodsDesc=[item valueForKey:@"infoDescription"];
            }else{
                menuGoods.goodsDesc=@"null";
            }
            
            NSString *hPictureUrl=[item valueForKey:@"infoImage"];
            if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                menuGoods.thumbPicture=[[Picture alloc] initWithURL:helpPictureUrl];
            }
            
            [_msgGoods addObject:menuGoods];
        }
    }
    
    
    if (items!=[NSNull null]) {
        
        
        for (NSDictionary *item in  items1) {
            menuGoods=[[Goods alloc] init];
            if (![menuGoods.goodsName isKindOfClass:[NSNull class]]) {
                menuGoods.goodsName=[item valueForKey:@"infoName"];
            }else{
                menuGoods.goodsName=@"null";
            }
            
            
            if (![menuGoods.goodsID isKindOfClass:[NSNull class]]) {
                menuGoods.goodsID=[[item valueForKey:@"infoID"] stringValue];
            }else{
                menuGoods.goodsID=@"null";
            }
            
            
            if (![menuGoods.goodsPrice isKindOfClass:[NSNull class]]) {
                menuGoods.goodsPrice=[item valueForKey:@"money"];
            }else{
                menuGoods.goodsPrice=@"null";
            }
            
            
            if (![menuGoods.goodsDesc isKindOfClass:[NSNull class]]) {
                menuGoods.goodsDesc=[item valueForKey:@"infoDescription"];
            }else{
                menuGoods.goodsDesc=@"null";
            }
            
            NSString *hPictureUrl=[item valueForKey:@"infoImage"];
            if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                menuGoods.thumbPicture=[[Picture alloc] initWithURL:helpPictureUrl];
            }
            
            [_msgGoods addObject:menuGoods];
        }
    }

    
    
    return _msgGoods;


}



//显示限时活动商品
-(NSMutableArray *)showFlashGoods:(NSString *)goodsID{
    NSError *error=nil;
    NSString *string10=@"getprobuctByDis.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string10];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:goodsID forKey:@"id"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    if (items!=[NSNull null] && ![items isEqual:@"2"]) {
        _flashGoods=[NSMutableArray arrayWithCapacity:32];
        Goods *sGoods;
        for (NSDictionary *item in  items) {
            
            sGoods=[[Goods alloc] init];
            
            if (![sGoods.goodsName isKindOfClass:[NSNull class]]) {
                sGoods.goodsName=[item valueForKey:@"pName"];
            }else{
                sGoods.goodsName=@"null";
            }
            
            if (![sGoods.goodsPrice isKindOfClass:[NSNull class]]) {
                sGoods.goodsPrice=[item valueForKey:@"productPrice"];
            }else{
                sGoods.goodsPrice=@"null";
            }
            
            if (![sGoods.goodsDiscount isKindOfClass:[NSNull class]]) {
                sGoods.goodsDiscount=[item valueForKey:@"productDiscount"];
            }else{
                sGoods.goodsDiscount=@"null";
            }
            
            
            if (![sGoods.goodsDiscountTime isKindOfClass:[NSNull class]]) {
                sGoods.goodsDiscountTime=[item valueForKey:@"discountTime"];
            }else{
                sGoods.goodsDiscountTime=@"null";
            }
            
            
            if (![sGoods.goodsID isKindOfClass:[NSNull class]]) {
                sGoods.goodsID=[[item valueForKey:@"productID"] stringValue];
            }else{
                sGoods.goodsID=@"null";
            }

            
 
            NSString *flashImageUrl=[item valueForKey:@"productImage"];
            if (![flashImageUrl isKindOfClass:[NSNull class]]) {
                NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
                sGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];

            }
            
            [_flashGoods addObject:sGoods];
        }
        
    }
    
    return _flashGoods;

}


//显示搜索商品
-(NSMutableArray *)showSearchGoods:(NSString *)goodsName{
    NSError *error=nil;
    NSString *string11=@"getproByLikeName.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string11];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:goodsName forKey:@"name"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    if (items!=[NSNull null]) {
        _searchGoods=[NSMutableArray arrayWithCapacity:32];
        Goods *sGoods;
        for (NSDictionary *item in  items) {
            
            sGoods=[[Goods alloc] init];
            
            if (![sGoods.goodsName isKindOfClass:[NSNull class]]) {
                sGoods.goodsName=[item valueForKey:@"pName"];
            }else{
                sGoods.goodsName=@"null";
            }
            
            
            if (![sGoods.goodsID isKindOfClass:[NSNull class]]) {
                sGoods.goodsID=[[item valueForKey:@"productID"] stringValue];
            }else{
                sGoods.goodsID=@"null";
            }
            
            
            
            if (![sGoods.goodsDesc isKindOfClass:[NSNull class]]) {
                sGoods.goodsDesc=[item valueForKey:@"description"];
            }else{
                sGoods.goodsDesc=@"null";
            }
            
           
            
            NSString *flashImageUrl=[item valueForKey:@"productImage"];
            if (![flashImageUrl isKindOfClass:[NSNull class]]) {
                NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
                sGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
            }
            
            
            [_searchGoods addObject:sGoods];
        }
        
    }
    
    
    return _searchGoods;

}



//显示搜索店铺
-(NSMutableArray *)showSearchShops:(NSString *)shopsName{
    NSError *error=nil;
    NSString *string11=@"getShopByLikeName.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string11];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:shopsName forKey:@"name"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    if (items!=[NSNull null]) {
        _searchShops=[NSMutableArray arrayWithCapacity:32];
        Goods *sGoods;
        for (NSDictionary *item in  items) {
            
            sGoods=[[Goods alloc] init];
            
            if (![sGoods.goodsName isKindOfClass:[NSNull class]]) {
                sGoods.goodsName=[item valueForKey:@"bSName"];
            }else{
                sGoods.goodsName=@"null";
            }
            
            
            if (![sGoods.starShopId isKindOfClass:[NSNull class]]) {
                sGoods.starShopId=[[item valueForKey:@"businessShopID"] stringValue];
            }else{
                sGoods.starShopId=@"null";
            }
            
            
            
            if (![sGoods.goodsDesc isKindOfClass:[NSNull class]]) {
                sGoods.goodsDesc=[item valueForKey:@"bSDetail"];
            }else{
                sGoods.goodsDesc=@"null";
            }
            
            
            
            NSString *flashImageUrl=[item valueForKey:@"img"];
            if (![flashImageUrl isKindOfClass:[NSNull class]]) {
                NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
                sGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
            }
            
            
            [_searchShops addObject:sGoods];
        }
        
    }
    return _searchShops;
}





//用户开店  成功1  失败2
-(NSMutableArray *)userCreateStore:(NSString *)userId withStoreImage:(NSString *)storeImage withStoreName:(NSString *)storeName withStorePayNumber:(NSString *)storePayNum{
    NSString *string12=@"saveShop.do";
    NSString *registerServiceUrl = [publicUrl stringByAppendingString:string12];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    [reqParams setObject:storeImage forKey:@"img"];
    [reqParams setObject:storeName forKey:@"name"];
    [reqParams setObject:storePayNum forKey:@"pay"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:registerServiceUrl :reqParams];
    
    //解析Json
    NSMutableDictionary *result=[JsonParser parseJsonStrToDict:[[NSMutableString alloc]initWithString:jsonString]];

    
    Store *store;
    _storeMsg=[NSMutableArray arrayWithCapacity:32];
    //处理返回数据
    id  resmsg= [result objectForKey:@"msg"];
    if (resmsg!=[NSNull null]) {
        
        store=[[Store alloc] initWithShopId:[[resmsg valueForKey:@"businessShopID"] stringValue] withShopName:[resmsg valueForKey:@"bSName"] withShopPay:[resmsg valueForKey:@"bSPay"] withShopImg:[resmsg valueForKey:@"img"]];
        
        [_storeMsg addObject:store];
        
    }
    
    
    
    NSString *msg1=[result objectForKey:@"check"];
    if (![msg1 isEqualToString:@"1"]) {
        NSLog(@"开店失败");
        return nil;
    }
    
    
    return _storeMsg;

}


//显示侧滑广告图片共用接口
-(NSMutableArray *)showMenuHeaderImage:(NSString *)idType{
    NSError *error=nil;
    NSString *string13=@"getAllproductBytypeId.do?id=";
    NSString *trueUrl=[string13 stringByAppendingString:idType];
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:trueUrl];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];

    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
     //广告图
     id items1=[dictionary valueForKey:@"msg1"];
     if (items1!=[NSNull null]) {
         _menuImages=[NSMutableArray arrayWithCapacity:32];
         Goods *menuGoods;
         menuGoods=[[Goods alloc] init];
         NSString *flashImageUrl=[items1 valueForKey:@"photoAdverName"];
         if (![flashImageUrl isKindOfClass:[NSNull class]]) {
             NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
             menuGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
     
             [_menuImages addObject:menuGoods];
         }
     }
    
    return _menuImages;

}



//明星店铺广告接口
-(NSMutableArray *)showStarShopHeaderImage{
    NSError *error=nil;
    NSString *string14=@"getbusinessshopBylevel.do?id=1";
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string14];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    //广告图
    id items1=[dictionary valueForKey:@"msg1"];
    if (items1!=[NSNull null]) {
        _homePageImages=[NSMutableArray arrayWithCapacity:32];
        Goods *menuGoods;
        menuGoods=[[Goods alloc] init];
        NSString *flashImageUrl=[items1 valueForKey:@"photoAdverName"];
        if (![flashImageUrl isKindOfClass:[NSNull class]]) {
            NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
            menuGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
            
            [_homePageImages addObject:menuGoods];
        }
    }
    
    return _homePageImages;

}


//美妆精选广告接口
-(NSMutableArray *)showBeautyHeaderImage{
    NSError *error=nil;
    NSString *string15=@"getMeiZhuangjx.do?pid=1&id=2";
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string15];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    //广告图
    id items1=[dictionary valueForKey:@"msg1"];
    if (items1!=[NSNull null]) {
        _homePageImages=[NSMutableArray arrayWithCapacity:32];
        Goods *menuGoods;
        menuGoods=[[Goods alloc] init];
        NSString *flashImageUrl=[items1 valueForKey:@"photoAdverName"];
        if (![flashImageUrl isKindOfClass:[NSNull class]]) {
            NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
            menuGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
            
            [_homePageImages addObject:menuGoods];
        }
    }
    
    return _homePageImages;

}



//帮扶店铺广告接口
-(NSMutableArray *)showHelpShopHeaderImage{
    NSError *error=nil;
    NSString *string16=@"getbusinessshopBylevel.do?id=3";
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string16];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    //广告图
    id items1=[dictionary valueForKey:@"msg1"];
    if (items1!=[NSNull null]) {
        _homePageImages=[NSMutableArray arrayWithCapacity:32];
        Goods *menuGoods;
        menuGoods=[[Goods alloc] init];
        NSString *flashImageUrl=[items1 valueForKey:@"photoAdverName"];
        if (![flashImageUrl isKindOfClass:[NSNull class]]) {
            NSString *starPictureUrl=[_pubUrl stringByAppendingString:flashImageUrl];
            menuGoods.thumbPicture=[[Picture alloc] initWithURL:starPictureUrl];
            
            [_homePageImages addObject:menuGoods];
        }
    }
    
    return _homePageImages;
}



//最新上线两张小图片广告

-(NSMutableArray *)showLatestOnlineTwoSmallImage{
    NSError *error=nil;
    NSString *string17=@"getnewproduct.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string17];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg2"];
    
    if (items!=[NSNull null]) {
        _homePageImages=[NSMutableArray arrayWithCapacity:32];
        Goods *sGoods;
        NSString *scPictureUrl;
        NSMutableArray *scArray=[NSMutableArray array];
        for (NSString *s in [items valueForKey:@"photoAdverName"]) {
            sGoods=[[Goods alloc] init];
            if (![s isKindOfClass:[NSNull class]]) {
                scPictureUrl=[_pubUrl stringByAppendingString:s];
                [scArray addObject:[[Picture alloc] initWithURL:scPictureUrl]];
                
                sGoods.thumbPictures=scArray;
                
                [_homePageImages addObject:sGoods];

            }
            
        }
    }
    
    NSLog(@"searchGoods=%@",_homePageImages);
    
    return _homePageImages;
    

}



//最新上线轮播图////////zheli 
-(NSMutableArray *)showLatestOnlineHeaderImage{

    NSError *error=nil;
    NSString *string17=@"getnewproduct.do";
    NSString *latestOnlineGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string17];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:latestOnlineGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg1"];
    
    if (items!=[NSNull null]) {
        _homePageImages=[NSMutableArray arrayWithCapacity:32];
        Goods *sGoods;
        NSString *scPictureUrl;
        NSMutableArray *scArray=[NSMutableArray array];
        for (NSString *s in [items valueForKey:@"photoName"]) {
            sGoods=[[Goods alloc] init];
            if (![s isKindOfClass:[NSNull class]]) {
                scPictureUrl=[_pubUrl stringByAppendingString:s];
                [scArray addObject:[[Picture alloc] initWithURL:scPictureUrl]];
                
                
                sGoods.thumbPictures=scArray;
                
                [_homePageImages addObject:sGoods];
            }
            
        }

    }

    
    return _homePageImages;

}





//显示积分兑换商品
-(NSMutableArray *)showNowPointsGoods:(NSString *)usersID{
    NSError *error=nil;
    NSString *string18=@"getAllScoringproduct.do";
    NSString *menuGoodsMsgServiceUrl=[publicUrl stringByAppendingString:string18];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    [reqParams setObject:usersID forKey:@"usersID"];

    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    
    
    if (items!=[NSNull null]) {
        _pointsGoods=[NSMutableArray arrayWithCapacity:32];
        Goods *pointsGoods;
        
        for (NSDictionary *item in  items) {
            pointsGoods=[[Goods alloc] init];
            if (![pointsGoods.goodsName isKindOfClass:[NSNull class]]) {
                pointsGoods.goodsName=[item valueForKey:@"scoringProductName"];
            }else{
                pointsGoods.goodsName=@"null";
            }
            
            
            if (![pointsGoods.goodsID isKindOfClass:[NSNull class]]) {
                pointsGoods.goodsID=[[item valueForKey:@"scoringID"] stringValue];
            }else{
                pointsGoods.goodsID=@"null";
            }
            
            
            if (![pointsGoods.goodsPoints isKindOfClass:[NSNull class]]) {
                pointsGoods.goodsPoints=[[item valueForKey:@"scoringNum"] stringValue];
            }else{
                pointsGoods.goodsPoints=@"null";
            }
            
            
            if (![pointsGoods.goodsNum isKindOfClass:[NSNull class]]) {
                pointsGoods.goodsNum=[[item valueForKey:@"scoringProductNum"] stringValue];
            }else{
                pointsGoods.goodsNum=@"null";
            }
            
            NSString *hPictureUrl=[item valueForKey:@"imageProduct"];
            if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                pointsGoods.thumbPicture=[[Picture alloc] initWithURL:helpPictureUrl];
                
                [_pointsGoods addObject:pointsGoods];
            }
            
            
        }
    }
    
    //获取当前用户积分
    NSString *myPoints=[dictionary valueForKey:@"Scoring"];
    NSLog(@"myPoints=%@",myPoints);
    
    
    return _pointsGoods;
}


//用户兑换商品
-(BOOL)userGetPointGoods:(NSString *)userID withPointGoodsId:(NSString *)goodsId withNum:(NSString *)num{
    NSString *string19=@"exchangeScoringToProduct.do";
    NSString *registerServiceUrl = [publicUrl stringByAppendingString:string19];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userID forKey:@"usersID"];
    [reqParams setObject:goodsId forKey:@"scoringID"];
    [reqParams setObject:num forKey:@"pNum"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:registerServiceUrl :reqParams];
    
    NSMutableDictionary *result=[JsonParser parseJsonStrToDict:[[NSMutableString alloc]initWithString:jsonString]];
    
    //处理返回数据
    NSString  *resmsg= [result objectForKey:@"check"];
    
    if (![resmsg isEqualToString:@"1"]) {
        NSLog(@"兑换失败");
        return NO;
    }
    
    NSString *myPucductNum=[[result valueForKey:@"ProductNum"] stringValue];
    NSLog(@"ProductNum=%@",myPucductNum);
    
    return YES;
}


//添加收获地址
-(BOOL)saveorupdataAddressWithUserId:(NSString *)uid withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county withAddressInfo:(NSString *)addressInfo withReceive:(NSString *)receive withReceivePhone:(NSString *)receivePhone{
    NSString *string20=@"savaorupdataAddress.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string20];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:uid forKey:@"uid"];
    [reqParams setObject:province forKey:@"province"];
    [reqParams setObject:city forKey:@"city"];
    [reqParams setObject:county forKey:@"county"];
    [reqParams setObject:addressInfo forKey:@"addressinfo"];
    [reqParams setObject:receive forKey:@"receive"];
    [reqParams setObject:receivePhone forKey:@"receivephone"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSMutableDictionary *result=[JsonParser parseJsonStrToDict:[[NSMutableString alloc]initWithString:jsonString]];
    
    NSString *errCode=[[result objectForKey:@"check"] stringValue];
    
    if (![errCode isEqualToString:@"1"]) {
        NSLog(@"添加失败!errCode:%@",errCode);
        return  NO;
    }
    
    NSLog(@"添加成功!errCode:%@",errCode);
    return YES;

}



//查询当前用户所有地址
-(NSMutableArray *)showCurrentUserAddress:(NSString *)userid{
    NSError *error=nil;
    NSString *string21=@"getAddressByuid.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string21];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userid forKey:@"uid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    NSLog(@"addressitems=%@",items);
    if (items!=[NSNull null]) {
        _addressMsg=[NSMutableArray arrayWithCapacity:32];
        AddAddress *address;
        
        for (NSDictionary *item in  items) {
            address=[[AddAddress alloc] init];
            
            if (![address.addressId isKindOfClass:[NSNull class]]) {
                address.addressId=[[item valueForKey:@"addressID"] stringValue];
            }else{
                address.addressId=@"null";
            }
            
            if (![address.province isKindOfClass:[NSNull class]]) {
                address.province=[item valueForKey:@"aProvince"];
            }else{
                address.province=@"null";
            }
            
            
            if (![address.city isKindOfClass:[NSNull class]]) {
                address.city=[item valueForKey:@"acity"];
            }else{
                address.city=@"null";
            }
            
            
            if (![address.county isKindOfClass:[NSNull class]]) {
                address.county=[item valueForKey:@"acounty"];
            }else{
                address.county=@"null";
            }
            
            
            if (![address.addressinfo isKindOfClass:[NSNull class]]) {
                address.addressinfo=[item valueForKey:@"withaddress"];
            }else{
                address.addressinfo=@"null";
            }
            
            
            if (![address.receive isKindOfClass:[NSNull class]]) {
                address.receive=[item valueForKey:@"receive"];
            }else{
                address.receive=@"null";
            }
            
            if (![address.receivephone isKindOfClass:[NSNull class]]) {
                address.receivephone=[item valueForKey:@"receivephone"];
            }else{
                address.receivephone=@"null";
            }
            
            
            
            [_addressMsg addObject:address];
        }
    }
    return _addressMsg;

}




//用户发布信息  成功1?  失败2?
-(BOOL)userReleaseMsg:(NSString *)userId withInfoName:(NSString *)infoName withInfoTypeId:(NSString *)typeId withImageName:(NSString *)imageName withInfoContent:(NSString *)infoContent withInfoMoney:(NSString *)InfoMoney{
    NSString *string12=@"saveInfoMsg.do";
    NSString *registerServiceUrl = [publicUrl stringByAppendingString:string12];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"usersID"];
    [reqParams setObject:infoName forKey:@"infoName"];
    [reqParams setObject:typeId forKey:@"infoTypeID"];
    [reqParams setObject:imageName forKey:@"imgPath1"];
    [reqParams setObject:infoContent forKey:@"content"];
    [reqParams setObject:InfoMoney forKey:@"money"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:registerServiceUrl :reqParams];
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"发布信息失败");
        return NO;
    }
    return YES;
}




//用户发布美食  成功1?  失败2?
-(BOOL)userReleaseFood:(NSString *)userId withInfoName:(NSString *)infoName withInfoTypeId:(NSString *)typeId withImageName:(NSString *)imageName withInfoContent:(NSString *)infoContent withInfoMoney:(NSString *)InfoMoney withImagePaths:(NSString *)imagePaths{

    NSString *string12=@"saveFood.do";
    NSString *registerServiceUrl = [publicUrl stringByAppendingString:string12];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"usersID"];
    [reqParams setObject:infoName forKey:@"foodName"];
    [reqParams setObject:typeId forKey:@"foodtypeID"];
    [reqParams setObject:imageName forKey:@"imgPath1"];
    [reqParams setObject:infoContent forKey:@"content"];
    [reqParams setObject:InfoMoney forKey:@"foodPrice"];
    [reqParams setObject:imagePaths forKey:@"imagePaths"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:registerServiceUrl :reqParams];
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"发布美食失败");
        return NO;
    }
    return YES;


}




//显示我的店铺头部信息
-(NSMutableArray *)showMyStoreMsg:(NSString *)uid{
    NSError *error=nil;
    NSString *string21=@"getbusinessshopByuids.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string21];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:uid forKey:@"uid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    //NSLog(@"addressitems=%@",items);
    if (items!=[NSNull null]) {
        _storeMsg=[NSMutableArray arrayWithCapacity:32];
        Store *store;
        store=[[Store alloc] init];
            
        if (![store.myStoreName isKindOfClass:[NSNull class]]) {
            store.myStoreName=[items valueForKey:@"bSName"];
        }else{
            store.myStoreName=@"null";
        }
        
        
        if (![store.storeId isKindOfClass:[NSNull class]]) {
            store.storeId=[items valueForKey:@"businessShopID"];
        }else{
            store.storeId=@"null";
        }
        
        
        if (![store.moneyGiveYesOrNo isKindOfClass:[NSNull class]]) {
            store.moneyGiveYesOrNo=[[items valueForKeyPath:@"shopStateModel.shopStateID"] stringValue];
        }else{
            store.moneyGiveYesOrNo=@"null";
        }
            
            
        NSString *hPictureUrl=[items valueForKey:@"img"];
        if (![hPictureUrl isKindOfClass:[NSNull class]]) {
            NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
            store.myStorePicture=[[Picture alloc] initWithURL:helpPictureUrl];
                
            [_storeMsg addObject:store];
        }

    }
    return _storeMsg;
}




//添加商品时获取商品类型
-(NSMutableArray *)getGoodsType{
    NSError *error=nil;
    NSString *string9=@"getTypeBySaveProduct.do";
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string9];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    NSLog(@"ssss=%@",items);
    if (items!=[NSNull null]) {
        _goodsTypeArray=[NSMutableArray arrayWithCapacity:32];
        GoodsType *typeGoods;
        
        for (NSDictionary *item in  items) {
            typeGoods=[[GoodsType alloc] init];
            if (![typeGoods.productTypeId isKindOfClass:[NSNull class]]) {
                typeGoods.productTypeId=[[item valueForKey:@"productTypeID"] stringValue];
            }else{
                typeGoods.productTypeId=@"null";
            }
            
            
            if (![typeGoods.productTypeName isKindOfClass:[NSNull class]]) {
                typeGoods.productTypeName=[item valueForKey:@"productTypeName"];
            }else{
                typeGoods.productTypeName=@"null";
            }
            
            
            NSString *hPictureUrl=[item valueForKey:@"productTypeImage"];
            if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                typeGoods.productTypeImage=[[Picture alloc] initWithURL:helpPictureUrl];
            }
            
            [_goodsTypeArray addObject:typeGoods];
        }
    }

    return _goodsTypeArray;

}





//用户添加商品
-(BOOL)userAddGoods:(NSString *)goodsName withGoodsTypeId:(NSString *)goodsTypeId withStoreId:(NSString *)storeId withGoodsBrand:(NSString *)goodsBrand withGoodsStyle:(NSString *)goodsStyle withGoodsPlace:(NSString *)goodsPlace withGoodsPrice:(NSString *)goodsPrice withGoodsDiscount:(NSString *)goodsDiscount withGoodsContent:(NSString *)goodsContent withGoodsImgPath1:(NSString *)GoodsImgPath1 withGoodsImagePaths:(NSString *)goodsImagePaths withGoodsImageInfoPaths:(NSString *)imageInfoPaths{
    NSString *string12=@"saveorupdataProduct.do";
    NSString *registerServiceUrl = [publicUrl stringByAppendingString:string12];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:goodsName forKey:@"pname"];
    [reqParams setObject:goodsTypeId forKey:@"productTypeid"];
    [reqParams setObject:storeId forKey:@"businessShopid"];
    [reqParams setObject:goodsBrand forKey:@"productBrand"];
    [reqParams setObject:goodsStyle forKey:@"productStyle"];
    [reqParams setObject:goodsPlace forKey:@"productPlace"];
    [reqParams setObject:goodsPrice forKey:@"productPrice"];
    [reqParams setObject:goodsDiscount forKey:@"productDiscount"];
    [reqParams setObject:goodsContent forKey:@"content"];
    [reqParams setObject:GoodsImgPath1 forKey:@"imgPath1"];
    [reqParams setObject:goodsImagePaths forKey:@"imagePaths"];
    [reqParams setObject:imageInfoPaths forKey:@"imageInfoPaths"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:registerServiceUrl :reqParams];
    
    if (![jsonString isEqualToString:@"1"]) {
        NSLog(@"添加商品失败");
        return NO;
    }
    return YES;
    
}



//显示上架商品
-(NSMutableArray *)inTheSaleGoods:(NSString *)userId{
    NSError *error=nil;
    NSString *string21=@"getbusinessshopByuids.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string21];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    //上下架商品数据获取
    id goodsItems=[dictionary valueForKey:@"msg1"];
    if (goodsItems!=[NSNull null]) {
         _saleGoods=[NSMutableArray arrayWithCapacity:32];
         Store *store;
        
         for (NSDictionary *item in  goodsItems) {
             store=[[Store alloc] init];
             if (![store.storeGoodsName isKindOfClass:[NSNull class]]) {
                 store.storeGoodsName=[item valueForKey:@"pName"];
             }else{
                 store.storeGoodsName=@"null";
             }
         
         
             if (![store.storeGoodsPrice isKindOfClass:[NSNull class]]) {
                 store.storeGoodsPrice=[item valueForKey:@"productPrice"];
             }else{
                 store.storeGoodsPrice=@"null";
             }
         
         
             if (![store.storeGoodsDesc isKindOfClass:[NSNull class]]) {
                 store.storeGoodsDesc=[item valueForKey:@"description"];
             }else{
                 store.storeGoodsDesc=@"null";
             }
         
         
             NSString *hPictureUrl=[item valueForKey:@"productImage"];
             if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                 NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                 store.storeGoodsImage=[[Picture alloc] initWithURL:helpPictureUrl];
         
                 
             }
             [_saleGoods addObject:store];
         
         
         }
    }
         
    
    return _saleGoods;


}

//显示下架商品
-(NSMutableArray *)outTheSaleGoods:(NSString *)userId{
    NSError *error=nil;
    NSString *string21=@"getbusinessshopByuids.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string21];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:userId forKey:@"uid"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    //上下架商品数据获取
    id goodsItems=[dictionary valueForKey:@"msg2"];
    if (goodsItems!=[NSNull null]) {
        _saleGoods=[NSMutableArray arrayWithCapacity:32];
        Store *store;
        
        for (NSDictionary *item in  goodsItems) {
            store=[[Store alloc] init];
            if (![store.storeGoodsName isKindOfClass:[NSNull class]]) {
                store.storeGoodsName=[item valueForKey:@"pName"];
            }else{
                store.storeGoodsName=@"null";
            }
            
            
            if (![store.storeGoodsPrice isKindOfClass:[NSNull class]]) {
                store.storeGoodsPrice=[item valueForKey:@"productPrice"];
            }else{
                store.storeGoodsPrice=@"null";
            }
            
            
            if (![store.storeGoodsDesc isKindOfClass:[NSNull class]]) {
                store.storeGoodsDesc=[item valueForKey:@"description"];
            }else{
                store.storeGoodsDesc=@"null";
            }
            
            
            NSString *hPictureUrl=[item valueForKey:@"productImage"];
            if (![hPictureUrl isKindOfClass:[NSNull class]]) {
                NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
                store.storeGoodsImage=[[Picture alloc] initWithURL:helpPictureUrl];
                
                
            }
            [_saleGoods addObject:store];
            
            
        }
    }
    
    
    return _saleGoods;

}




//关于明昊
-(NSMutableArray *)abboutMingHao{
    NSError *error=nil;
    NSString *string9=@"guanyuminghaoToApp.do";
    NSString *menuGoodsMsgServiceUrl = [publicUrl stringByAppendingString:string9];
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:menuGoodsMsgServiceUrl :reqParams];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    
    id goodsItems=[dictionary valueForKey:@"msg"];
    if (goodsItems!=[NSNull null]) {
        _abboutMingHaoArray=[NSMutableArray arrayWithCapacity:32];
        GoodsType *typeGoods;
        
        for (NSDictionary *item in  goodsItems) {
            typeGoods=[[GoodsType alloc] init];
            
            if (![typeGoods.productTypeName isKindOfClass:[NSNull class]]) {
                typeGoods.productTypeName=[item valueForKey:@"minghaoInfo"];
            }else{
                typeGoods.productTypeName=@"null";
            }
            
            
             NSString *hPictureUrl=[item valueForKey:@"minghaoImage"];
             if (![hPictureUrl isKindOfClass:[NSNull class]]) {
             NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
             typeGoods.productTypeImage=[[Picture alloc] initWithURL:helpPictureUrl];
             
             [_abboutMingHaoArray addObject:typeGoods];
             }
            
        }
    }

    
    
    return _abboutMingHaoArray;
}



//显示信息详情
-(NSMutableArray *)showMsgDesc:(NSString *)msgId{
    NSError *error=nil;
    NSString *string21=@"getInfoMsgById.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string21];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:msgId forKey:@"id"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    //NSLog(@"addressitems=%@",items);
    if (items!=[NSNull null]) {
        _messageDesc=[NSMutableArray arrayWithCapacity:32];
        MessageDesc *message;
        message=[[MessageDesc alloc] init];
        
        if (![message.messageDescName isKindOfClass:[NSNull class]]) {
            message.messageDescName=[items valueForKey:@"infoName"];
        }else{
            message.messageDescName=@"null";
        }
        
        
        if (![message.messageDescDesc isKindOfClass:[NSNull class]]) {
            message.messageDescDesc=[items valueForKey:@"infoDescription"];
        }else{
            message.messageDescDesc=@"null";
        }
 
        
        if (![message.messageDescTime isKindOfClass:[NSNull class]]) {
            message.messageDescTime=[items valueForKey:@"releaseTime"];
        }else{
            message.messageDescTime=@"null";
        }
        
        
        if (![message.messageDescMoney isKindOfClass:[NSNull class]]) {
            message.messageDescMoney=[items valueForKey:@"money"];
        }else{
            message.messageDescMoney=@"null";
        }
        
        
        if (![message.messageDescType isKindOfClass:[NSNull class]]) {
            message.messageDescType=[items valueForKeyPath:@"infotypeModel.infoTypeName"];
        }else{
            message.messageDescType=@"null";
        }
        
        
        NSString *hPictureUrl=[items valueForKey:@"infoImage"];
        if (![hPictureUrl isKindOfClass:[NSNull class]]) {
            NSString *helpPictureUrl=[_pubUrl stringByAppendingString:hPictureUrl];
            message.messageDescImage=[[Picture alloc] initWithURL:helpPictureUrl];
            
            [_messageDesc addObject:message];
        }
        
    }
    return _messageDesc;

}




//显示美食详情
-(NSMutableArray *)showFoodsDesc:(NSString *)foodsId{
    NSError *error=nil;
    NSString *string21=@"getFoodByID.do";
    NSString *loginServiceUrl = [publicUrl stringByAppendingString:string21];
    
    NSMutableDictionary *reqParams=[[NSMutableDictionary alloc]init];
    
    [reqParams setObject:foodsId forKey:@"id"];
    
    //发送请求并得到返回结果
    NSString *jsonString=[self sendHTTPRequest:loginServiceUrl :reqParams];
    
    //解析Json
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    id items=[dictionary valueForKey:@"msg"];
    
    //NSLog(@"addressitems=%@",items);
    if (items!=[NSNull null]) {
        _foodsDesc=[NSMutableArray arrayWithCapacity:32];
        GoodFoods *foods;
        foods=[[GoodFoods alloc] init];
        
        if (![foods.foodsDescId isKindOfClass:[NSNull class]]) {
            foods.foodsDescId=[items valueForKey:@"foodID"];
        }else{
            foods.foodsDescId=@"null";
        }
        
        NSLog(@"fd=%@",foods.foodsDescId);
        
        
        if (![foods.foodsDescName isKindOfClass:[NSNull class]]) {
            foods.foodsDescName=[items valueForKey:@"foodName"];
        }else{
            foods.foodsDescName=@"null";
        }
        
        
        if (![foods.foodsDescDesc isKindOfClass:[NSNull class]]) {
            foods.foodsDescDesc=[items valueForKey:@"description"];
        }else{
            foods.foodsDescDesc=@"null";
        }
        
        
        if (![foods.foodsDescMoney isKindOfClass:[NSNull class]]) {
            foods.foodsDescMoney=[items valueForKey:@"foodPrice"];
        }else{
            foods.foodsDescMoney=@"null";
        }
        
        
        
        
        NSString *gPictureUrl;
        NSMutableArray *gArray=[NSMutableArray array];
        for (NSString *s in [items valueForKeyPath:@"foodImageModelslist.foodImageName"]) {
            if (![s isKindOfClass:[NSNull class]]) {
                gPictureUrl= [_pubUrl stringByAppendingString:s];
                [gArray addObject:[[Picture alloc] initWithURL:gPictureUrl]];
                
            }
            
        }
        foods.thumbPictures=gArray;

        
        
        
        NSString *PictureUrl;
        NSMutableArray *Array=[NSMutableArray array];
        for (NSString *y in [items valueForKeyPath:@"foodInfoImageModelslist.foodInfoImageName"]) {
            if (![y isKindOfClass:[NSNull class]]) {
                PictureUrl= [_pubUrl stringByAppendingString:y];
                [Array addObject:[[Picture alloc] initWithURL:PictureUrl]];
                
            }
            
        }
        foods.thumbPictures2=Array;

        
        
        
        
        
        [_foodsDesc addObject:foods];
        
    }
    NSLog(@"fooddesc=%@",_foodsDesc);
    return _foodsDesc;

}


@end
