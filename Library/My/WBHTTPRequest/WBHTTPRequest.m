//
//  WBHTTPRequest.m
//  WBHTTPRequest
//
//  Created by 伍 兵 on 14-7-30.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "WBHTTPRequest.h"

@implementation WBHTTPRequest
+(void)sendRequestWithURL:(NSURL*)aRUL parameterDict:(NSDictionary*)pDict type:(WBHTTPRequestType)type queue:(NSOperationQueue*)aQueue completeHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError))handler
{
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:aRUL];
    NSLog(@"URL:%@",aRUL);
    if(type == kWBHTTPRequestPOSTType)
    {
        //拼串
        NSString* dataString=[self parseParameterDict:pDict];
        //请求
        [request setHTTPMethod:@"POST"];//请求类型
        [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:aQueue completionHandler:handler];
}
+(NSString*)parseParameterDict:(NSDictionary*)aDict
{
    if(aDict==nil||[aDict allKeys].count==0)
    {
        NSLog(@"parameterDict empty!");
        return nil;
    }
    NSMutableString* string=[[NSMutableString alloc]init];
    for(NSString* parameter in [aDict allKeys])
    {
        NSString* value= [aDict objectForKey:parameter];
        [string appendFormat:@"%@=%@&",parameter,value];
    }
    NSString* needString=[string substringToIndex:string.length-1];
    [string release];
    NSLog(@"dataString:%@",needString);
    return needString;
}
@end
