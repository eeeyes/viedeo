//
//  ETCameraViewController.m
//  Weather
//
//  Created by vcread on 13-11-25.
//  Copyright (c) 2013年 Inforgence. All rights reserved.
//

#import "ETCameraViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface ETCameraViewController ()
@property (nonatomic,strong) AVCaptureSession* currentSesstion;
@property (nonatomic,strong) AVCaptureMovieFileOutput* movieFileOutput;
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
    
    _movieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
    
    NSAssert([_currentSesstion canAddInput:deviceInput],nil );
    NSAssert([_currentSesstion canAddOutput:_movieFileOutput], nil);
    
    [_currentSesstion addInput:deviceInput];
    [_currentSesstion addOutput:_movieFileOutput];
    
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
   
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    filePath = [filePath stringByAppendingPathComponent:@"temp.mov"];

    NSURL* fileURL = [[NSURL alloc]initFileURLWithPath:filePath isDirectory:NO];
    [[NSFileManager defaultManager]removeItemAtURL:fileURL error:nil];
    [_movieFileOutput startRecordingToOutputFileURL:fileURL recordingDelegate:self];
    return;
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    NSLog(@"start");
}
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    NSLog(@"finish");
    if(error)
        return;
    ALAssetsLibrary* lib = [[ALAssetsLibrary alloc]init];
    [lib writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        [_currentSesstion stopRunning];
        
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{

    [_movieFileOutput stopRecording];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
