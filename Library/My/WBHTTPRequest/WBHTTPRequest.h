//
//  WBHTTPRequest.h
//  WBHTTPRequest
//
//  Created by 伍 兵 on 14-7-30.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kWBHTTPRequestGETType,
    kWBHTTPRequestPOSTType
    
}WBHTTPRequestType;


@interface WBHTTPRequest : NSObject
+(void)sendRequestWithURL:(NSURL*)aRUL parameterDict:(NSDictionary*)pDict type:(WBHTTPRequestType)type queue:(NSOperationQueue*)aQueue completeHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError))handler;
@end
