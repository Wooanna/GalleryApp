//
//  AnimationsHelper.m
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/23/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "AnimationsHelper.h"

@implementation AnimationsHelper{

    CGPoint centralPosition;
    CGPoint leftPosition;
    CGPoint rightPosition;
    
}
-(instancetype)init
{
  self = [super init];
    if(self){
        centralPosition = CGPointMake([[UIScreen mainScreen] bounds].size.width /2, 132 );
        rightPosition = CGPointMake([[UIScreen mainScreen] bounds].size.width * 2, 132 );
        leftPosition = CGPointMake([[UIScreen mainScreen] bounds].size.width * -2, 132 );
    }
    
    return self;
}

-(void)fadeInView:(CALayer*)layer withDuration:(int)duration
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithInt:duration]
                     forKey:kCATransactionAnimationDuration];
    layer.opacity = 1.0;
 
    [CATransaction commit];
}

-(void)fadeOutView:(CALayer*)layer withDuration:(int)duration
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithInt:duration]
                     forKey:kCATransactionAnimationDuration];
    layer.opacity = 0.0;

    [CATransaction commit];
    
}

-(void)slideInFromLeft:(UIView *)view withDuration:(int)duration andDelay:(float)delay andSpeed:(float)speed andSpace:(float)space
{
    
    [UIView animateWithDuration:(1.0 / speed)
                          delay:delay
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         NSLog(@"%f", view.frame.origin.x);
                            view.frame = CGRectMake(view.frame.origin.x + space, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
                        } completion:^(BOOL finished) {
                            
                        }];
 
}

-(void)setImageToCenter:(UIView*) view{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGFloat f = view.center.y;
                         
                         NSLog(@"fffffffffff%f", f);
                         view.center = centralPosition;
                         // view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width /2, view.center.y);
                     } completion:^(BOOL finished) {
                         
                     }];

}

-(void)slideImageRight:(UIView*) view{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                        
                         view.center = rightPosition;
                         //view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width * 2, view.center.y);
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)slideImageLeft:(UIView*) view{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         view.center = leftPosition;
                        // view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width * -2, view.center.y);
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

@end
