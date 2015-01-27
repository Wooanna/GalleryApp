//
//  FlickrHelper.m
//  SelectedImageDelegate
//
//  Created by Yoanna Mareva on 1/19/15.
//  Copyright (c) 2015 mareva.local. All rights reserved.
//

#import "FlickrHelper.h"

@implementation FlickrHelper

-(NSString*)URLForSearchStringwithSearchString:(NSString*)string
{
    
    NSString* apiKey = @"189257cefa9599699ed00b66ceb123aa";
    NSString* search = [string stringByAddingPercentEscapesUsingEncoding:(NSUTF8StringEncoding)];
    NSString* http = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=";
    NSString* text = @"&text=";
    NSString* format = @"&per_page=5&format=json&nojsoncallback=1";
    return [NSString stringWithFormat:@"%@%@%@%@%@", http, apiKey, text, search, format];
   
}

-(NSString *)URLForFlickrPhotoWithPhoto:(FlickrPhoto *)photo andSize :(NSString *)size{
    NSString* imagesSize = size;
    
    if(imagesSize == nil || imagesSize.length == 0){
        imagesSize = @"s";
    }
    
    NSString* one = @"https://farm";
    NSString* two = @".staticflickr.com/";
    NSString* dash = @"_";
    NSString* line = @"/";
    NSString* jpeg = @".jpg";
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@", one, photo.farm, two, photo.server, line, photo.photoID, dash, photo.secret, dash, imagesSize, jpeg];
}

-(void)searchFlickrWithCompletion:(void(^)(NSString* searchString, NSMutableArray* flickrPhotos, NSError* error))completion AndString:(NSString*)string
{
    
    NSString* searchURL = [self URLForSearchStringwithSearchString:string];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSError* error;
        NSString* searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL] encoding:NSUTF8StringEncoding error: &error];
        
        if (error!= nil){
            completion(string, nil, error);
            
        }
        else{
            NSData* jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
            
            NSDictionary* resultDict = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&error];
            
            if(error != nil){
                completion(string, nil, error);
            }else{
                NSString* status = [resultDict objectForKey:@"stat"];
                
                if([status  isEqual: @"fail"]){
                    //create error
                    NSLog(@"error occured");
                }else{
                    NSArray* resultArray = [[resultDict objectForKey:@"photos"] objectForKey:@"photo"];
                    
                    NSMutableArray* flickrPhotos = [[NSMutableArray alloc] init];
                    
                    for (id photoObject in resultArray)
                    {
                        //Dictionary for a single image
                        NSDictionary* photoDictionary = [NSDictionary dictionaryWithDictionary:photoObject];
                        
                        FlickrPhoto* photo  = [[FlickrPhoto alloc] init];
                        photo.farm = [photoDictionary objectForKey:@"farm"];
                        photo.server = [photoDictionary objectForKey:@"server"];
                        photo.photoID = [photoDictionary objectForKey:@"id"];
                        photo.secret = [photoDictionary objectForKey:@"secret"];
                        
                        NSString* searchURL = [self URLForFlickrPhotoWithPhoto:photo andSize:@"s"];
                        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL] options:nil error:&error];
                        UIImage* image = [UIImage imageWithData:imageData];
                        
                        photo.thumbnail = image;
                        photo.largeImage = image;
                        
                        [flickrPhotos addObject:photo];
                        
                    }
                    
                    completion(string, flickrPhotos, nil);
                }
            }
            
        }
        
    });
}
@end

