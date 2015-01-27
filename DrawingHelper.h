//
//  DrawingHelper.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/21/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface DrawingHelper : UIButton

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);

@end
