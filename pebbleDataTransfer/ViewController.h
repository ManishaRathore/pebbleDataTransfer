//
//  ViewController.h
//  pebbleDataTransfer
//
//  Created by Sarvjeet on 22/05/15.
//  Copyright (c) 2015 emx. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <PebbleKit/PebbleKit.h>


@interface ViewController : UIViewController <PBDataLoggingServiceDelegate, PBWatchDelegate, PBPebbleCentralDelegate>


@property (strong,nonatomic) PBWatch *connectedWatch;


typedef enum{s=1,m,t,w,th,f,sa} days;

@property (nonatomic, assign) id appUpdateHandle;


@end
