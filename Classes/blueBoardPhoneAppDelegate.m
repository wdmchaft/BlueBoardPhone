//
//  blueBoardPhoneAppDelegate.m
//  blueBoardPhone
//
//  Created by Kristof Dreier on 04.08.10.
//  Copyright 2010. All rights reserved.
//

#import "blueBoardPhoneAppDelegate.h"
#import "RootViewController.h"

@implementation blueBoardPhoneAppDelegate

@synthesize window, navigationController, rootviewController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

