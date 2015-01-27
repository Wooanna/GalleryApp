//
//  ViewController.m
//  SelectedImageDelegate
//
//  Created by mareva.local on 1/18/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "ViewController.h"
#import "ImageSliderViewController.h"
#import "FlickrHelper.h"

@interface ViewController ()

@end

@implementation ViewController
{

    NSMutableArray *images;
    ImageSliderViewController *imageSlider;
    FlickrHelper *flickrHelper;
    UIImageView *_largeImage;
    NSMutableArray *_fakeGallery;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _largeImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 200, 200)];
    [self.view addSubview:_largeImage];
    
    imageSlider = [[ImageSliderViewController alloc] initWithSelector:@selector(setImage:) AndTarget:self];
        
    [self.view addSubview:imageSlider.view];
    [imageSlider didMoveToParentViewController:self];
    [imageSlider applyGradient:GradientTypeChocolateGradient];

//    flickrHelper =[[FlickrHelper alloc] init];
//    [flickrHelper searchFlickrWithCompletion:^(NSString *searchString, NSMutableArray *flickrPhotos, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [imageSlider setData: flickrPhotos];
//            [imageSlider.collectionView reloadData];
//        });
//    } AndString:@"code"];
    
    _fakeGallery = [[NSMutableArray alloc] init];
    [_fakeGallery addObject:[UIImage imageNamed:@"1.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"2.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"3.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"4.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"5.png"]];
    [_fakeGallery addObject:[UIImage imageNamed:@"6.png"]];
    
   // [imageSlider setData:_fakeGallery];
}

-(void)setImage:(UIImageView *)image{

    _largeImage.image = image.image;
    NSLog(@"Set image");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
