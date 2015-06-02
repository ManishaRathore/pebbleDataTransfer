//
//  ViewController.m
//  pebbleDataTransfer
//
//  Created by Sarvjeet on 22/05/15.
//  Copyright (c) 2015 emx. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController


#pragma mark - ViewLife Cycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - PebbleMethod


- (IBAction)SendPebbleData:(PBWatch *)sender
{
    NSLog(@"yes working");
    
    uuid_t myAppUUIDbytes;
    
    NSUUID *myAppUUID = [[NSUUID alloc] initWithUUIDString:@"432e8dfc-e78c-4720-9e95-e5f5b4327b1c"];
    
    [myAppUUID getUUIDBytes:myAppUUIDbytes];
    
    [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:myAppUUIDbytes length:16]];
    
    PBWatch *lastWatch = [[PBPebbleCentral defaultCentral] lastConnectedWatch];
    
    NSLog(@"yes working");
    
    
    [lastWatch getVersionInfo:^(PBWatch *watch, PBVersionInfo *versionInfo )
     {
         NSLog(@"Pebble name: %@", [watch name]);
       
         NSLog(@"Pebble serial number: %@", [watch serialNumber]);
      
         NSLog(@"Pebble firmware os version: %li", (long)versionInfo.runningFirmwareMetadata.version.os);
        
         NSLog(@"Pebble firmware major version: %li", (long)versionInfo.runningFirmwareMetadata.version.major);
      
         NSLog(@"Pebble firmware minor version: %li", (long)versionInfo.runningFirmwareMetadata.version.minor);
       
         NSLog(@"Pebble firmware suffix version: %@", versionInfo.runningFirmwareMetadata.version.suffix);
   
     }
                    onTimeout:^(PBWatch *watch)
    {
        NSLog(@"Timed out trying to get version info from Pebble.");
    }];
    
    [lastWatch appMessagesGetIsSupported:^(PBWatch *watch, BOOL isAppMessagesSupported)
     {
        if (isAppMessagesSupported)
        {
            [watch appMessagesLaunch:^(PBWatch *watch, NSError *error) {
                
                if (error)
                {
                    NSLog(@"ERROR: Could not launch watch app\n%@\n%@",[error localizedDescription], [error userInfo]);

                }
                else
                {
                    NSLog(@"Watch app launched");
                }
                
            }];
        }
    }];
  
    NSNumber *allExercises = @(1);

    NSMutableDictionary *update =[[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *ExerciseSizeDict = [[NSMutableDictionary alloc] init];
    
    NSNumber *array = @(10);
    
    
    NSNumber *strName = @(11);
    
    NSNumber *strLoadNAme = @(14);
    
    NSNumber *eType = @(12);
    
    NSNumber *eBreak = @(16);
    
    NSNumber *nLoadInc = @(15);
    
    NSNumber *nBreakdur = @(17);
    
    NSNumber *nSeq = @(10);
    
    NSNumber *nPlanSets = @(13);
    
 
    
    NSNumber *nseqq = @(20);
    
    NSNumber *nPlaneExSetID = @(23);
    
    NSNumber *nPlannedReps = @(21);
    
    NSNumber *nPlannedLoad  = @(22);
    

    [update setObject:[NSNumber numberWithInt32:0] forKey:array];
    
    [update setObject:@" Bench Press" forKey:strName];
    
    [update setObject:[NSNumber numberWithInt:1] forKey:eType];
    
    [update setObject:[NSNumber numberWithInt:2] forKey:nPlanSets];
    
    [update setObject:@"Pound" forKey:strLoadNAme];
    
    [update setObject:[NSNumber numberWithInt:5] forKey:nLoadInc];
    
    [update setObject:[NSNumber numberWithInt:30] forKey:nBreakdur];
    
    [update setObject:[NSNumber numberWithInt:1] forKey:eBreak];
    
    [update setObject:[NSNumber numberWithInt:0] forKey:nSeq];
    
    [update setObject:[NSNumber numberWithInt:1] forKey:eType];
    
    
    [update setObject:[NSNumber numberWithInt:0] forKey:array];

    
    [update setObject:[NSNumber numberWithInt:10] forKey:nPlannedLoad];
    
    [update setObject:[NSNumber numberWithInt:7778] forKey:nPlaneExSetID];
    
    [update setObject:[NSNumber numberWithInt:10] forKey:nPlannedReps];

    [update setObject:[NSNumber numberWithInt:0] forKey:nseqq];


    [ExerciseSizeDict setObject:[NSNumber numberWithInt32:1] forKey:allExercises];
    
  
    [lastWatch appMessagesPushUpdate:ExerciseSizeDict onSent:^(PBWatch *watch, NSDictionary *update1, NSError *error)
    {
        NSLog(@"....yes suppoerted%@",update1);
        
        if (!error)
        {
            [lastWatch appMessagesPushUpdate:update onSent:^(PBWatch *watch, NSDictionary *update1, NSError *error)
             {
                 NSLog(@"....yes %@",update1);
                 
                 if (!error)
                 {
                     NSLog(@" sent message.");
                     
                 }
                 
                 else
                     
                 {
                     NSLog(@"Error sending message: %@", error);
                 }
             }];

        }
        else
        {
            NSLog(@"Error sending message: %@", error);
        }
    }];
   
    
    [self.connectedWatch appMessagesAddReceiveUpdateHandler:^BOOL(PBWatch *watch, NSDictionary *update)
     {
        NSLog(@"Received message: %@", update);
       
         return YES;
    }];
}






@end
