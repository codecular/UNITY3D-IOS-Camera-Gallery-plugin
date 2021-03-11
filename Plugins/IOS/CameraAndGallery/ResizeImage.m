//
//  ResizeImage.m
//  
//
//  Created by Shantanu on 09/06/15.
//
//

#import <Foundation/Foundation.h>
#import "ResizeImage.h"
#import <CoreGraphics/CoreGraphics.h>
@implementation ResizeImage
+(UIImage*)imageWithImage:(UIImage*)image
scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end