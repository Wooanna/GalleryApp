//
//  PhotoCell.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/19/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* photo;

-(void)setPhoto:(UIImageView *)photo;
@end
