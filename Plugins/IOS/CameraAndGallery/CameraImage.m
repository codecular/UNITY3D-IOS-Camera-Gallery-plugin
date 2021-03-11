#import "CameraImage.h"

#import "UnityView.h"
#import "UnityViewControllerBase.h"

#import "ResizeImage.h"


@implementation OnUsingCamera
extern UIViewController *UnityGetGLViewController();
char *gameObjectName;
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage=[info valueForKeyPath:UIImagePickerControllerOriginalImage];
    //    NSURL *filePath=[info valueForKey:UIImagePickerControllerReferenceURL];
        NSLog(@"Image picked 555555");
  
   CGSize newSize=[self reformedResolution:selectedImage];
   
    
    selectedImage=[ResizeImage imageWithImage:selectedImage scaledToSize:newSize];
    NSData *pngData= UIImagePNGRepresentation(selectedImage);

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
    // NSString *path=[filePath path];
    const char *str=[filePath UTF8String];
    NSString *imageWidth = [NSString stringWithFormat:@"%f", selectedImage.size.width];
    NSString *imageHeight=[NSString stringWithFormat:@"%f", selectedImage.size.height];
    NSString *imageRes=[imageWidth stringByAppendingString:@"|"];
    imageRes=[imageRes stringByAppendingString:imageHeight];
    NSLog(@"from xcode %@",filePath);
    const char *reformedRes=[imageRes UTF8String];
   
   // UnitySendMessage("CameraAndGallery", "OnRecievedCameraImage",str);
    NSString *newPathData=[NSString stringWithFormat:@"%@*0*1",filePath];
    
    UnitySendMessage("Gallery", "OnCameraPick",[newPathData UTF8String] );
   //  UnitySendMessage("CameraAndGallery","GetReformedResolution",reformedRes);
    
    [picker dismissModalViewControllerAnimated:YES];
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSString *newPathData=@"fail*0*0";
    UnitySendMessage("Gallery", "OnCameraPick", [newPathData UTF8String]);
    [picker dismissModalViewControllerAnimated:YES];
}
-(CGSize)reformedResolution:(UIImage*)originalImage
{
    CGFloat origWidth=originalImage.size.width;
    CGFloat origHeight=originalImage.size.height;
    CGSize reformedSize=CGSizeMake(1024,1024);
    if(origWidth>origHeight) //Landscape
    {
        origHeight=(origHeight/origWidth)*1024;
        origWidth=1024.0;
    }
    else if(origHeight>origWidth) //Potrait
    {
        origWidth=(origWidth/origHeight)*1024.0;
        origHeight=1024.0;
    }
    else if(origWidth==origHeight)
    {
        origHeight=origWidth=1024.0;
    }
    reformedSize=CGSizeMake(origWidth,origHeight);
    return reformedSize;
}
-(void) OnUsingCamera:(char *)gObjName
{
    NSLog(@"Camera");
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    // *gameObjectName=*gObjName;
    
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    NSLog(@"Camera image");
    [UnityGetGLViewController() presentViewController:imagePicker animated:YES completion: NULL ];
    
}
@end
