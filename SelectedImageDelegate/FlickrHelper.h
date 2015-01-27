//
//  FlickrHelper.h
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/19/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrPhoto.h"

@interface FlickrHelper : NSObject

-(NSString*)URLForSearchStringwithSearchString:(NSString*)string;

-(NSString*)URLForFlickrPhotoWithPhoto:(FlickrPhoto*)photo andSize: (NSString*) size;

-(void)searchFlickrWithCompletion:(void(^)(NSString *searchString, NSMutableArray* flickrPhotos, NSError* error))completion AndString:(NSString*)string;
@end
