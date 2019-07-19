//
//	VoilaCamView.m
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

#import "VoilaCamView.h"
#import <LYCategory/LYCategory.h>
#import <Masonry/Masonry.h>


@interface VoilaCamView () <PBJVisionDelegate> {
	__weak UIView *vCamera;
	
	AVCaptureVideoPreviewLayer *preview;
	PBJVision *vision;
}
@end

@implementation VoilaCamView

// MARK: - INIT

- (void)initial {
	[super initial];
	
	{
		// MARK: CAMERA PLAYBACK
		UIView *view = [[UIView alloc] init];
		[self addSubview:view];
		vCamera = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self);
		}];
	}
	
	{
		preview = [[PBJVision sharedInstance] previewLayer];
		preview.frame = vCamera.bounds;
		preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
		[vCamera.layer addSublayer:preview];
	}
	
	{
		vision = [PBJVision sharedInstance];
		vision.delegate = self;
		vision.cameraMode = PBJCameraModeVideo;
		vision.cameraOrientation = PBJCameraOrientationPortrait;
		vision.focusMode = PBJFocusModeContinuousAutoFocus;
		vision.outputFormat = PBJOutputFormatStandard;
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	preview.frame = vCamera.bounds;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	
	vCamera.frame = (CGRect){CGPointZero, frame.size};
	preview.frame = (CGRect){CGPointZero, frame.size};
}

// MARK: - METHOD

- (void)previewStart {
	[vision startPreview];
}

- (void)previewStop {
	[vision stopPreview];
}

- (void)flipCameraDevice {
	[self setDevice:_device == VoilaCamDeviceBack ? VoilaCamDeviceFront : VoilaCamDeviceBack];
}

// MARK: PROPERTY

- (void)setDevice:(VoilaCamDevice)device {
	_device = device;
	
	vision.cameraDevice = _device == VoilaCamDeviceBack ? PBJCameraDeviceBack : PBJCameraDeviceFront;
}

// MARK: - DELEGATE

// MARK: PBJVisionDelegate

@end
