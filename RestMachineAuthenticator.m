//
//  RestMachineAuthenticator.m
//
//  Created by Cameron Clendenin on 4/29/14.
//  Copyright (c) 2014 Cameron Clendenin. All rights reserved.

#import "RestMachineAuthenticator.h"
#import "AccountManager.h"

@implementation RestMachineAuthenticator

+ (NSString *)authenticatedPathWithPath:(NSString *)path {

#warning Override with your applications authentication logic, ie token
    return path;
}

@end
