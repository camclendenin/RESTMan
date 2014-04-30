rest-machine
============

A lightweight iOS framework for communicating with RESTful web services.

### Why?

There can be a lot of stupid boiler-plate code that needs to be written when integrating web services to a mobile app. RestMachine lets you add networking capabilities to a project in about 1 minute — all without writing any code.

## Getting Started

### Installation

Copy the RestMachine folder into your Xcode project (make sure the "Copy items..." box is selected).

### Set Up

Open RestMachine.plist within your project.
For "Base URL", set the value as the base url of your applications web service.

  ![Example plist](https://dl.dropbox.com/s/hem7iggve7688gs/rest-machine-screen1.png)

For the "Resources" key, add a new row for each resource used in your web service. Resources should be defined in the singular form.

  ![Example plist](https://dl.dropbox.com/s/cl2yy3ofopcqw1n/rest-machine-screen2.png)

If your web service uses the plural form of a resource, use a *#* followed by the plural form of the word (e.g. story#stories)

In your terminal, navigate to the RestMachine directory within your project.

    cd ../YourProject/RestMachine

Run the rest-machine shell script. This will generate all of the necessary code based on your input from the plist. 

    sh rest-machine.sh

Note: If you make changes to the RestMachine.plist after running this script, you will need to run it again.

#### Authentication

RestMachine lets you add your applications auth logic via the RestMachineAuthentication.h file. 
To do this you will need to modify the implementation of the *authenticatedPath* method.

### Usage

Import RestMachine wherever you need to make API calls.

    #import "RestMachine.h"

Use the public methods in *RestMachine.h* to easily get what you need from your web service.

    + (void)getObjectsOfType:(RESOURCE_TYPE)type
          withParameters:(NSDictionary *)params
                 success:(void(^)(id responseData))successBlock
                 failure:(void(^)(NSString *errorMessage))failureBlock;

Check out *RestMachine.h* too see all of the methods available to you and to see more documentation.

## Requirements

[AFNetworking 2.0](https://github.com/AFNetworking/AFNetworking)
