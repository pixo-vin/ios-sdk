//
//  ScanViewController.h
//  OSXScanLib
//
//  Created by Ben Young on 2/22/12.
//  Copyright (c) 2012 Pixo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIView *videoview;

- (IBAction)toggleTorch;

- (BOOL)checkVIN:(NSString *)vin;
- (BOOL)hasAutoFocus;
- (BOOL)hasTorch;
- (void)pauseScanning;
- (void)resumeScanning;
- (void)setSound:(NSString *)soundPath ofType:(NSString *)type;
- (void)setSDKKey:(NSString *)key;

@end
