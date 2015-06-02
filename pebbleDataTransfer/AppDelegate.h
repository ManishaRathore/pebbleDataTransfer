//
//  AppDelegate.h
//  pebbleDataTransfer
//
//  Created by Sarvjeet on 22/05/15.
//  Copyright (c) 2015 emx. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <PebbleKit/PebbleKit.h>

@class ViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate, PBPebbleCentralDelegate, PBWatchDelegate, PBDataLoggingServiceDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) PBWatch *connectedWatch;


@end
