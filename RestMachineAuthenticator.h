//
//  RestMachineAuthenticator.h
//
//  Created by Cameron Clendenin on 4/29/14.
//  Copyright (c) 2014 Cameron Clendenin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestMachineAuthenticator : NSObject

/**
 Returns a url string path with your applictions auth logic.
 
 @param path - The HTTP request path to be authenticated.
 */
+ (NSString *)authenticatedPathWithPath:(NSString *)path;

@end
