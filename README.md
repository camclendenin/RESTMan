RESTMan
============

RESTMan lets you easily interact with RESTful (GET, POST, PUT, DELETE) web APIs by allowing you to work with **objects instead of URLs**. No messy in-line URLs to maintain.

```objective-c
[RESTMan getObjectOfType:BOOK withID:@"1234" parameters:nil success:^(id responseData) {
    // do something with the book.
    id book = [responseData objectForKey:@"book"];
} failure:^(NSString *errorMessage) {
    // handle error however you like.
}];
```

Define all of your endpoints in a single plist file and let RESTMan do the rest. RESTman uses ARC and is built on top of `AFNetworking`, but adds a layer of simplicity that lets you write more maintainable code.

## Getting Started

### Installation

Copy the RESTMan folder into your Xcode project (make sure the "Copy items..." box is selected).

#### Modify build phases

Go to the `Build Phases` tab for your target and add a `New Run Script Build Phase`

![Add Script](https://dl.dropbox.com/s/9cpy4nuhwihn67m/rest-machine-add-build-script.png)
    
Add the following text to the the script area...

    cd "${SRCROOT}/${PROJECT_NAME}/RESTMan/RESTMan"
    /bin/sh "restman-generator.sh"

It should now look like this:

![Edit Script](https://dl.dropbox.com/s/ot10lj4fa9qgrov/restman_run_script.png)

### Set Up

Open RESTMan.plist within your project. This file will be used to generate all of the endpoints used in your API.

##### Base URL
For `Base URL`, set the value as the base url of your applications web service.

  ![Example plist](https://dl.dropbox.com/s/hem7iggve7688gs/rest-machine-screen1.png)

##### Resources

Define all of your endpoints via `Resources`.  Add a new row for each resource in your web API that you want to use. Here is an example:

    user#users

The *first* part before the `#` defines the way you want to reference the object throughout your project. The *second* part **after** the `#` should be the corresponding path name used by your API. In the example above, this will allow to refer refer to USER when using RESTMan, meanwhile under-the-hood RESTMan will generate URLs that use the `/users` path.

  ![Example plist](https://dl.dropbox.com/s/cl2yy3ofopcqw1n/rest-machine-screen2.png)

In addition, RESTMan can support different kinds of nested paths. For example, if your APIs path for login is something like `POST /auth/users/login`, where it is just a series of nested resources without IDs, you could do something like this.

    session#auth/users/login
    
This would allow to make the following call using RESTMan...

```objective-c
[RESTMan createObjectOfType:SESSION parameters:loginCredentials success:^(id responseData) {
    // get token from response data, etc...
} failure:^(NSString *errorMessage) {
    // handle invalid credentials, etc...
}];
```
    
For nested paths that combine 2 resources, use the RESTMan class methods that accept *nested* and *root* object types. See the documentation in RESTMan.h for the details, or just jump right in and start using it bc it's awesome.


**You're done!**

This script will automatically pull in your settings from `RESTMan.plist` and generate your endpoints each time your project builds. Hit `CMD-B` and then checkout `RESTManConfig.h` to see your generated config file.

#### Authentication

RESTMan lets you add your applications custom authentication logic via the RESTManAuthentication.h file. 
To do this you will need to modify the implementation of the *authenticatedPath* method.

### Usage

Import RESTMan wherever you need to make API calls.

    #import "RESTMan.h"

Use the public methods in *RESTMan.h* to easily get what you need from your web service.

```objective-c
+ (void)getObjectsOfType:(RESOURCE_TYPE)type
      withParameters:(NSDictionary *)params
             success:(void(^)(id responseData))successBlock
             failure:(void(^)(NSString *errorMessage))failureBlock;
````

Check out [*RESTMan.h*](https://github.com/camclendenin/RESTMan/blob/master/RESTMan/RESTMan.h) too see all of the methods available to you and to see more documentation.

## Requirements

[AFNetworking 2.0](https://github.com/AFNetworking/AFNetworking)


### TODOs

- Cocoapods support
- More robust failure blocks
- Handling different types of authentication


