//
//  PhotoCell.m
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/19/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "PhotoCell.h"
#import <CoreGraphics/CoreGraphics.h>
#import "DrawingHelper.h"

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    if (self) {
       
        _photo = [[UIImageView alloc] initWithFrame:self.bounds];
        _photo.clipsToBounds = YES;
       [self addSubview:_photo];
    }
    
    return self;
}

-(void)setPhoto:(UIImageView *)photo{
    _photo = photo;
}

-(void)drawRect:(CGRect)rect{

    UIColor* shadowColor = [UIColor colorWithRed:0.2 green:0.5 blue:0.5 alpha:0.9];
    UIColor* cellColor = [UIColor colorWithRed:1 green:0.5 blue:1 alpha:1];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect outerRect = CGRectIntegral(self.bounds);
    
    CGMutablePathRef cellPath = createRoundedRectForRect(outerRect, 14.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, cellColor.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(4, 4), 10.0, shadowColor.CGColor);
    
    CGContextAddPath(context, cellPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
}

@end
