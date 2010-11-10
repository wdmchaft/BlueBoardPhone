//
//  blueBoardPhoneAppDelegate.h
//  blueBoardPhone
//
//  Created by Kristof Dreier on 04.08.10.
//  Copyright 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface blueBoardPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
	
	RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet RootViewController *rootviewController;

@end

