//
//  CalleryViewController.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/22/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray* albums;

-initWithData:(NSMutableArray*)array andSelector:(SEL)action andTarget:(id)target;

@end
