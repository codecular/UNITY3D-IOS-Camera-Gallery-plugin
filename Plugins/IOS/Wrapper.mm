//
//  Wrapper.c
//
//  Created by Shantanu on 24/02/15.
//  Copyright (c) 2015 Shantanu. All rights reserved.
//

#import "LoadImage.h"
#import "CameraImage.h"

void OpenGallery(char *gObjName){
    OnUsingGallery *image=[OnUsingGallery alloc];
    [image OnUsingGallery:gObjName];
    
}
void OpenCamera(char *gObjName)
{
    OnUsingCamera *image=[OnUsingCamera alloc];
    [image OnUsingCamera:gObjName];
     NSLog(@"check point 2");
}

//Will be used by Unity to communicate with native code 
extern "C"{
void _OnUsingGallery(char *gObjCaller)
    {
        OpenGallery(gObjCaller);
    }
void _OnUsingCamera(char *gObjCaller)
    {
        OpenCamera(gObjCaller);
        NSLog(@"check point 1");
    }
}