//
//  GlobalDataManager.h
//  JXT
//
//  Created by 伍 兵 on 14-7-29.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataManager : NSObject

+(id)sharedDataManager;
@property(nonatomic,retain) NSOperationQueue* globalTaskQueue;
//全局用户属性
@property(nonatomic,retain) NSString* userID;
@property(nonatomic,retain) NSString* userPassword;
@property(nonatomic,retain) NSString* userMobile;
@property(nonatomic,retain) NSString* userRealName;
@property(nonatomic,retain) NSString* userNickName;
@property(nonatomic,retain) NSString* userSchoolName;
@property(nonatomic,retain) NSString* userSchoolId;
@property(nonatomic,retain) NSString* userPhaseId;
@property(nonatomic,retain) NSString* userPic;
@property(nonatomic,retain) NSString* userBigPic;
//课程全局dict
@property(nonatomic,retain) NSMutableDictionary * subjectsDict;

-(NSArray*)subjectsArray;
-(NSString*)subjectIdForSubject:(NSString*)aSubject;
@end
