//
//  CalleryViewController.m
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/22/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "GalleryViewController.h"
#import "PhotoAlbumCell.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";

@implementation GalleryViewController
{
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_layout;
    NSInteger *_rotationsCount;
    NSMutableArray *_rotations;
    id _target;
    SEL _selector;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.albums = [[NSMutableArray alloc]init];
      // self = [self initWithData:self.albums];
    }
    
    return self;
    
}

-(id)initWithData:(NSMutableArray *)array andSelector:(SEL)action andTarget:(id)target
{
    self = [super init];
    if (self) {
        
        _target = target;
        _selector = action;
        self.albums = [[NSMutableArray alloc]init];
        self.albums = array;
        _rotations = [[NSMutableArray alloc] initWithArray:@[@0.02f, @0.01f, @-0.01f, @-0.02f]];
       
    }
    
    return self;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _layout = [[UICollectionViewFlowLayout alloc] init];
    
    _layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:_layout];
 
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"upfeathers.png"]];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView registerClass:[PhotoAlbumCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  
    [self.view addSubview:_collectionView];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.albums.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoAlbumCell *photoCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier
                                              forIndexPath:indexPath];
    if (!photoCell) {
        photoCell = [[PhotoAlbumCell alloc] init];
    }
    
    NSMutableArray* album = self.albums[indexPath.section];
    
    if(album.count > 4){
      
        for (NSInteger i = 0; i < 4; i++) {
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:album[i]];
            [photoCell addSubview:  [self customize:imageView]];
        }
    
    }else{
        
        for (UIImage* photo in album) {
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:photo];
            [photoCell.contentView addSubview: imageView];
            
        }
    }
   
    return photoCell;
}

-(UIView*)customize:(UIView*)view
{
    NSNumber* rotationAngle =_rotations[arc4random_uniform((int)_rotations.count)];
    CGFloat angle = 2* M_PI * [rotationAngle floatValue];
    CATransform3D transform = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
    view.layer.transform = transform;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    view.layer.shouldRasterize = YES;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 3.0f;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    view.layer.shadowOpacity = 0.5f;
    
    return view;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(100, 100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int selectedItem = (int) indexPath.row;
    //PhotoAlbumCell * selectedCell = (PhotoAlbumCell*)[collectionView cellForItemAtIndexPath:indexPath];
    //NSMutableArray *selectedAlbum = self.albums[selectedItem];
    
    [_target performSelector:_selector withObject:[NSNumber numberWithInt: selectedItem]];
    
}


@end
