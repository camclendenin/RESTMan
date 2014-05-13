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
              parameters:(NSDictionary *)params
                 success:(void(^)(id))successBlock
                 failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] getObjectsOfType:type
                                withParameters:params
                                    successful:successBlock
                                        failed:failureBlock];
}

+ (void)getNestedObjectsOfType:(RESOURCE_TYPE)nestedType
                rootObjectType:(RESOURCE_TYPE)rootType
                  rootObjectID:(NSString *)rootObjectID
                    parameters:(NSDictionary *)params
                       success:(void(^)(id))successBlock
                       failure:(void(^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] getNestedObjectsOfType:nestedType
                                  onRootObjectOfType:rootType
                                              withID:rootObjectID
                                          parameters:params
                                             success:successBlock
                                             failure:failureBlock];
}

+ (void)getObjectOfType:(RESOURCE_TYPE)type
                 andID:(NSString *)objectID
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

+ (void)getNestedObjectOfType:(RESOURCE_TYPE)nestedType
                       withID:(NSString *)nestedID
           onRootObjectOfType:(RESOURCE_TYPE)rootType
                       withID:(NSString *)rootID
                   parameters:(NSDictionary *)params
                      success:(void (^)(id))successBlock
                      failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] getNestedObjectOfType:nestedType
                                             withID:nestedID
                                 onRootObjectOfType:rootType
                                             withID:rootID
                                         parameters:params
                                            success:successBlock
                                            failure:failureBlock];
}

+ (void)updateObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
                parameters:(NSDictionary *)params
                   success:(void (^)(id))successBlock
                   failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] updateObjectOfType:type
                                          withID:objectID
                                      parameters:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)updateNestedObjectOfType:(RESOURCE_TYPE)nestedType
                          withID:(NSString *)nestedID
              onRootObjectOfType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id))successBlock
                         failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] updateNestedObjectOfType:nestedType
                                                withID:nestedID
                                    onRootObjectOfType:rootType
                                                withID:rootID
                                            parameters:params
                                               success:successBlock
                                               failure:failureBlock];
}

+ (void)createObjectOfType:(RESOURCE_TYPE)type
                parameters:(NSDictionary *)params
                   success:(void (^)(id))successBlock
                   failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] createObjectOfType:type
                                      parameters:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)createNestedObjectOfType:(RESOURCE_TYPE)nestedType
              onRootObjectOfType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id))successBlock
                         failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] createNestedObjectOfType:nestedType
                                    onRootObjectOfType:rootType
                                                withID:rootID
                                            parameters:params
                                               success:successBlock
                                               failure:failureBlock];
}

+ (void)deleteObjectOfType:(RESOURCE_TYPE)type
                    withID:(NSString *)objectID
                parameters:(NSDictionary *)params
                   success:(void (^)(id))successBlock
                   failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] deleteObjectOfType:type
                                          withID:objectID
                                      parameters:params
                                         success:successBlock
                                         failure:failureBlock];
}

+ (void)deleteNestedObjectOfType:(RESOURCE_TYPE)nestedType
                          withID:(NSString *)nestedID
                onRootObjectType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id))successBlock
                         failure:(void (^)(NSString *))failureBlock
{
    [[RESTMan sharedInstance] deleteNestedObjectOfType:nestedType
                                                withID:nestedID
                                      onRootObjectType:rootType
                                                withID:rootID
                                            parameters:params
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

- (void)getNestedObjectsOfType:(RESOURCE_TYPE)nestedType
            onRootObjectOfType:(RESOURCE_TYPE)rootType
                        withID:(NSString *)rootID
                    parameters:(NSDictionary *)params
                       success:(void(^)(id responseData))successBlock
                       failure:(void(^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [[self subPathForResource:rootType objectID:rootID] stringByAppendingPathComponent:[self stringForResource:nestedType]];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ GET ] %@ [params] %@", [RESTManAuthenticator authenticatedPathWithPath:path], params);
    
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

- (void)getNestedObjectOfType:(RESOURCE_TYPE)nestedType
                       withID:(NSString *)nestedID
           onRootObjectOfType:(RESOURCE_TYPE)rootType
                       withID:(NSString *)rootID
                   parameters:(NSDictionary *)params
                      success:(void(^)(id responseData))successBlock
                      failure:(void(^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [[self subPathForResource:rootType objectID:rootID] stringByAppendingPathComponent:[self subPathForResource:nestedType objectID:nestedID]];
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
                parameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [self subPathForResource:type objectID:objectID];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ PUT ] %@ [params] %@", [RESTManAuthenticator authenticatedPathWithPath:path], params);
    
    [self.AFRequestManager PUT:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
    
}

- (void)updateNestedObjectOfType:(RESOURCE_TYPE)nestedType
                          withID:(NSString *)nestedID
              onRootObjectOfType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id responseData))successBlock
                         failure:(void (^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [[self subPathForResource:rootType objectID:rootID] stringByAppendingPathComponent:[self subPathForResource:nestedType objectID:nestedID]];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ PUT ] %@ [params] %@", [RESTManAuthenticator authenticatedPathWithPath:path], params);
    
    [self.AFRequestManager PUT:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)createObjectOfType:(RESOURCE_TYPE)type
                parameters:(NSDictionary *)params
                   success:(void(^)(id responseData))successBlock
                   failure:(void(^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [self stringForResource:type];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ POST ] %@ [params] %@", [RESTManAuthenticator authenticatedPathWithPath:path], params);
    
    [self.AFRequestManager POST:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)createNestedObjectOfType:(RESOURCE_TYPE)nestedType
              onRootObjectOfType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void(^)(id responseData))successBlock
                         failure:(void(^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [[self subPathForResource:rootType objectID:rootID] stringByAppendingPathComponent:[self stringForResource:nestedType]];
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
                parameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [self subPathForResource:type objectID:objectID];
    NSString *path = [RMBaseURL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ DELETE ] %@", [RESTManAuthenticator authenticatedPathWithPath:path]);
    
    [self.AFRequestManager DELETE:[RESTManAuthenticator authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
    
}

- (void)deleteNestedObjectOfType:(RESOURCE_TYPE)nestedType
                          withID:(NSString *)nestedID
                onRootObjectType:(RESOURCE_TYPE)rootType
                          withID:(NSString *)rootID
                      parameters:(NSDictionary *)params
                         success:(void (^)(id responseData))successBlock
                         failure:(void (^)(NSString *errorMessage))failureBlock
{
    NSString *subPath = [[self subPathForResource:rootType objectID:rootID] stringByAppendingPathComponent:[self subPathForResource:nestedType objectID:nestedID]];
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
