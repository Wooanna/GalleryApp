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
    UIView *_centralImageForPanning;
    UIPanGestureRecognizer *_panGesture;
    NSArray *_data;
    BOOL didMoveLeftOrRight;
    UIView *currentDraggableView;
    UIView *viewToTheLeft;
    UIView *viewToTheRight;
    int indexOfCentralImage;
}

const int OFFSET = 250;


-(id)init
{
    self = [super init];
    if(self){
            }
    return self;
}


- (void)setupForAnimationTypeFadeInFadeOut
{
    self.centralImage = [[UIView alloc] initWithFrame:[self calcPercentageOfFrame:self.view.frame]];
    _topImageLayer = [[CALayer alloc] init];
    _bottomImageLayer = [[CALayer alloc] init];
    _topImageLayer.frame = self.centralImage.bounds;
    _bottomImageLayer.frame = self.centralImage.bounds;
    _topImageLayer.opacity = 1.0;
    _bottomImageLayer.opacity = 0.0;
    _topImageLayer.backgroundColor = [UIColor clearColor].CGColor;
    _topImageLayer.contents = (id)[UIImage imageNamed:@"initial.png"].CGImage;
    
    [self.centralImage.layer addSublayer:_bottomImageLayer];
    [self.centralImage.layer addSublayer:_topImageLayer];
    [self customizeView:self.centralImage];
    [self.view addSubview:self.centralImage];
}


-(void)customizeView:(UIView*)view
{
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 3.0f;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    view.layer.shadowOpacity = 0.5f;

}

- (void)setupForAnimationTypeSlideInNewPicture
{
    _secondImage =
    [[UIView alloc] initWithFrame:CGRectMake(self.centralImage.frame.origin.x - OFFSET, self.centralImage.frame.origin.y, self.centralImage.frame.size.width, self.centralImage.frame.size.height)];
     [self customizeView:_secondImage];
    [self.view addSubview:_secondImage];
}

- (void)setupForAnimationTypePanGesture
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:_panGesture];
    
    [self createHelperImagesForPanning];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.animationType == AnimationTypeFadeInFadeOut){
        
        [self setupForAnimationTypeFadeInFadeOut];

    }
    else if(self.animationType == AnimationTypeSlideInNewPicture){
        
        [self setupForAnimationTypeSlideInNewPicture];
        
    }
    else if(self.animationType == AnimationTypePanGesture){
            
        [self setupForAnimationTypePanGesture];
    }
    
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

- (void)setCurrentImage:(int)index
{
    indexOfCentralImage = index;
    
    if(indexOfCentralImage < 0){
        
        indexOfCentralImage = (int)_data.count - 1;
    }
    if(indexOfCentralImage>= (int)_data.count - 1){
        indexOfCentralImage = 0;
    }
    
    if(indexOfCentralImage == 0){
        
        UIImage* p = [_data lastObject];
        UIImage* n = [_data objectAtIndex:1];
        viewToTheLeft.layer.contents = (id) p.CGImage;
        viewToTheRight.layer.contents = (id) n.CGImage;
        
    }
    else if(indexOfCentralImage == _data.count - 1){
        
        UIImage* p = [_data objectAtIndex:_data.count - 1];
        UIImage* n = [_data firstObject];
        viewToTheLeft.layer.contents = (id) p.CGImage;
        viewToTheRight.layer.contents = (id) n.CGImage;
        
    }
    else{
        UIImage* p = [_data objectAtIndex:indexOfCentralImage - 1];
        UIImage* n = [_data objectAtIndex:indexOfCentralImage + 1];
        viewToTheLeft.layer.contents = (id) p.CGImage;
        viewToTheRight.layer.contents = (id) n.CGImage;
    }
}

