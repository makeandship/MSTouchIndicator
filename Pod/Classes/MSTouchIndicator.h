//
//  MSTouchIndicator.h
//
//  Created by Simon on 03/07/2015.
//  Copyright © 2015 Make and Ship Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTouchIndicatorApplication : UIApplication
@property (nonatomic) BOOL showsTouches;
@property (nonatomic) UIColor *touchColor;
@property (nonatomic) NSTimeInterval touchEndAnimationDuration;
@property (nonatomic) CATransform3D touchEndTransform;
@end
