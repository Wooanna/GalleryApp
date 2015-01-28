//
//  ImageViewer.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/23/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType)
{
    AnimationTypeFadeInFadeOut,
    AnimationTypeSlideInNewPicture,
    AnimationTypePanGesture
    
};

@interface ImageViewer : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView* centralImage;

@property (nonatomic, assign) AnimationType animationType;

-(void)setImage:(int)index;

-(void)setData:(NSMutableArray*) data;

@end
