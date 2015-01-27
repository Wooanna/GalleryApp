//
//  FlickrPhoto.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/19/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FlickrPhoto : NSObject

@property(nonatomic, strong) UIImage* thumbnail;
@property(nonatomic, strong) UIImage* largeImage;
@property(nonatomic, strong) NSString* photoID;
@property(nonatomic, strong) NSString* farm;

@property(nonatomic, strong) NSString* server;
@property(nonatomic, strong) NSString* secret;


@end
