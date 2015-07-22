//
//  JsonParser.m
//  UIT1201
//
//  Created by 123 on 14-12-4.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import "JsonParser.h"


@implementation JsonParser


//解析Json字符串

+(NSMutableArray *)parseJsonStrToArray:(NSMutableString *)jsonString{
    
    //NSDictionary *dt=[jsonString JSONValue];//解析
    
    NSMutableArray *ma=[jsonString JSONValue];//解析
    
    return ma;
 }

+(NSMutableDictionary *)parseJsonStrToDict:(NSMutableString *)jsonString{
    
    NSMutableDictionary *dt=[jsonString JSONValue];//解析
    return dt;
    
}

//生成Json字符串
+(NSMutableString *)generateJsonString:(NSMutableDictionary *)sContent{
    NSMutableString *jsonString=[[NSMutableString alloc]initWithString:[sContent JSONRepresentation]];
    return jsonString;
 }


@end
