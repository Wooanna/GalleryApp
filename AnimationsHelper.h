//
//  AnimationsHelper.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/23/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AnimationsHelper : NSObject



-(void)fadeInView:(CALayer*)layer withDuration:(int)duration;

-(void)fadeOutView:(CALayer*)layer withDuration:(int)duration;

-(void)slideInFromLeft:(UIView*)view withDuration:(int)duration andDelay:(float)delay andSpeed:(float)speed andSpace:(float)space;

-(void)setImageToCenter:(UIView*) view;

-(void)slideImageLeft:(UIView*) view;

-(void)slideImageRight:(UIView*) view;
@end
