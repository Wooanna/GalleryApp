//
//  ImageViewer.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/23/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewer : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView* centralImage;

typedef NS_ENUM(NSInteger, AnimationType)
{
    FadeInFadeOut,
    SlideInNewPicture,
    PanGesture

};

@property (nonatomic, assign) AnimationType animationType;

-(void)setImage:(UIImageView*)image;

@end
