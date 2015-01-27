//
//  ImageSliderViewController.h
//  SelectedImageDelegate
//
//  Created by mareva.local on 1/18/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageSliderViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionViewFlowLayout* _layout;
    NSMutableArray* _data;
    
}

extern int const CELL_MARGIN;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic)UIVisualEffect *blurEffect;
@property(strong, nonatomic)UIVisualEffectView *blurEffectView;
@property(strong, nonatomic) UIImageView* backgroundImageView;
@property (nonatomic, strong) UICollectionView *collectionView;

typedef NS_ENUM(NSInteger, GradientType)
{
    GradientTypeFlavescentGradient,
    GradientTypeChocolateGradient,
    GradientTypeWhiteGradient,
    GradientTypeTurquoiseGradient
};

-(instancetype)initWithSelector:(SEL)action AndTarget:(id)targert;

-(void)applyBlurEffect;

-(void)setData:(NSMutableArray*)data;

-(void)applyGradient:(GradientType) type;
@end
