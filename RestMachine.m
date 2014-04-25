//
//  RestMachine.m
//
//  Created by Cameron Clendenin on 2/12/14.
//  Copyright (c) 2014 Cameron Clendenin. All rights reserved.
//

#import "RestMachine.h"

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#warning Update the BASE_UR with your URL
NSString *const BASE_URL = @"https://www.example.com";

/**
 URI path componants
 */

#warning Add path componants used by your api here.
/**
 static NSString *const kPathCompononantAuthors = @"authors";
 static NSString *const kPathCompononantBooks = @"books";
 static NSString *const kPathCompononantReviews = @"reviews";
 */

@interface RestMachine ()

@end


@implementation RestMachine

+ (RestMachine *)sharedInstance {
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

#pragma mark - Authentication


- (NSString *)authenticatedPathWithPath:(NSString *)path {

#warning Your actual authentication should occur here. This is just an example that you can use to get up and running quickly.
    
    return [NSString stringWithFormat:@"%@?%@=%@", path, @"access_token", @"SOME_TOKEN_HERE"];
}



#pragma mark - Path helpers


- (NSString *)stringForObjectType:(RESTFUL_OBJECT_TYPE)type {
    
#warning Update with your applications componants.

    switch (type) {
        /**
        case AUTHOR:
            return kPathCompononantAuthors;
            break;
        case BOOK:
            return kPathCompononantBooks;
            break;
        case REVIEW:
            return kPathCompononantReviews;
            break;
         */
        default:
            return @"";
            break;
    }
}

- (NSString *)singularFormOfObject:(RESTFUL_OBJECT_TYPE)type {

#warning Update with your applications componants.

    switch (type) {
        /**
        case AUTHOR:
            return @"author";
            break;
        case BOOK:
            return @"book";
            break;
        case REVIEW:
            return @"review";
            break;
         */
        default:
            return @"";
            break;
    }
}

- (NSString *)subPathForObjectType:(RESTFUL_OBJECT_TYPE)type objectID:(NSString *)objectID {
    NSString *root = [self stringForObjectType:type];
    if (!objectID) {
        DLog(@"missing root object id for %@", root);
        return @"";
    } else {
        return [root stringByAppendingPathComponent:objectID];
    }
}



#pragma mark - REST Calls


- (void)getObjectsOfType:(RESTFUL_OBJECT_TYPE)type
          withParameters:(NSDictionary *)params
              successful:(void (^)(id responseData))successBlock
                  failed:(void (^)(NSString *errorMessage))failureBlock {
    
    NSString *subPath = [self stringForObjectType:type];
    NSString *path = [NSString stringWithFormat:@"%@/%@", BASE_URL, subPath];
    
    DLog(@"[ GET ] %@", [self authenticatedPathWithPath:path]);
    
    [self.AFRequestManager GET:[self authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)getObjectOfType:(RESTFUL_OBJECT_TYPE)type
                 withID:(NSString *)objectID
         withParameters:(NSDictionary *)params
                success:(void (^)(id responseData))successBlock
                failure:(void (^)(NSString *errorMessage))failureBlock {
    
    NSString *subPath = [[self stringForObjectType:type] stringByAppendingPathComponent:objectID];
    NSString *path = [BASE_URL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ GET ] %@", [self authenticatedPathWithPath:path]);
    
    [self.AFRequestManager GET:[self authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)updateObjectOfType:(RESTFUL_OBJECT_TYPE)type
                    withID:(NSString *)objectID
            rootObjectType:(RESTFUL_OBJECT_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
            withParameters:(NSDictionary *)params
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock {
    
    NSString *subPath = [[self subPathForObjectType:rootObjectType objectID:rootObjectID] stringByAppendingPathComponent:[self subPathForObjectType:type objectID:objectID]];
    NSString *path = [NSString stringWithFormat:@"%@/%@", BASE_URL, subPath];
    
    DLog(@"[ PUT ] %@ [params] %@", path, params);
    
    [self.AFRequestManager PUT:[self authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)createObjectOfType:(RESTFUL_OBJECT_TYPE)type
            withParameters:(NSDictionary *)params
            rootObjectType:(RESTFUL_OBJECT_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
                   success:(void (^)(id responseData))successBlock
                   failure:(void (^)(NSString *errorMessage))failureBlock {
    
    
    NSString *subPath = [[self subPathForObjectType:rootObjectType objectID:rootObjectID] stringByAppendingPathComponent:[self stringForObjectType:type]];
    NSString *path = [BASE_URL stringByAppendingPathComponent:subPath];
    
    DLog(@"[ POST ] %@ [params] %@", path, params);
    
    [self.AFRequestManager POST:[self authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}

- (void)deleteObjectOfType:(RESTFUL_OBJECT_TYPE)type
                 withID:(NSString *)objectID
            rootObjectType:(RESTFUL_OBJECT_TYPE)rootObjectType
              rootObjectID:(NSString *)rootObjectID
         withParameters:(NSDictionary *)params
                success:(void (^)(id responseData))successBlock
                failure:(void (^)(NSString *errorMessage))failureBlock {
    
    NSString *subPath = [[self subPathForObjectType:rootObjectType objectID:rootObjectID] stringByAppendingPathComponent:[self subPathForObjectType:type objectID:objectID]];
    NSString *path = [BASE_URL stringByAppendingPathComponent:subPath];

    DLog(@"[ GET ] %@", [self authenticatedPathWithPath:path]);
    
    [self.AFRequestManager DELETE:[self authenticatedPathWithPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error.localizedDescription);
    }];
}


@end
