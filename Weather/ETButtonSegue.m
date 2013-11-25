//
//  ETButtonSegue.m
//  Weather
//
//  Created by vcread on 13-11-25.
//  Copyright (c) 2013年 Inforgence. All rights reserved.
//

#import "ETButtonSegue.h"

@implementation ETButtonSegue

-(void)perform
{
    if([[self identifier] isEqualToString:@"front"]){
    [[self sourceViewController]addChildViewController:[self destinationViewController]];
    [((UIViewController*)[self sourceViewController]).view
     addSubview:((UIViewController*)[self destinationViewController]).view];
    }else {
        [((UIViewController*)[self sourceViewController]).view removeFromSuperview];
        [((UIViewController*)[self sourceViewController]) removeFromParentViewController];
    }
}
@end
