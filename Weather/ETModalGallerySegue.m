//
//  ETModalGallerySegue.m
//  Weather
//
//  Created by vcread on 13-11-25.
//  Copyright (c) 2013年 Inforgence. All rights reserved.
//

#import "ETModalGallerySegue.h"

@implementation ETModalGallerySegue
-(void)perform
{
    UIViewController* sourceViewController = [self sourceViewController];
    UIImagePickerController* imagePickerController = /*[[UIImagePickerController alloc]init];*/self.destinationViewController;
    
    NSAssert([imagePickerController isKindOfClass:[UIImagePickerController class]], nil);
    
    
    [sourceViewController
     presentViewController:imagePickerController animated:YES completion:^{
         NSLog(@"add view controller");
     }];
//    [sourceViewController presentModalViewController:imagePickerController animated:NO];

    
}
@end
