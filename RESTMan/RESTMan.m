//
//  RESTMan.m
//
//  Created by Cameron Clendenin on 2/12/14.
//  Copyright (c) 2014 Cameron Clendenin. All rights reserved.
//

#import "RESTMan.h"
#import "RESTManAuthenticator.h"

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

@interface RESTMan ()

@end


@implementation RESTMan

+ (RESTMan *)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _AFRequestManager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}


#pragma mark - Public Methods

+ (void)getObjectsOfType:(RESOURCE_TYPE)type
          withParameters:(NSDictionary *)params
                 success:(void(^)(id))successBlock
                 failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] getObjectsOfType:type
                                    withParameters:params
                                        successful:successBlock
                                            failed:failureBlock];
}

+ (void)getObjectOfType:(RESOURCE_TYPE)type
                 withID:(NSString *)objectID
         withParameters:(NSDictionary *)params
                success:(void(^)(id))successBlock
                failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] getObjectOfType:type
                                           withID:objectID
                                   withParameters:params
                                          success:successBlock
                                          failure:failureBlock];
}

+ (void)updateObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void(^)(id))successBlock
                   failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] updateObjectOfType:type
                                              withID:objectID
                                      rootObjectType:rootObjectType
                                        rootObjectID:rootObjectID
                                      withParameters:params
                                             success:successBlock
                                             failure:failureBlock];
}

+ (void)createObjectOfType:(RESOURCE_TYPE)type
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void(^)(id))successBlock
                   failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] createObjectOfType:type
                                      withParameters:params
                                      rootObjectType:rootObjectType
                                        rootObjectID:rootObjectID
                                             success:successBlock
                                             failure:failureBlock];
}

+ (void)deleteObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void(^)(id))successBlock
                   failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] deleteObjectOfType:type
                                              withID:objectID
                                      rootObjectType:rootObjectType
                                        rootObjectID:rootObjectID
                                      withParameters:params
                                             success:successBlock
                                             failure:failureBlock];
}

#pragma mark - Private methods


- (void)getObjectsOfType:(RESOURCE_TYPE)type
          withParameters:(NSDictionary *)params
              successful:(void (^)(id responseData))successBlock
                  failed:(void (^)(NSString *errorMessage))failureBlock
{
    
    NSString *subPath = [self stringForResource:type];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ GET ] %@", [RESTManAuthenticator authenticatedPathWithPath:path]);
    
    [self.AFRequestManager GET:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)getObjectOfType:(RESOURCE_TYPE)type
                 withID:(NSString *)objectID
         withParameters:(NSDictionary *)params
                success:(void (^)(id responseData))successBlock
                failure:(void (^)(NSString *errorMessage))failureBlock
{
    
    NSString *subPath = [[self stringForResource:type] stringByAppendingPathComponent:objectID];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ GET ] %@", [RESTManAuthenticator authenticatedPathWithPath:path]);
    
    [self.AFRequestManager GET:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)updateObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock
{
    
    NSString *subPath = [[self subPathForResource:rootObjectType objectID:rootObjectID] stringByAppendingPathComponent:[self subPathForResource:type objectID:objectID]];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ PUT ] %@ [params] %@", [RESTManAuthenticator authenticatedPathWithPath:path], params);
    
    [self.AFRequestManager PUT:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)createObjectOfType:(RESOURCE_TYPE)type
            withParameters:(NSDictionary *)params
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock
{
    
    
    NSString *subPath = [[self subPathForResource:rootObjectType objectID:rootObjectID] stringByAppendingPathComponent:[self stringForResource:type]];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ POST ] %@ [params] %@", [RESTManAuthenticator authenticatedPathWithPath:path], params);
    
    [self.AFRequestManager POST:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)deleteObjectOfType:(RESOURCE_TYPE)type
                 withID:(NSString *)objectID
            rootObjectType:(RESOURCE_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
         withParameters:(NSDictionary *)params
                success:(void (^)(id responseData))successBlock
                failure:(void (^)(NSString *errorMessage))failureBlock
{
    
    NSString *subPath = [[self subPathForResource:rootObjectType objectID:rootObjectID] stringByAppendingPathComponent:[self subPathForResource:type objectID:objectID]];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];

    DLog(@"[ DELETE ] %@", [RESTManAuthenticator authenticatedPathWithPath:path]);
    
    [self.AFRequestManager DELETE:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}



#pragma mark - Path Helpers

- (NSString *)stringForResource:(RESOURCE_TYPE)type {
    return (type == NONE) ? @"" : [RM_RESOURCES objectAtIndex:--type];
}

- (NSString *)subPathForResource:(RESOURCE_TYPE)type objectID:(NSString *)objectID {
    NSString *root = [self stringForResource:type];
    if (!objectID) {
        DLog(@"Missing root object id for %@", root);
        return @"";
    } else {
        return [root stringByAppendingPathComponent:objectID];
    }
}



@end
