//
//  MSTouchIndicatorApplication.h
//  Hark
//
//  Created by Simon on 03/07/2015.
//  Copyright © 2015 Simon Heys Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTouchIndicatorApplication : UIApplication
@property (nonatomic) BOOL showsTouches;
@property (nonatomic) UIColor *touchColor;
@property (nonatomic) NSTimeInterval touchEndAnimationDuration;
@property (nonatomic) CATransform3D touchEndTransform;
@end
