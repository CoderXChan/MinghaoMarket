//
//  LSNet.m
//  test
//
//  Created by huj on 15-3-13.
//  Copyright (c) 2015年 huj. All rights reserved.
//

#import "LSNet.h"
#import "User.h"
#import "MingHaoApiService.h"
@implementation LSNet


-(id) initWithURL:(NSString *)mURL {
    self = [super init];
    
    URL = mURL;   //请求的URL
    Boundary = @"AaS8HJ";  //分界符
    
    return self;
}

-(BOOL)Post:(NSDictionary *)params withImage:(UIImage *)img{
    //创建URL
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:URL] ];
    // 设置content-type
    NSString * contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",Boundary];
    
    //添加普通字段
    NSArray * keys = [params allKeys];
    NSMutableData *body = [NSMutableData data];
    for (int i=0;i<[keys count];i++) {
        NSString * key = [keys objectAtIndex:i];
        if (![key isEqualToString:@"file"]) {
            
            //添加分界符：--AaS8HJ
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", Boundary]
                              dataUsingEncoding:NSUTF8StringEncoding]];
            
            //声明一个字段：  content-disposition: form-data; name="字段名"
            [body appendData:[[NSString stringWithFormat:
                               @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key]
                              dataUsingEncoding:NSUTF8StringEncoding]];
            
            //字段的值
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }

   
    
    // 加入一个图片
    NSData *imageData = UIImagePNGRepresentation(img);
    if (imageData) {
        
        ////添加分界符：--AaS8HJ
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", Boundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];
        
        //声明一个字段
        //content-disposition: form-data; name="pic"; filename="image.png"
        //Content-Type: image/png
        
        //获取当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
        currentDate=[dateformatter stringFromDate:senddate];

        //当前的userid
        if ([User getCurrentUser]!=NULL) {
            currentUserID=[User getUserID];
        }
        
        _imageName=[NSString stringWithFormat:@"%@_%@_image.png",currentUserID,currentDate];


        NSString *ST=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",_imageName];
        [body appendData:[ST dataUsingEncoding:NSUTF8StringEncoding]];
        

        [body appendData:[@"Content-Type: image/png\r\n\r\n"
                          dataUsingEncoding:NSUTF8StringEncoding]];
        
        //添加图片的二进制内容
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // post请求结尾的分界线，注意，这里是--AaS8HJ--，前后都有小横线
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", Boundary]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    [request setValue:contentType forHTTPHeaderField:@"content-Type"];

    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // request
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    return YES;
}


#pragma mark - NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"请求成功");
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
}














@end
