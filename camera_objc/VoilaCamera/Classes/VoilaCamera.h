//
//	VoilaCamera.h
//	VoilaCamera
//
//	Created by Luo Yu on 2019-04-10.
//	Email: indie.luo@gmail.com
//
//	The MIT License (MIT)
//
//	Copyright (c) 2019 骆昱(Luo Yu). All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of
//	this software and associated documentation files (the "Software"), to deal in
//	the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//	the Software, and to permit persons to whom the Software is furnished to do so,
//	subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LYCategory/LYCategory.h>
#import <PBJVision/PBJVision.h>


@interface VoilaCamera : NSObject

@end


/// Base View Class
@interface VCView : UIView
- (void)initial;
@end

/// Base Control Class
@interface VCControl : UIControl
- (void)initial;
@end

/// Base View Controller Class
@interface VCViewController : UIViewController
- (void)initial;
@end

typedef NS_ENUM(NSUInteger, VoilaCamDevice) {
	VoilaCamDeviceBack = 0,
	VoilaCamDeviceFront = 1,
};

typedef NS_ENUM(NSUInteger, VoilaCamMode) {
	VoilaCamModePhoto = 0,
	VoilaCamModeVideo = 1,
};

#import <VoilaCamera/VoilaCamView.h>
#import <VoilaCamera/VCButton.h>
#import <VoilaCamera/VoilaCamBaseControls.h>

#import <VoilaCamera/VoilaARCamView.h>

