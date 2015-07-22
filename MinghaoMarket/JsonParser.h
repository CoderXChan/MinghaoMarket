//
//  JsonParser.h
//  UIT1201
//
//  Created by 123 on 14-12-4.
//  Copyright (c) 2014年 123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
@interface JsonParser : NSObject

//解析Json字符串
+(NSMutableArray *)parseJsonStrToArray:(NSMutableString *)jsonString;
+(NSMutableDictionary *)parseJsonStrToDict:(NSMutableString *)jsonString;


//生成Json字符串
+(NSMutableString *)generateJsonString:(NSMutableDictionary *)sContent;
@end
