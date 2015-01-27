//
//  ImageViewer.m
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/23/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "ImageViewer.h"
#import "AnimationsHelper.h"

@implementation ImageViewer
{
    AnimationsHelper* _animator;
    CALayer *_topImageLayer;
    CALayer *_bottomImageLayer;
    UIView *_secondImage;
    UIView *_leftImageForPanning;
    UIView *_rightImageForPanning;
    UIPanGestureRecognizer *_panGesture;
}

const int OFFSET = 250;

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.centralImage = [[UIView alloc] initWithFrame:[self calcPercentageOfFrame:frame]];
        
        if(self.animationType == SlideInNewPicture){
            _secondImage =
            [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - OFFSET, self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
            [self addSubview:_secondImage];
        }
        
        if(self.animationType == PanGesture){
            //CREATE TWO VIEWS LEFT AND RIGHT OF THE CENTRAL ONE SO THEY CAN COME WHEN YOU PAN THE CENTRAL IMAGE
            _leftImageForPanning = [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - (self.centralImage.frame.size.width * 2), self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
            
            _rightImageForPanning = [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - (-self.centralImage.frame.size.width * 2), self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
            
            _leftImageForPanning.backgroundColor = [UIColor yellowColor];
            _rightImageForPanning.backgroundColor = [UIColor yellowColor];
            
            [self addSubview:_leftImageForPanning];
            [self addSubview:_rightImageForPanning];
            
        }
        
        _topImageLayer = [[CALayer alloc] init];
        _bottomImageLayer = [[CALayer alloc] init];
        _topImageLayer.frame = self.centralImage.bounds;
        _bottomImageLayer.frame = self.centralImage.bounds;
        _topImageLayer.opacity = 1.0;
        _bottomImageLayer.opacity = 0.0;
        _topImageLayer.backgroundColor = [UIColor clearColor].CGColor;
        _topImageLayer.contents = (id)[UIImage imageNamed:@"initial.png"].CGImage;
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        
        [self.centralImage.layer addSublayer:_bottomImageLayer];
        [self.centralImage.layer addSublayer:_topImageLayer];
        
        self.centralImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.centralImage.layer.borderWidth = 3.0f;
        self.centralImage.layer.shadowColor = [UIColor blackColor].CGColor;
        self.centralImage.layer.shadowRadius = 3.0f;
        self.centralImage.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.centralImage.layer.shadowOpacity = 0.5f;
        [self addGestureRecognizer:_panGesture];
        [self addSubview:self.centralImage];
    
        _animator = [[AnimationsHelper alloc] init];
           }
    return self;
}


-(CGRect)calcPercentageOfFrame:(CGRect)frame
{
    int percentage = 30;
    CGFloat width = frame.size.width -((frame.size.width * percentage) / 100);
    CGFloat height = width;
    CGFloat x = (frame.size.width - width) /2;
    CGFloat y = 20;//(frame.size.height - height) / 2;
    
    return CGRectMake(x, y, width, height);
}

-(void)setImage:(UIImageView*)image
{
       if(self.animationType == FadeInFadeOut){
    
    if(_bottomImageLayer.opacity == 0){
        _bottomImageLayer.contents = (id)image.image.CGImage;
        [_animator fadeOutView:_topImageLayer withDuration:2.0];
        [_animator fadeInView:_bottomImageLayer withDuration:2.0];
       
    }else{
        _topImageLayer.contents = (id)image.image.CGImage;
        [_animator fadeOutView:_bottomImageLayer withDuration:2.0];
        [_animator fadeInView:_topImageLayer withDuration:2.0];
    }
        
    }else if(self.animationType == SlideInNewPicture && self.animationType != PanGesture){
    
        _secondImage.layer.contents = (id)image.image.CGImage;
        
        [_animator slideInFromLeft:_secondImage withDuration:1.0 andDelay:0.2 andSpeed:1.0 andSpace:270.0];
        [_animator slideInFromLeft:self.centralImage withDuration:1.0 andDelay:0.0 andSpeed:1.0 andSpace:300.0];
            

    }else if(self.animationType == PanGesture){
        
        if(_bottomImageLayer.opacity == 0){
            _bottomImageLayer.contents = (id)image.image.CGImage;
            [_animator fadeOutView:_topImageLayer withDuration:2.0];
            [_animator fadeInView:_bottomImageLayer withDuration:2.0];
            
        }else{
            _topImageLayer.contents = (id)image.image.CGImage;
            [_animator fadeOutView:_bottomImageLayer withDuration:2.0];
            [_animator fadeInView:_topImageLayer withDuration:2.0];
        }
        
    }
  
}

-(void)handlePanGesture: (UIPanGestureRecognizer*)sender
{
    
    if(self.animationType == PanGesture){
    CGPoint translation = [sender translationInView: sender.view];
    
    self.centralImage.center=CGPointMake(self.centralImage.center.x+translation.x, self.centralImage.center.y);
    
    [sender setTranslation:CGPointMake(0, 0) inView:sender.view];
       
        CGFloat point =  self.centralImage.center.x;
        CGFloat center =[[UIScreen mainScreen] bounds].size.width /2;
        NSLog(@"%f", point);
        NSLog(@"%f", center);

        if(sender.state == UIGestureRecognizerStateEnded)
        {
            if(self.centralImage.center.x < 0){
                
                [_animator slideImageLeft:self.centralImage];
                [_animator setImageToCenter:_rightImageForPanning];
                
            }else if(self.centralImage.center.x > [[UIScreen mainScreen] bounds].size.width){
                
                [_animator slideImageRight:self.centralImage];
                  [_animator setImageToCenter:_leftImageForPanning];
                
            }else{
                
                [_animator setImageToCenter:self.centralImage];
                
            }
        }
    }
}


@end
