//
//  RESTMan.h
//
//  Created by Cameron Clendenin on 2/12/14.
//  Copyright (c) 2014 Cameron Clendenin. All rights reserved.
//
//  RestMachine is built on top of the wonderful AFNetworking framework and
//  makes it crazy simple to work with well designed RESTful web services.

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "RESTManConfig.h"

@interface RESTMan : NSObject

@property (nonatomic, strong, readonly) AFHTTPRequestOperationManager *AFRequestManager;

/** 
 Returns a singleton instance
 */
+ (RESTMan *)sharedInstance;


/**
 Fetches objects via a `GET` request. 
    e.g. GET /things
 
 @param type         - The type or class of the object that you want to fetch.
 @param params       - An optional dictionary of params.
 @param successBlock - A block object to be executed if the request completes successfully.
 @param failureBlock - A block object to be executed if the request fails.
 */
+ (void)getObjectsOfType:(RESOURCE_TYPE)type
          withParameters:(NSDictionary *)params
                 success:(void(^)(id responseData))successBlock
                 failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Fetches an individual object via a `GET` request.
    e.g. GET /things/:id
 
 @param type         - The type or class of the object that you want to fetch.
 @param objectID     - The id of the object.
 @param params       - An optional dictionary of params.
 @param successBlock - A block object to be executed if the request completes successfully.
 @param failureBlock - A block object to be executed if the request fails.
 */
+ (void)getObjectOfType:(RESOURCE_TYPE)type
                 withID:(NSString *)objectID
         withParameters:(NSDictionary *)params
                success:(void(^)(id responseData))successBlock
                failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Updates an object via a `PUT` request.
 e.g. PUT /things/:id
 
 @param type         - The type or class of the object that you are updating.
 @param objectID     - The id of the object to be updated.
 @param rootObjType  - The type or class that the @type object belongs to.
 ie a user has notes so for /users/:id/notes type = note && root = user.
 For a single-resource path like /users set rootObjectType = NONE.
 
 @param rootObjectID - String id for the root object. Optional if there is no root object.
 @param params       - A dictionary of params to be used to update the object.
 @param successBlock - A block object to be executed if the request completes successfully.
 @param failureBlock - A block object to be executed if the request fails.
 */
+ (void)updateObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock;


/**
 Creates an object via a `POST` request.
    e.g. POST /things
 
 @param type         - The type or class of the object that you are creating.
 @param rootObjType  - The type or class that the @type object belongs to.
                            ie a user has notes so for /users/:id/notes type = note && root = user.
                            For a single-resource path like /users set rootObjectType = NONE.
 
 @param rootObjectID - String id for the root object. Optional if there is no root object.
 @param params       - A dictionary representing the keys and values that will be used to instantiate the object on the backend.
 @param successBlock - A block object to be executed if the request completes successfully.
 @param failureBlock - A block object to be executed if the request fails.
 */
+ (void)createObjectOfType:(RESOURCE_TYPE)type
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void(^)(id responseData))successBlock
                   failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Destroy an object via a `DELETE` request.
    e.g. DELETE /things/:id
 
 @param type         - The type or class of the object that you want to destroy.
 @param objectID     - The id of the object to be destroyed.
 @param rootObjType  - The type or class that the @type object belongs to.
                            ie a user has notes so for /users/:id/notes type = note && root = user.
                            For a single-resource path like /users set rootObjectType = NONE.
 
 @param rootObjectID - String id for the root object. Optional if there is no root object.
 @param params       - An optional dictionary of params.
 @param successBlock - A block object to be executed if the request completes successfully.
 @param failureBlock - A block object to be executed if the request fails.
 */
+ (void)deleteObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock;

@end
