#import "LoadImage.h"
#import "ResizeImage.h"
#import "UnityView.h"
#import "UnityViewControllerBase.h"
#import <CoreGraphics/CoreGraphics.h>



@implementation OnUsingGallery
extern UIViewController *UnityGetGLViewController();
char *gameObjectName;
-(void) OnUsingGallery:(char *)gObjName
{
    NSLog(@"Gallery");
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    // *gameObjectName=*gObjName;
    
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [UnityGetGLViewController() presentViewController:imagePicker animated:YES completion: NULL ];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage=[info valueForKeyPath:UIImagePickerControllerOriginalImage];
    //    NSURL *filePath=[info valueForKey:UIImagePickerControllerReferenceURL];
    //    NSLog(@"Image picked %@",filePath);
    CGSize newSize=CGSizeMake(320.0f,320.0f);
    newSize=[self reformedResolution:selectedImage];
    //selectedImage=imageWithImage(selectedImage,newSize);
    //NSData *pngData = UIImagePNGRepresentation(selectedImage);
    //CGFloat someFloat=0.5;
    
    selectedImage=[ResizeImage imageWithImage:selectedImage scaledToSize:newSize];
    NSData *pngData= UIImagePNGRepresentation(selectedImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
    // NSString *path=[filePath path];
    const char *str=[filePath UTF8String];
    NSLog(@"from xcode %@",filePath);
    NSString *imageWidth = [NSString stringWithFormat:@"%f", selectedImage.size.width];
    NSString *imageHeight=[NSString stringWithFormat:@"%f", selectedImage.size.height];
    NSString *imageRes=[imageWidth stringByAppendingString:@"|"];
    imageRes=[imageRes stringByAppendingString:imageHeight];
    const char *reformedRes=[imageRes UTF8String];
    NSString *newPathData=[NSString stringWithFormat:@"%@*0*1",filePath];
    UnitySendMessage("Gallery", "OnCameraPick", [newPathData UTF8String]);
    //UnitySendMessage("CameraAndGallery","GetReformedResolution",reformedRes);
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
        origWidth=1024;
    }
    else if(origHeight>origWidth) //Potrait
    {
        origWidth=(origWidth/origHeight)*1024;
        origHeight=1024;
    }
    else if(origWidth==origHeight)
    {
        origHeight=origWidth=1024;
    }
    reformedSize=CGSizeMake(origWidth,origHeight);
    return reformedSize;
}

@end
