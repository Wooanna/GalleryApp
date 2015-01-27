//
//  MainViewController.m
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/22/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "ImageSliderViewController.h"

@implementation MainViewController
{
    GalleryViewController *_albumsGallery;
    ImageSliderViewController *_imageSlider;
    NSMutableArray* _fakeAllbums;
    UIImageView* _largeImage;

}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    _fakeAllbums = [[NSMutableArray alloc]init];
   
  
     NSMutableArray *_fakeGallery = [[NSMutableArray alloc] init];
    [_fakeGallery addObject:[UIImage imageNamed:@"1.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"2.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"3.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"4.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"5.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"6.png"]];
    
    for (int i = 0; i < 10; i++) {
        
         [_fakeAllbums addObject:_fakeGallery];
    }
  
    _albumsGallery = [[GalleryViewController alloc] initWithData:_fakeAllbums andSelector:@selector(loadImageSlider:) andTarget:self];
    [self.view addSubview:_albumsGallery.view];
   
}

-(void)loadImageSlider:(NSNumber*)selectedIndexPath
{
    _imageSlider  = [[ImageSliderViewController alloc] initWithSelector:@selector(setImage:) AndTarget:self];
    [_imageSlider setData:_fakeAllbums[selectedIndexPath.intValue]];
    [_imageSlider didMoveToParentViewController:self];
    [_imageSlider applyGradient:GradientTypeChocolateGradient];
    [self.navigationController pushViewController:_imageSlider animated:YES];
}

-(void)setImage:(UIImageView*)image
{
   
}

@end
