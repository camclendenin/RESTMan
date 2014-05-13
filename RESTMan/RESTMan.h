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
    e.g. GET /objects
 
 @param type         - Type or class of the object that you want to fetch.
 @param params       - Optional dictionary of params.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)getObjectsOfType:(RESOURCE_TYPE)type
              parameters:(NSDictionary *)params
                 success:(void(^)(id responseData))successBlock
                 failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Fetches objects (belonging to a root object) via a `GET` request.
 e.g. GET /rootObjects/:id/nestedObjects
 
 @param nestedType   - Type or class of the object that you want to fetch.
 @param rootType     - Type or class that the nestedType belongs to.
 @param rootID       - String id of the root object.
 @param params       - Optional dictionary of params.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)getNestedObjectsOfType:(RESOURCE_TYPE)nestedType
            onRootObjectOfType:(RESOURCE_TYPE)rootType
                        withID:(NSString *)rootID
                    parameters:(NSDictionary *)params
                       success:(void(^)(id responseData))successBlock
                       failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Fetches an individual object via a `GET` request.
    e.g. GET /objects/:id
 
 @param type         - Type or class of the object that you want to fetch.
 @param objectID     - String id of the object.
 @param params       - Optional dictionary of params.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)getObjectOfType:(RESOURCE_TYPE)type
                 withID:(NSString *)objectID
             parameters:(NSDictionary *)params
                success:(void(^)(id responseData))successBlock
                failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Fetches an individual object (belonging to a root object) via a `GET` request.
 e.g. GET /rootObjects/:id/nestedObjects/:id
 
 @param nestedType   - Type or class of the object that you want to fetch.
 @param nestedID     - String id of the nested object.
 @param rootType     - Type or class that the @type object belongs to.
 @param rootID       - String id for the root object. Optional if there is no root object.
 @param params       - Optional dictionary of params.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)getNestedObjectOfType:(RESOURCE_TYPE)nestedType
                       withID:(NSString *)nestedID
           onRootObjectOfType:(RESOURCE_TYPE)rootType
                       withID:(NSString *)rootID
                   parameters:(NSDictionary *)params
                      success:(void(^)(id responseData))successBlock
                      failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Updates an object via a `PUT` request.
 e.g. PUT /objects/:id
 
 @param type         - Type or class of the object that you are updating.
 @param objectdID    - String id of the object to be updated.
 @param params       - Dictionary of params to be used to update the object.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)updateObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
                parameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock;


/**
 Updates an object (belonging to a root object) via a `PUT` request.
 e.g. PUT /rootObjects/:id/nestedObects/:id
 
 @param nestedType   - Type or class of the object that you are updating.
 @param nestedID     - String id of the object to be updated.
 @param rootType     - Type or class that the @type object belongs to.
 @param rootID       - String id for the root object.
 @param params       - Dictionary of params to be used to update the object.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)updateNestedObjectOfType:(RESOURCE_TYPE)nestedType
                          withID:(NSString *)nestedID
              onRootObjectOfType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id responseData))successBlock
                         failure:(void (^)(NSString *errorMessage))failureBlock;


/**
 Creates an object via a `POST` request.
 e.g. POST /objects
 
 @param type         - Type or class of the object that you are creating.
 @param params       - A dictionary representing the keys and values that will be used to instantiate the object on the backend.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)createObjectOfType:(RESOURCE_TYPE)type
                parameters:(NSDictionary *)params
                   success:(void(^)(id responseData))successBlock
                   failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Creates an object (belonging to a root object) via a `POST` request.
    e.g. POST /rootObjects/:rootID/nestedObjects
 
 @param nestedType   - Type or class of the object that you are creating.
 @param rootType     - Type or class that the @type object belongs to.
 @param rootID       - String id for the root object.
 @param params       - Dictionary representing the keys and values that will be used to instantiate the object on the backend.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)createNestedObjectOfType:(RESOURCE_TYPE)nestedType
              onRootObjectOfType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void(^)(id responseData))successBlock
                         failure:(void(^)(NSString *errorMessage))failureBlock;


/**
 Destroy an object via a `DELETE` request.
 e.g. DELETE /objects/:id
 
 @param type         - Type or class of the object that you want to destroy.
 @param objectID     - String id of the object to be destroyed.
 @param params       - Optional dictionary of params.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)deleteObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
                parameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock;


/**
 Destroy an object (belonging to a root object) via a `DELETE` request.
    e.g. DELETE /rootObjects/:id/nestedObjects/:id
 
 @param nestedType   - Type or class of the object that you want to destroy.
 @param nestedID     - String id of the nested object to be destroyed.
 @param rootType     - Type or class that the @type object belongs to.
 @param rootID       - String id for the root object. Optional if there is no root object.
 @param params       - An optional dictionary of params.
 @param successBlock - Block object to be executed if the request completes successfully.
 @param failureBlock - Block object to be executed if the request fails.
 */
+ (void)deleteNestedObjectOfType:(RESOURCE_TYPE)nestedType
                          withID:(NSString *)nestedID
                onRootObjectType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id responseData))successBlock
                         failure:(void (^)(NSString *errorMessage))failureBlock;

@end
