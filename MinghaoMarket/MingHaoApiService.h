//
//  MingHaoApiService.h
//  MinghaoMarket
//
//  Created by TOMSZ on 15/4/23.
//  Copyright (c) 2015年 TOMSZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Goods.h"
@interface MingHaoApiService : NSObject

//打包请求参数
-(NSMutableString *)packageReqParams:(NSMutableDictionary *)reqParams;

//发送请求(返回json字符串)
-(NSString *)sendHTTPRequest:(NSString *)urlString :(NSMutableDictionary *)reqParams;

//用户注册()
-(BOOL)registed:(User *)user;


//用户登录U01
-(NSMutableArray *)login:(User *)user;


//最新上线显示详情
-(NSMutableArray *)showLatestOnlineGoodsMsg:(NSString *)goodId;


@property(readonly)NSMutableArray *goodsDetails;

@property(readonly)NSMutableArray *starShopGoods;

@property(readonly)NSMutableArray *starShopGoodsgoodsDetails;

@property(readonly)NSMutableArray *flashGoods;


@property(readonly)NSMutableArray *searchGoods;


@property(readonly)NSMutableArray *searchShops;


@property(readonly)NSMutableArray *userList;

//-(void)loadFocusAndFooterImageForGoods:(Picture *)picture putOffLoadHandler:(void (^)(NSData *))handler;


//加入购物车传userid和goodsid
-(BOOL)addLatestOnlineGoodsToShoppingCar:(NSString *)userId withGoodsId:(NSString *)goodsId;

//加入购物车传userid和goodsid
-(BOOL)addLatestOnlineGoodsCollection:(NSString *)userId withGoodsId:(NSString *)goodsId;

//查询购物车商品
-(NSMutableArray *)queryShoppingCar:(NSString *)userId;



//查询收藏夹商品
-(NSMutableArray *)queryCollection:(NSString *)userId;

@property(readonly)NSMutableArray *shoppingCarGoods;


//删除购物车商品
-(BOOL)deleteShoppingCarGoods:(NSString *)userId withGoodsId:(NSString *)goodsId;



//删除收藏的商品
-(BOOL)deleteCollectionGoods:(NSString *)userId withGoodsId:(NSString *)goodsId;


//显示明星店铺商品
-(NSMutableArray *)showStarShopGoods:(NSString *)shopID;


//显示明星店铺商品详情
-(NSMutableArray *)showStarShopGoodsMsg:(NSString *)goodsID;


//显示限时活动商品
-(NSMutableArray *)showFlashGoods:(NSString *)goodsID;


//显示搜索商品
-(NSMutableArray *)showSearchGoods:(NSString *)goodsName;



//显示搜索店铺
-(NSMutableArray *)showSearchShops:(NSString *)shopsName;


//显示侧滑商品共用接口
-(NSMutableArray *)showMenuGoods:(NSString *)idType;


//美食商品显示公用接口
-(NSMutableArray *)showGoodFoods:(NSString *)idType;
@property(readonly)NSMutableArray *goodFoods;


//信息商品显示公用接口
-(NSMutableArray *)showMessageGoods:(NSString *)idType;
@property(readonly)NSMutableArray *msgGoods;


//侧滑图片  块  的方式回调取值
//-(void)loadMenuPicture:(Picture *)picture putOffLoadHandler:(void(^)(NSData *data))handler;

@property(readonly)NSMutableArray *menuGoods;


@property(readonly)NSMutableArray *menuImages;


@property(readonly)NSMutableArray *homePageImages;


//用户开店  成功1  失败2
-(NSMutableArray *)userCreateStore:(NSString *)userId withStoreImage:(NSString *)storeImage withStoreName:(NSString *)storeName withStorePayNumber:(NSString *)storePayNum;



//显示侧滑广告图片共用接口
-(NSMutableArray *)showMenuHeaderImage:(NSString *)idType;


//明星店铺广告接口
-(NSMutableArray *)showStarShopHeaderImage;


//美妆精选广告接口
-(NSMutableArray *)showBeautyHeaderImage;

//帮扶店铺广告接口
-(NSMutableArray *)showHelpShopHeaderImage;

//最新上线两张小图片广告
-(NSMutableArray *)showLatestOnlineTwoSmallImage;


//最新上线轮播图
-(NSMutableArray *)showLatestOnlineHeaderImage;


//显示积分兑换商品
-(NSMutableArray *)showNowPointsGoods:(NSString *)usersID;
@property(readonly)NSMutableArray *pointsGoods;


//用户兑换商品
-(BOOL)userGetPointGoods:(NSString *)userID withPointGoodsId:(NSString *)goodsId withNum:(NSString *)num;



@property(readonly)NSMutableArray *addressMsg;
//添加收获地址
-(BOOL)saveorupdataAddressWithUserId:(NSString *)uid withProvince:(NSString *)province withCity:(NSString *)city withCounty:(NSString *)county withAddressInfo:(NSString *)addressInfo withReceive:(NSString *)receive withReceivePhone:(NSString *)receivePhone;



//查询当前用户地址
-(NSMutableArray *)showCurrentUserAddress:(NSString *)userid;



//用户发布信息  成功1?  失败2?
-(BOOL)userReleaseMsg:(NSString *)userId withInfoName:(NSString *)infoName withInfoTypeId:(NSString *)typeId withImageName:(NSString *)imageName withInfoContent:(NSString *)infoContent withInfoMoney:(NSString *)InfoMoney;



//用户发布美食  成功1?  失败2?
-(BOOL)userReleaseFood:(NSString *)userId withInfoName:(NSString *)infoName withInfoTypeId:(NSString *)typeId withImageName:(NSString *)imageName withInfoContent:(NSString *)infoContent withInfoMoney:(NSString *)InfoMoney withImagePaths:(NSString *)imagePaths;



@property(readonly)NSMutableArray *storeMsg;
//显示我的店铺头部信息
-(NSMutableArray *)showMyStoreMsg:(NSString *)uid;


@property(readonly)NSMutableArray *goodsTypeArray;
//添加商品时获取商品类型
-(NSMutableArray *)getGoodsType;



//用户添加商品
-(BOOL)userAddGoods:(NSString *)goodsName withGoodsTypeId:(NSString *)goodsTypeId withStoreId:(NSString *)storeId withGoodsBrand:(NSString *)goodsBrand withGoodsStyle:(NSString *)goodsStyle withGoodsPlace:(NSString *)goodsPlace withGoodsPrice:(NSString *)goodsPrice withGoodsDiscount:(NSString *)goodsDiscount withGoodsContent:(NSString *)goodsContent withGoodsImgPath1:(NSString *)GoodsImgPath1 withGoodsImagePaths:(NSString *)goodsImagePaths withGoodsImageInfoPaths:(NSString *)imageInfoPaths;



@property(readonly)NSMutableArray *saleGoods;
//显示上架商品
-(NSMutableArray *)inTheSaleGoods:(NSString *)userId;

//显示下架商品
-(NSMutableArray *)outTheSaleGoods:(NSString *)userId;



@property(readonly)NSMutableArray *abboutMingHaoArray;
//关于明昊
-(NSMutableArray *)abboutMingHao;



@property(readonly)NSMutableArray *messageDesc;
//显示信息详情
-(NSMutableArray *)showMsgDesc:(NSString *)msgId;



@property(readonly)NSMutableArray *foodsDesc;
//显示美食详情
-(NSMutableArray *)showFoodsDesc:(NSString *)foodsId;



@end
