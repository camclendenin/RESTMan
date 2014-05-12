RESTMan
============

RESTMan lets you easily interact with RESTful (GET, POST, PUT, DELETE) web APIs by allowing you to work with **objects instead of URLs**. No messy in-line URLs to maintain.

    [RESTMan createObjectOfType:USER 
                rootObjectType:NONE 
                  rootObjectID:nil 
                withParameters:@{@"email" : @"user@example.com", @"password" : @"some_password"}  
                       success:^(id responseData) {
                          // successful request.
                     } failure:^(NSString *errorMessage) {
                          // handle error here.
                     }];

Define all of your endpoints in a single plist file and let RESTMan do the rest. RESTman uses ARC and is built on top of `AFNetworking`, but adds a layer of simplicity that lets you write more maintainable code.

## Getting Started

### Installation

Copy the RESTMan folder into your Xcode project (make sure the "Copy items..." box is selected).

### Set Up

Open RESTMan.plist within your project.

#### Base URL
For `Base URL`, set the value as the base url of your applications web service.

  ![Example plist](https://dl.dropbox.com/s/hem7iggve7688gs/rest-machine-screen1.png)

#### Endpoints

Define all of your endpoints via `Resources`.  Add a new row for each resource used in your web service. Resources should be defined in the singular form.

  ![Example plist](https://dl.dropbox.com/s/cl2yy3ofopcqw1n/rest-machine-screen2.png)

If your web service uses the plural form of a resource, use a *#* followed by the plural form. For example:

    story#stories

Or...

    you#can/also/use/nested/paths

#### Modify build phases

Go to the `Build Phases` tab for your target and add a `New Run Script Build Phase`

![Add Script](https://dl.dropbox.com/s/9cpy4nuhwihn67m/rest-machine-add-build-script.png)
    
Add the following text to the the script area...

    cd "${SRCROOT}/${PROJECT_NAME}/RESTMan"
    /bin/sh "restman.sh"

It should now look like this:

![Edit Script](https://dl.dropbox.com/s/j59njlthu4z37a5/rest-machine-edit-build-script.png)


**You're done!**

This script will automatically pull in your settings from `RESTMan.plist` and generate your endpoints each time your project builds. Hit `CMD-B` and then checkout `RESTManConfig.h` to see your generated config file.

#### Authentication

RESTMan lets you add your applications custom authentication logic via the RESTManAuthentication.h file. 
To do this you will need to modify the implementation of the *authenticatedPath* method.

### Usage

Import RESTMan wherever you need to make API calls.

    #import "RESTMan.h"

Use the public methods in *RESTMan.h* to easily get what you need from your web service.

    + (void)getObjectsOfType:(RESOURCE_TYPE)type
          withParameters:(NSDictionary *)params
                 success:(void(^)(id responseData))successBlock
                 failure:(void(^)(NSString *errorMessage))failureBlock;

Check out *RESTMan.h* too see all of the methods available to you and to see more documentation.

## Requirements

[AFNetworking 2.0](https://github.com/AFNetworking/AFNetworking)


