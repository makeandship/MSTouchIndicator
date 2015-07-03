//
//  MSViewController.m
//  MSTouchIndicator
//
//  Created by Simon Heys on 07/03/2015.
//  Copyright (c) 2015 Simon Heys. All rights reserved.
//

#import "MSViewController.h"
#import "MSTouchIndicator.h"

@interface MSViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *enabledSwitch;
@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateShowsTouches];
}

- (void)updateShowsTouches
{
    MSTouchIndicatorApplication *touchIndicatorApplication = (MSTouchIndicatorApplication *)[UIApplication sharedApplication];
    touchIndicatorApplication.showsTouches = self.enabledSwitch.on;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)switchChanged:(id)sender
{
    [self updateShowsTouches];
}

@end
