#import "ImageSliderViewController.h"
#import "FlickrPhoto.h"
#import "CAGradientLayer+Gradients.h"
#import "PhotoCell.h"
#import "ImageViewer.h"

@interface ImageSliderViewController ()

@end

@implementation ImageSliderViewController
{
    SEL _str;
    __weak id _trgt;
    int _cellSize;
    ImageViewer *_imageViewer;
}

int const CELL_MARGIN = 20;

-(instancetype)initWithSelector:(SEL)action AndTarget:(id)targert
{
    self = [super init];
    if (self) {
        _cellSize = [self calculateCellSize];
        _str = action;
        _trgt = targert;
    }
    
    return self;
}

-(CGFloat)calculateCellSize
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat imageWidth = screenRect.size.width /3;
    return imageWidth - CELL_MARGIN;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;

    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
   
    //collectionview
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, _cellSize + 2* CELL_MARGIN) collectionViewLayout:_layout];
    _collectionView.bounces = NO;
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _layout.sectionInset = UIEdgeInsetsMake(CELL_MARGIN, CELL_MARGIN, CELL_MARGIN, 0);
    [_collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
   

    [self.view addSubview:_collectionView];
    
    _imageViewer = [[ImageViewer alloc] initWithFrame:CGRectMake(0, _collectionView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _collectionView.frame.size.height)];
     _imageViewer.animationType = PanGesture;
    [self.view addSubview:_imageViewer];
}

-(void)setData:(NSMutableArray*)data
{
    NSLog(@"setdata");
    _data = data;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[PhotoCell alloc] init];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 3.0f;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    cell.layer.shadowOpacity = 0.5f;

//    FlickrPhoto *image = _data[indexPath.section];
//    UIImage *thumbnail = image.thumbnail;
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];

    UIImage* img = _data[indexPath.section];
    cell.photo.image = img;
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *datasetCell =(PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSLog([NSString stringWithFormat:@"%ld", (long)indexPath.section]);
    
    [_trgt performSelector:_str withObject: datasetCell.photo];
    
    
    [_imageViewer setImage:datasetCell.photo];
   
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    return CGSizeMake(_cellSize, _cellSize);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _data.count;
}
- (void)applyBlurEffect
{
    self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    self.blurEffectView.frame = self.view.frame;
    [self.view addSubview:self.blurEffectView];
}


- (void)setBackgroundImage:(UIImage*) image
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundImageView.frame = self.view.frame;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view sendSubviewToBack:self.backgroundImageView];
}

-(void)applyGradient:(GradientType)type
{
    CAGradientLayer *backgroundLayer;
    backgroundLayer = [CAGradientLayer whiteGradientLayer];
   
    switch (type) {
       
        case GradientTypeTurquoiseGradient:
             backgroundLayer = [CAGradientLayer turquoiseGradientLayer];
            break;
            
        case GradientTypeChocolateGradient:
            backgroundLayer = [CAGradientLayer chocolateGradientLayer];
            break;
            
        case GradientTypeFlavescentGradient:
            backgroundLayer = [CAGradientLayer flavescentGradientLayer];
            break;

        default:
            break;
    }
    
    backgroundLayer.frame = CGRectMake(0, 0, self.view.frame.size.width * 3, self.view.frame.size.height);
    backgroundLayer.zPosition = -100;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
    
}


@end