-(void)setImage:(int)index
{
    
    indexOfCentralImage = index;
    
    if(self.animationType == AnimationTypeFadeInFadeOut){
    
    if(_bottomImageLayer.opacity == 0){
     
        UIImage* i = _data[index];
        _bottomImageLayer.contents = (id) i.CGImage;

        [_animator fadeOutView:_topImageLayer withDuration:2.0];
        [_animator fadeInView:_bottomImageLayer withDuration:2.0];
       
    }
    else{
        
        UIImage* i = _data[index];
        _topImageLayer.contents = (id) i.CGImage;
       
        [_animator fadeOutView:_bottomImageLayer withDuration:2.0];
        [_animator fadeInView:_topImageLayer withDuration:2.0];
    }
        
    }
    else if(self.animationType == AnimationTypeSlideInNewPicture && self.animationType != AnimationTypePanGesture){
        
        UIImage* i = _data[index];
        _secondImage.layer.contents = (id) i.CGImage;
        
        [_animator slideInFromLeft:_secondImage withDuration:1.0 andDelay:0.2 andSpeed:1.0 andSpace:270.0];
        [_animator slideInFromLeft:self.centralImage withDuration:1.0 andDelay:0.0 andSpeed:1.0 andSpace:300.0];

    }
    else if(self.animationType == AnimationTypePanGesture){
        
            UIImage* i = _data[index];
           _centralImageForPanning.layer.contents = (id) i.CGImage;
        
            [self setCurrentImage:index];
    }
  
}

-(void)handlePanGesture: (UIPanGestureRecognizer*)sender
{
    
    if(self.animationType == AnimationTypePanGesture){
      
    CGPoint translation = [sender translationInView: sender.view];
    CGPoint pointOnView = [sender locationInView:sender.view];
        
       //check which view is tapped
        if(CGRectContainsPoint(_centralImageForPanning.frame, pointOnView)){
            
            currentDraggableView = _centralImageForPanning;
            viewToTheLeft = _leftImageForPanning;
            viewToTheRight = _rightImageForPanning;
            
        }
        else if(CGRectContainsPoint(_leftImageForPanning.frame, pointOnView)){
            
            currentDraggableView = _leftImageForPanning;
            viewToTheRight = _centralImageForPanning;
            viewToTheLeft = _rightImageForPanning;
           
        }
        else if(CGRectContainsPoint(_rightImageForPanning.frame, pointOnView)){
            
            currentDraggableView = _rightImageForPanning;
            viewToTheLeft = _centralImageForPanning;
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
                [self setCurrentImage:indexOfCentralImage];
                indexOfCentralImage++;
             
            }
            else if(currentDraggableView.center.x > [[UIScreen mainScreen] bounds].size.width){
                
                [_animator slideImageRight:currentDraggableView];
                [_animator setImageToCenter:viewToTheLeft];
                 viewToTheRight.center = CGPointMake(-164, 132);
                 [self setCurrentImage:indexOfCentralImage];
                indexOfCentralImage --;
                
            }
            else
            {
                [_animator setImageToCenter:currentDraggableView];
            }

        }
    }
}

-(void)createHelperImagesForPanning
{
    //CREATE TWO VIEWS LEFT AND RIGHT OF THE CENTRAL ONE SO THEY CAN COME WHEN YOU PAN THE CENTRAL IMAGE
    _centralImageForPanning = [[UIView alloc] initWithFrame:[self calcPercentageOfFrame:self.view.frame]];

    _leftImageForPanning = [[UIView alloc] initWithFrame:CGRectMake(_centralImageForPanning.frame.origin.x - (_centralImageForPanning.frame.size.width + 100), _centralImageForPanning.frame.origin.y, _centralImageForPanning.frame.size.width, _centralImageForPanning.frame.size.height)];
    viewToTheLeft = _leftImageForPanning;
    _rightImageForPanning = [[UIView alloc] initWithFrame:CGRectMake(_centralImageForPanning.frame.origin.x - (-_centralImageForPanning.frame.size.width - 100), _centralImageForPanning.frame.origin.y, _centralImageForPanning.frame.size.width, _centralImageForPanning.frame.size.height)];
    viewToTheRight = _rightImageForPanning;
    
     [self customizeView:_leftImageForPanning];
     [self customizeView:_rightImageForPanning];
     [self customizeView:_centralImageForPanning];
    [self.view addSubview:_leftImageForPanning];
    [self.view addSubview:_rightImageForPanning];
    [self.view addSubview:_centralImageForPanning];
  
}

-(void)setData:(NSMutableArray*) data
{
    _data = data;
}


@end
