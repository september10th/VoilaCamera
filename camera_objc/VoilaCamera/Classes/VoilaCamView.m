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
#import <PBJVision/PBJVision.h>


typedef void(^VoilaCamBlockImage)(UIImage *image);

@interface VoilaCamView () <PBJVisionDelegate> {
	__weak UIView *vCamera;
	
	__strong AVCaptureVideoPreviewLayer *preview;
	__strong PBJVision *vision;
	
	__weak UIView *vGrid;
	
	__strong VoilaCamBlockImage blockPhoto;
}
@end

@implementation VoilaCamView

// MARK: - INIT

- (void)initial {
	[super initial];
	
	{
		// MARK: VIEW FOR CAMERA PLAYBACK
		UIView *view = [[UIView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:view];
		vCamera = view;
		
        [view.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [view.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [view.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
	}
	
	{
		// MARK: PBJVision INSTANCE
		vision = [PBJVision sharedInstance];
		vision.delegate = self;
		vision.cameraMode = PBJCameraModeVideo;
		vision.cameraOrientation = PBJCameraOrientationPortrait;
		vision.focusMode = PBJFocusModeContinuousAutoFocus;
		vision.outputFormat = PBJOutputFormatStandard;
	}
	
	{
		// MARK: PBJVision LAYER
		preview = [[PBJVision sharedInstance] previewLayer];
		preview.frame = vCamera.bounds;
		preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
		[vCamera.layer addSublayer:preview];
	}
	
	{
		// MARK: GRID VIEW
		UIView *view = [[UIView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
		view.hidden = YES;
		[self addSubview:view];
		vGrid = view;
		
        [view.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [view.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [view.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        
        {
            // GRID VIEWS
            
            // LAYOUT GUIDES
            UILayoutGuide *spaces[6];
            for (NSInteger i = 0; i < 6; i++) {
                spaces[i] = [[UILayoutGuide alloc] init];
                [view addLayoutGuide:spaces[i]];
            }
            
            {
                // HORIZONTAL SPACING
                
                for (NSUInteger i = 0; i < 3; i++) {
                    [spaces[i].topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
                    [spaces[i].bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
                }
                
                [spaces[0].leftAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
                [spaces[1].leadingAnchor constraintEqualToAnchor:spaces[0].trailingAnchor constant:0].active = YES;
                [spaces[2].leadingAnchor constraintEqualToAnchor:spaces[1].trailingAnchor constant:0].active = YES;
                [spaces[2].rightAnchor constraintEqualToAnchor:view.rightAnchor].active = YES;
                
                [spaces[0].widthAnchor constraintEqualToAnchor:spaces[1].widthAnchor].active = YES;
                [spaces[1].widthAnchor constraintEqualToAnchor:spaces[2].widthAnchor].active = YES;
                
            }
            
            {
                // VERTICAL SPACING
                
                for (NSUInteger i = 3; i < 6; i++) {
                    [spaces[i].leftAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
                    [spaces[i].rightAnchor constraintEqualToAnchor:view.rightAnchor].active = YES;
                    
                    if (i > 3) {
                        [spaces[i].heightAnchor constraintEqualToAnchor:spaces[i - 1].heightAnchor].active = YES;
                    }
                }
                
                [spaces[3].topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
                [spaces[4].topAnchor constraintEqualToAnchor:spaces[3].bottomAnchor constant:1].active = YES;
                [spaces[5].topAnchor constraintEqualToAnchor:spaces[4].bottomAnchor constant:1].active = YES;
                [spaces[5].bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
            }

			// GRID LINES
			UIView *line[4];
			for (NSInteger i = 0; i < 4; i++) {
				line[i] = [[UIView alloc] init];
                line[i].translatesAutoresizingMaskIntoConstraints = NO;
				line[i].userInteractionEnabled = NO;
				line[i].frame = (CGRect){0, 0, 1, 1};
				line[i].backgroundColor = [UIColor whiteColor];
				line[i].alpha = (1 - GOLDEN_RATIO) * 0.5;
				[vGrid addSubview:line[i]];
			}
			
            [line[0].widthAnchor constraintEqualToConstant:1].active = YES;
            [line[0].topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
            [line[0].bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
            [line[0].leadingAnchor constraintEqualToAnchor:spaces[0].trailingAnchor].active = YES;

            [line[1].widthAnchor constraintEqualToConstant:1].active = YES;
            [line[1].topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
            [line[1].bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
            [line[1].leadingAnchor constraintEqualToAnchor:spaces[1].trailingAnchor].active = YES;

            [line[2].heightAnchor constraintEqualToConstant:1].active = YES;
            [line[2].leftAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
            [line[2].rightAnchor constraintEqualToAnchor:view.rightAnchor].active = YES;
            [line[2].topAnchor constraintEqualToAnchor:spaces[3].bottomAnchor].active = YES;

            [line[3].heightAnchor constraintEqualToConstant:1].active = YES;
            [line[3].leftAnchor constraintEqualToAnchor:view.leftAnchor].active = YES;
            [line[3].rightAnchor constraintEqualToAnchor:view.rightAnchor].active = YES;
            [line[3].topAnchor constraintEqualToAnchor:spaces[4].bottomAnchor].active = YES;
		}
        
        [self bringSubviewToFront:view];
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

- (void)setupShotMode:(VoilaCamMode)mode {
	switch (mode) {
		default:
		case VoilaCamModePhoto: {
			vision.cameraMode = PBJCameraModePhoto;
		} break;
		case VoilaCamModeVideo: {
			vision.cameraMode = PBJCameraModeVideo;
		} break;
	}
}

- (void)takeShot {
	[vision capturePhoto];
}

// MARK: PROPERTY

- (void)setDevice:(VoilaCamDevice)device {
	_device = device;
	
	vision.cameraDevice = _device == VoilaCamDeviceBack ? PBJCameraDeviceBack : PBJCameraDeviceFront;
}

- (void)setEnableGrid:(BOOL)enableGrid {
	_enableGrid = enableGrid;
	
	vGrid.hidden = !_enableGrid;
}

- (void)didCapturePhoto:(void (^)(UIImage *))action {
	blockPhoto = action;
}

// MARK: - DELEGATE

// MARK: PBJVisionDelegate

// MARK: PHOTO RELATED

- (void)visionWillCapturePhoto:(PBJVision *)vision {}

- (void)visionDidCapturePhoto:(PBJVision *)vision {}

- (void)vision:(PBJVision *)vision capturedPhoto:(NSDictionary *)photoDict error:(NSError *)error {
	
	if (blockPhoto != nil) {
		dispatch_async(dispatch_get_main_queue(), ^{
			/*
			 PBJVisionPhotoImageKey
			 PBJVisionPhotoJPEGKey
			 PBJVisionPhotoMetadataKey
			 PBJVisionPhotoThumbnailKey
			 */
			self->blockPhoto(photoDict[PBJVisionPhotoImageKey]);
		});
	}
}

@end
