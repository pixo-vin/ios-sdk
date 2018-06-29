## VIN Barcode Scanner SDK for iOS

### Overview

The VIN Barcode Scanner Software Development Kit for iOS is packaged as a Cocoa Touch Framework **OSXScanLib.framework**. The framework can be integrated in applications built with either Objective-C or Swift, and currently supports the following platforms: *i386, x86_64, armv7, arm64*

To enable barcode scanning in your application you will need to activate an SDK key. This key is tied to your application through its Bundle ID. The Bundle ID is the string, generally in a reverse-DNS format, which identifies your application uniquely in the iTunes app store. For example: *com.company-name.application-name*

Contact us at barcode@pixotech.com to initiate a free trial or commercial license and receive an SDK key.

---

### Getting Started

To add VIN Barcode scanning to your iOS application, follow these 4 simple steps:

1. Include **OSXScanLib.framework** from this repository in your application project
2. Create a UIViewController that extends from the **ScanViewController** defined in OSXScanLib
3. Implement the **setResult** API method to receive scanned VINs
4. Attach the root UIView from your new ScanViewController to the **videoview** outlet in your Storyboard

---

#### Include OSXScanLib.framework

 1. Clone or download this repository
 2. Copy <i class="icon-folder">OSXScanLib/</i> into your project directory.
 3. Add **OSXScanLib.framework** to your Xcode project:
  1. In the Xcode Navigator pane select your project
  2. Navigate to the **General** tab of project settings
  3. Find the **Embedded Binaries** section and click the <i class="icon-plus">**Add items**</i> button
  4. In the **Add items** dialog click the ***Add Other...*** button
  5. Navigate to the folder where you copied **OSXScanLib.framework**, select it and click ***Open***
  6. When prompted to choose options for adding the files you may continue with the defaults that are presented.
  7. **OSXScanLib.framework** should now appear in both the **Embedded Binaries** and **Linked Frameworks and Libraries** sections of the project settings. If it does not appear under **Linked Frameworks and Libraries** you will need to manually add it using the <i class="icon-plus">**Add items**</i> button.

#### Preparation for App Store uploads
For your convenience **OSXScanLib.framework** is built with architectures required to run your application on devices and the iOS Simulator. However, embedding this full binary in your application will cause errors during submission to the App Store.

To resolve this issue, you must run the **strip-frameworks.sh** script in **OSXScanLib/scripts/** during the Archive process. This process can be automated by adding a Run Script build phase to your project. To do this select your App target in the project settings pane. In the Build Phases tab click the plus sign at the top left and select ***New Run Script Phase***. Leave ***Shell*** set to '/bin/sh', then enter the following in the script contents:

```
if [ "${CONFIGURATION}" == "Release" ]; then
    ${PROJECT_DIR}/OSXScanLib/scripts/strip-frameworks.sh
fi
```

> ***Note:*** *The above assumes that you have copied the **OSXScanLib/** folder into the root folder of your Xcode project. If this is not the case, you will need to modify the path to strip-frameworks.sh*

####Create a UIViewController and implement **setResult**####

#### **Swift**
```
import UIKit
import OSXScanLib

class ViewController : ScanViewController {
    @objc func setResult(_ result: String) {
        // do something with the result
    }
}
```

#### **Objective-C**

```
#import <UIKit/UIKit.h>
#import <OSXScanLib/ScanViewController.h>

@interface ViewController : ScanViewController
@end

@implementation ViewController

- (void)setResult:(NSString *)result {
    // do something with the result
}

@end
```

#### Attach your root UIView to the **videoview** outlet

1. Open your Storyboard or XIB file
2. Select the ViewController that will be used for VIN scanning.
3. In the Identity Inspector enter the class you created above under **Custom Class**
4. In the Connections Inspector find **videoview** under Outlets
5. Drag the open circle to the right of **videoview** to the UIView in your View Controller Scene that will act as the video preview for barcode scanning

---

### ScanViewController API

#### **setResult** - ***required***

setResult is called on your ViewController when a value has been successfully read from a barcode.

```
// Objective-C
- (void)setResult:(NSString *)result;

// Swift
@objc func setResult(_ result: String)
```

> **result**: A string containing the value read from a barcode

#### **setSDKKey** - *deprecated*

```
// Objective-C
- (void)setSDKKey:(NSString *)key;

// Swift
func setSDKKey(key: String)
```

> **key**: A string containing your assigned SDK key

> ***Note:*** *In previous versions of the SDK a call to this method was required. In the latest version this method is deprecated; passing an SDK key to this method has no effect.*

#### **setSound**

Sets a sound file that will be played when a barcode has been scanned.

```
// Objective-C
- (void)setSound:(NSString *)soundPath ofType:(NSString *)type;

// Swift
func setSound(soundPath: String, ofType: String)
```

> **soundPath**: The Bundle path to the sound file including the file name, but not extension.
> **ofType**: The extension of the sound file (e.g.: "mp3")

#### **setLaserRenderer**

Overrides the object that renders the laser line in the user interface. Use this method to provide a custom rendering for the laser line

```
// Objective-C
- (void)setLaserRenderer:(id)renderer;

// Swift
func setLaserRenderer(renderer: AnyObject!)
```

> **renderer**: An instance of a class that implements the [CALayerDelegate](https://developer.apple.com/library/ios/documentation/QuartzCore/Reference/CALayerDelegate_protocol/) informal protocol. The *drawLayer:inContext:* method must be implemented to provide custom rendering.

#### **pauseScanning**

Stops the barcode scanning process.

```
// Objective-C
- (void)pauseScanning;

// Swift
func pauseScanning()
```

#### **resumeScanning**

Resumes scanning for barcodes after scanning has been stopped by calling ***pauseScanning***.

```
// Objective-C
- (void)resumeScanning;

// Swift
func resumeScanning()
```

#### **toggleTorch**

Turns the torch on/off if the device camera has a flash that may be used as a flashlight. **toggleTorch** may be referenced directly by a UIButton in your Storyboard or XIB.

```
// Objective-C
- (IBAction)toggleTorch;

// Swift
@IBAction func toggleTorch()
```

#### **hasTorch**

```
// Objective-C
- (BOOL)hasTorch;

// Swift
func hasTorch() -> Bool
```

> **returns**: *true* if the flash may be used as a flashlight, otherwise *false*
