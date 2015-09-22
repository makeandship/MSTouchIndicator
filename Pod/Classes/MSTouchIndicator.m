//
//  MSTouchIndicator.m
//
//  Created by Simon on 03/07/2015.
//  Copyright © 2015 Make and Ship Limited. All rights reserved.
//

#import "MSTouchIndicator.h"

@interface MSTouchIndicatorViewController : UIViewController
@end

@implementation MSTouchIndicatorViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    if ( windows.count > 1 ) {
        return [[[[UIApplication sharedApplication].delegate window] rootViewController] preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}

@end

@interface MSTouchIndicatorView : UIView
@property CATransform3D touchEndTransform;
@property NSTimeInterval touchEndAnimationDuration;
- (instancetype)initWithPoint:(CGPoint)point color:(UIColor *)color touchEndAnimationDuration:(NSTimeInterval)touchEndAnimationDuration touchEndTransform:(CATransform3D)touchEndTransform;
@end

@implementation MSTouchIndicatorView

- (void)removeFromSuperviewAnimated
{
    __weak __typeof(self) blockSelf = self;
    [UIView animateWithDuration:self.touchEndAnimationDuration animations:^{
        blockSelf.alpha = 0.0f;
        blockSelf.layer.transform = self.touchEndTransform;
    }
    completion:^(BOOL completed){
        if ( completed ) {
            [super removeFromSuperview];
        }
    }];
}

- (instancetype)initWithPoint:(CGPoint)point color:(UIColor *)color touchEndAnimationDuration:(NSTimeInterval)touchEndAnimationDuration touchEndTransform:(CATransform3D)touchEndTransform
{
    const CGFloat kFingerRadius = 22.0f;
    
    if ((self = [super initWithFrame:CGRectMake(point.x-kFingerRadius, point.y-kFingerRadius, 2*kFingerRadius, 2*kFingerRadius)])) {
        self.opaque = NO;
        self.layer.cornerRadius = kFingerRadius;
        self.layer.backgroundColor = [color colorWithAlphaComponent:0.7f].CGColor;

        self.touchEndAnimationDuration = touchEndAnimationDuration;
        self.touchEndTransform = touchEndTransform;
    }
    
    return self;
}

@end

@interface MSTouchIndicatorApplication ()
@property (nonatomic, strong) NSMapTable *touchIndicatorsKeyedByTouch;
@property (nonatomic, strong) UIWindow *touchIndicatorWindow;
@end


@implementation MSTouchIndicatorApplication

- (instancetype)init
{
    if ((self = [super init])) {
        self.touchIndicatorsKeyedByTouch = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:10];
        self.touchColor = [UIColor grayColor];
        self.touchEndTransform = CATransform3DMakeScale(1.5, 1.5, 1);
        self.touchEndAnimationDuration = 0.5f;
    }
    return self;
}

- (UIWindow *)touchIndicatorWindow
{
    if ( nil == _touchIndicatorWindow) {
        _touchIndicatorWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _touchIndicatorWindow.userInteractionEnabled = NO;
        _touchIndicatorWindow.windowLevel = 1e+08; //1e07 is keyboard window level!
        _touchIndicatorWindow.rootViewController = [MSTouchIndicatorViewController new];
    }
    return _touchIndicatorWindow;
}

- (void)setShowsTouches:(BOOL)showsTouches
{
    _showsTouches = showsTouches;
    if ( showsTouches ) {
        [self.touchIndicatorWindow makeKeyAndVisible];
        [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
        [self.touchIndicatorWindow.rootViewController setNeedsStatusBarAppearanceUpdate];
    }
    else {
        self.touchIndicatorWindow.hidden = YES;
        self.touchIndicatorWindow = nil;
    }
}

- (void)sendEvent:(UIEvent *)event
{
    if ( self.showsTouches ) {
        [self updateTouches:[event allTouches]];
    }
    [super sendEvent:event];
}

- (void)updateTouches:(NSSet *)touches
{
    for ( UITouch *touch in touches ) {
        CGPoint point = [touch locationInView:self.touchIndicatorWindow.rootViewController.view];
        MSTouchIndicatorView *touchIndicatorView = [self.touchIndicatorsKeyedByTouch objectForKey:touch];
        if (touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded) {
            if ( touchIndicatorView ) {
                [touchIndicatorView removeFromSuperviewAnimated];
                [self.touchIndicatorsKeyedByTouch removeObjectForKey:touch];
            }
        }
        else {
            if ( !touchIndicatorView ) {
                touchIndicatorView = [[MSTouchIndicatorView alloc]
                    initWithPoint:point
                    color:self.touchColor
                    touchEndAnimationDuration:self.touchEndAnimationDuration
                    touchEndTransform:self.touchEndTransform
                ];
                [self.touchIndicatorWindow.rootViewController.view addSubview:touchIndicatorView];
                [self.touchIndicatorsKeyedByTouch setObject:touchIndicatorView forKey:touch];
            }
            else {
                touchIndicatorView.center = point;
            }
        }
    }

    [self removeTouchesActiveTouches:touches];
}

- (void)removeTouchesActiveTouches:(NSSet *)activeTouches
{
    NSEnumerator *enumerator = [self.touchIndicatorsKeyedByTouch keyEnumerator];
    UITouch *touch;
    NSMutableArray *touchesToRemove = [NSMutableArray new];
    while ( touch = [enumerator nextObject] ) {
        if ( !([activeTouches containsObject:touch]) ) {
            [touchesToRemove addObject:touch];
        }
    }
    for ( touch in touchesToRemove ) {
        MSTouchIndicatorView *touchIndicatorView = [self.touchIndicatorsKeyedByTouch objectForKey:touch];
        [touchIndicatorView removeFromSuperviewAnimated];
        [self.touchIndicatorsKeyedByTouch removeObjectForKey:touch];
    }
}

@end
