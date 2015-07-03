//
//  MSAppDelegate.m
//  MSTouchIndicator
//
//  Created by Simon Heys on 07/03/2015.
//  Copyright (c) 2015 Make and Ship Limited. All rights reserved.
//

#import "MSAppDelegate.h"
#import "MSTouchIndicator.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    MSTouchIndicatorApplication *touchIndicatorApplication = (MSTouchIndicatorApplication *)application;
    touchIndicatorApplication.touchColor = [UIColor redColor];
    return YES;
}

@end
