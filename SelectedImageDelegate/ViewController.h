//
//  ViewController.h
//  SelectedImageDelegate
//
//  Created by mareva.local on 1/18/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *ImageSliderContainer;

-(void)setImage:(UIImageView*)imageView;

@end

