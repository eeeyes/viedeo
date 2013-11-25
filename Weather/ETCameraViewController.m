//
//  ETCameraViewController.m
//  Weather
//
//  Created by vcread on 13-11-25.
//  Copyright (c) 2013年 Inforgence. All rights reserved.
//

#import "ETCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ETCameraViewController ()
@property (nonatomic,strong) AVCaptureSession* currentSesstion;
@end

@implementation ETCameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc]init];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.currentSesstion = [[AVCaptureSession alloc]init];
    [self.currentSesstion setSessionPreset:AVCaptureSessionPresetHigh];
    
    AVCaptureDevice* captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput* deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    NSAssert([_currentSesstion canAddInput:deviceInput],nil );
    
    [_currentSesstion addInput:deviceInput];
    
    
    AVCaptureVideoPreviewLayer* previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_currentSesstion];
   
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [[self.view layer]addSublayer:previewLayer];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for(CALayer* subLayer in [[self.view layer]sublayers])
        subLayer.frame = [[self.view layer]bounds];
    [_currentSesstion startRunning];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [_currentSesstion stopRunning];
}
@end
