//
//  GlobalDataManager.m
//  JXT
//
//  Created by 伍 兵 on 14-7-29.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "GlobalDataManager.h"
static GlobalDataManager* m;
@implementation GlobalDataManager
@synthesize globalTaskQueue;
@synthesize userID,userPassword,userMobile,userRealName,userNickName,userPic,userBigPic,userSchoolName;
@synthesize subjectsDict;
+(id)sharedDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m= [[GlobalDataManager alloc] init];
    });
    return m;
}
-(id)init
{
    self=[super init];
    if(self)
    {
        globalTaskQueue=[[NSOperationQueue alloc] init];
        subjectsDict=[[NSMutableDictionary alloc] initWithCapacity:0];
        [subjectsDict setObject:@"1" forKey:@"语文"];
        [subjectsDict setObject:@"2" forKey:@"数学"];
        [subjectsDict setObject:@"3" forKey:@"英语"];
        [subjectsDict setObject:@"4" forKey:@"物理"];
        [subjectsDict setObject:@"5" forKey:@"化学"];
        
    }
    return self;
}
-(NSArray*)subjectsArray
{
    return [subjectsDict allKeys];
}
-(NSString*)subjectIdForSubject:(NSString*)aSubject
{
    return [subjectsDict objectForKey:aSubject];
}
@end
