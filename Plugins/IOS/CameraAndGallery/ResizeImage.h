//
//  ResizeImage.h
//  
//
//  Created by Shantanu on 09/06/15.
//
//
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
@interface ResizeImage : NSObject
+(UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
@end
