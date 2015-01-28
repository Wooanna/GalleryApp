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
    NSArray *_data;
}

const int OFFSET = 250;


-(id)init
{
    self = [super init];
    if(self){
        
    }
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
        self.centralImage = [[UIView alloc] initWithFrame:[self calcPercentageOfFrame:self.view.frame]];
        
        if(self.animationType == SlideInNewPicture){
            _secondImage =
            [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - OFFSET, self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
            [self.view addSubview:_secondImage];
        }else if(self.animationType == PanGesture){
          [self createHelperImagesForPanning];
        
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
        [self.view addGestureRecognizer:_panGesture];
        [self.view addSubview:self.centralImage];
    
        _animator = [[AnimationsHelper alloc] init];
   
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

-(void)setImage:(int)index
{
       if(self.animationType == FadeInFadeOut){
    
    if(_bottomImageLayer.opacity == 0){
     
        UIImage* i = _data[index];
        _bottomImageLayer.contents = (id) i.CGImage;

        [_animator fadeOutView:_topImageLayer withDuration:2.0];
        [_animator fadeInView:_bottomImageLayer withDuration:2.0];
       
    }else{
        UIImage* i = _data[index];
        _topImageLayer.contents = (id) i.CGImage;
       
        [_animator fadeOutView:_bottomImageLayer withDuration:2.0];
        [_animator fadeInView:_topImageLayer withDuration:2.0];
    }
        
    }else if(self.animationType == SlideInNewPicture && self.animationType != PanGesture){
        UIImage* i = _data[index];
        _secondImage.layer.contents = (id) i.CGImage;
        
        [_animator slideInFromLeft:_secondImage withDuration:1.0 andDelay:0.2 andSpeed:1.0 andSpace:270.0];
        [_animator slideInFromLeft:self.centralImage withDuration:1.0 andDelay:0.0 andSpeed:1.0 andSpace:300.0];
            

    }else if(self.animationType == PanGesture){
        
        if(_bottomImageLayer.opacity == 0){
         
            UIImage* i = _data[index];
 
            _bottomImageLayer.contents = (id) i.CGImage;
            [_animator fadeOutView:_topImageLayer withDuration:2.0];
            [_animator fadeInView:_bottomImageLayer withDuration:2.0];
            
        }else{
            
            UIImage* i = _data[index];
            _topImageLayer.contents = (id) i.CGImage;
            [_animator fadeOutView:_bottomImageLayer withDuration:2.0];
            [_animator fadeInView:_topImageLayer withDuration:2.0];
        }
        
        if(index == 0){
            
            UIImage* p = [_data lastObject];
            UIImage* n = [_data objectAtIndex:1];
            _leftImageForPanning.layer.contents = (id) p.CGImage;
            _rightImageForPanning.layer.contents = (id) n.CGImage;
            
        }else if(index == _data.count - 1){
            
            UIImage* p = [_data objectAtIndex:_data.count - 1];
            UIImage* n = [_data firstObject];
            _leftImageForPanning.layer.contents = (id) p.CGImage;
            _rightImageForPanning.layer.contents = (id) n.CGImage;
            
        }else{
            UIImage* p = [_data objectAtIndex:index - 1];
            UIImage* n = [_data objectAtIndex:index + 1];
            _leftImageForPanning.layer.contents = (id) p.CGImage;
            _rightImageForPanning.layer.contents = (id) n.CGImage;
        }
     
    }
  
}

-(void)handlePanGesture: (UIPanGestureRecognizer*)sender
{
    
    if(self.animationType == PanGesture){

        UIView *currentDraggableView;
        UIView *viewToTheLeft;
        UIView *viewToTheRight;
        
    CGPoint translation = [sender translationInView: sender.view];
    CGPoint pointOnView = [sender locationInView:sender.view];
        
       //check which view is tapped
        if(CGRectContainsPoint(self.centralImage.frame, pointOnView)){
            
            currentDraggableView = self.centralImage;
            viewToTheLeft = _leftImageForPanning;
            viewToTheRight = _rightImageForPanning;
            
        }else if(CGRectContainsPoint(_leftImageForPanning.frame, pointOnView)){
            
            currentDraggableView = _leftImageForPanning;
            viewToTheRight = self.centralImage;
            viewToTheLeft = _rightImageForPanning;
         
        }else if(CGRectContainsPoint(_rightImageForPanning.frame, pointOnView)){
            
            currentDraggableView = _rightImageForPanning;
            viewToTheLeft = self.centralImage;
            viewToTheRight = _leftImageForPanning;
        }
        
        currentDraggableView.center=CGPointMake(currentDraggableView.center.x+translation.x, currentDraggableView.center.y);
       [sender setTranslation:CGPointMake(0, 0) inView:sender.view];

        if(sender.state == UIGestureRecognizerStateEnded)
        {
            if(currentDraggableView.center.x < 0){
                
                [_animator slideImageLeft:currentDraggableView];
                [_animator setImageToCenter:viewToTheRight];
                viewToTheLeft.center = CGPointMake(484, 132);
             
            }else if(currentDraggableView.center.x > [[UIScreen mainScreen] bounds].size.width){
                
                [_animator slideImageRight:currentDraggableView];
                [_animator setImageToCenter:viewToTheLeft];
                
                 viewToTheRight.center = CGPointMake(-164, 132);
            }else{
                
                [_animator setImageToCenter:currentDraggableView];
                
            }

        }
    }
}

-(void)createHelperImagesForPanning
{
    //CREATE TWO VIEWS LEFT AND RIGHT OF THE CENTRAL ONE SO THEY CAN COME WHEN YOU PAN THE CENTRAL IMAGE
    _leftImageForPanning = [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - (self.centralImage.frame.size.width + 100), self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
    
    _rightImageForPanning = [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - (-self.centralImage.frame.size.width - 100), self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
    
    [self.view addSubview:_leftImageForPanning];
    [self.view addSubview:_rightImageForPanning];
  
}

-(void)setData:(NSMutableArray*) data
{
    _data = data;
}


@end
