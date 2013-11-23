//
//  APIManager.h
//  MovieTicket
//
//  Created by Phuong. Nguyen Minh on 12/7/12.
//  Copyright (c) 2012 Phuong. Nguyen Minh. All rights reserved.
//

#import "APIDefines.h"

@protocol RKManagerDelegate <NSObject>

@optional
-(void)processResultResponseDictionaryMapping:(DictionaryMapping *)dictionary requestId:(int)request_id;
-(void)processResultResponseArrayMapping:(ArrayMapping *)array requestId:(int)request_id;
//Return array of object declare in source
-(void)processResultResponseArray:(NSArray *)array requestId:(int)request_id;
@end

@interface APIManager : NSObject<RKManagerDelegate>
{
    APIManager *instance;
}
#pragma mark using for communicate with server
@property (nonatomic, assign) BOOL wasSendLogin;
@property (nonatomic, retain) NSHTTPCookie *myCookies;
@property (nonatomic, retain) NSString *accessTokenKey;

+(APIManager*)sharedAPIManager;
-(void)RK_RequestApiGetListCategoryContext:(id)context_id;
-(void)RK_RequestApiGetListAppByCategory:(int)cat_id withContext:(id)context_id;
-(void)RK_RequestApiGetListAppBySearchKey:(NSString *)searchKey withContext:(id)context_id;
-(void)RK_RequestApiGetAppDetail:(NSString *)appName appID:(NSString *)appID withContext:(id)context_id;
@end
