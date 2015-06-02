//
//  AppDelegate.m
//  pebbleDataTransfer
//
//  Created by Sarvjeet on 22/05/15.
//  Copyright (c) 2015 emx. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
   
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(setTargetWatch:)
     name:@"aaaf"
     object:nil];
    
    [self setTargetWatch:[[PBPebbleCentral defaultCentral] lastConnectedWatch]];
    
       
       return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    NSLog(@"forrrrrckend............................");

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    
    NSLog(@"actiiiiiiiivvvvveeee............................");

    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)pebbleCentral:(PBPebbleCentral*)central watchDidConnect:(PBWatch*)watch isNew:(BOOL)isNew

{
    NSLog(@"Pebble connected: %@", [watch name]);
    self.connectedWatch = watch;
}

- (void)pebbleCentral:(PBPebbleCentral*)central watchDidDisconnect:(PBWatch*)watch {
    NSLog(@"Pebble disconnected: %@", [watch name]);
    
    if (self.connectedWatch == watch || [watch isEqual:self.connectedWatch]) {
        self.connectedWatch = nil;
    }
}

- (void)setTargetWatch:(PBWatch*)watch
{
    NSLog(@"hhhhhh");
   
    self.connectedWatch = watch;
    
    uuid_t myAppUUIDbytes;
    
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"432e8dfc-e78c-4720-9e95-e5f5b4327b1c"];
    
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    
    
    // NOTE:
    // For demonstration purposes, we start communicating with the watch immediately upon connection,
    // because we are calling -appMessagesGetIsSupported: here, which implicitely opens the communication session.
    
    // Test if the Pebble's firmware supports AppMessages :
    [watch appMessagesGetIsSupported:^(PBWatch *watch, BOOL isAppMessagesSupported) {
        if (isAppMessagesSupported)
        {
            
            [self recieverMethod:nil];
        }
        else {
            
            NSString *message = [NSString stringWithFormat:@"Blegh... %@ does NOT support AppMessages :'(", [watch name]];
            [[[UIAlertView alloc] initWithTitle:@"Connected..." message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
}


- (IBAction)recieverMethod:(PBWatch *)sender
{
    uuid_t myAppUUIDbytes;
    
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"432e8dfc-e78c-4720-9e95-e5f5b4327b1c"];
    
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    
    [self.connectedWatch appMessagesAddReceiveUpdateHandler:^BOOL(PBWatch *watch, NSDictionary *update)
     
     {
         NSLog(@"yipiiieeee Received message: %@", update);
         
         return YES;
         
     } withUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    
}

@end
