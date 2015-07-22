//
//  Utility.m
//  RSSReader
//
//  Created by Andy Tung on 13-5-15.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"
#import "NSError+Extentions.h"

@implementation Utility

+ (void)sendAsynchronousRequest:(NSURLRequest *)request queue:(NSOperationQueue *)queue completionHandler:(void (^)(NSURLResponse *, NSData *, NSError *))handler{
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * response, NSData *data, NSError *innerError) {
        //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        [NSThread sleepForTimeInterval:0.5f];
        
        NSError *error=nil;
         
        if (innerError!=nil) {
            NSString *errmsg=[NSString stringWithFormat:@"请求数据失败\nURL:%@",[request URL]];
            error=[NSError errorWithDomain:REQUEST_ERROR_DOMAIN code:kRequestFailed errmsg:errmsg innerError:innerError];
            NSLog(@"%@",error);
        }
        
        if ([NSThread isMainThread]) {
            handler(response,data,error);
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                handler(response,data,error);
            });
        }
    }];
}

@end
