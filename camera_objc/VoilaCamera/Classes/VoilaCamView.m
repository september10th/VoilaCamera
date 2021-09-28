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
		[self addSubview:view];
		vCamera = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self);
		}];
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
		view.hidden = YES;
		[self addSubview:view];
		vGrid = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self);
		}];
		
		{
			// GRID VIEWS
			NSMutableArray<UIView *> *spaces = [NSMutableArray arrayWithCapacity:1];
			for (NSInteger i = 0; i < 6; i++) {
				UIView *space = [[UIView alloc] init];
				space.backgroundColor = [UIColor clearColor];
				space.userInteractionEnabled = NO;
				space.hidden = YES;
				[spaces addObject:space];
				[vGrid addSubview:space];
			}
			
			[spaces[0] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.left.equalTo(view);
				make.top.bottom.equalTo(view);
			}];
			[spaces[1] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.leading.equalTo(spaces[0].mas_trailing).offset(1);
				make.width.equalTo(spaces[0]);
				make.top.bottom.equalTo(view);
			}];
			[spaces[2] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.leading.equalTo(spaces[1].mas_trailing).offset(1);
				make.width.equalTo(spaces[0]);
				make.top.bottom.equalTo(view);
				make.right.equalTo(view);
			}];
			[spaces[3] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(view);
				make.left.right.equalTo(view);
			}];
			[spaces[4] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(spaces[3].mas_bottom).offset(1);
				make.height.equalTo(spaces[3]);
				make.left.right.equalTo(view);
			}];
			[spaces[5] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(spaces[4].mas_bottom).offset(1);
				make.height.equalTo(spaces[3]);
				make.left.right.equalTo(view);
				make.bottom.equalTo(view);
			}];
			
			// GRID LINES
			UIView *line[4];
			for (NSInteger i = 0; i < 4; i++) {
				line[i] = [[UIView alloc] init];
				line[i].userInteractionEnabled = NO;
				line[i].frame = (CGRect){0, 0, 1, 1};
				line[i].backgroundColor = [UIColor whiteColor];
				line[i].alpha = (1 - GOLDEN_RATIO) * 0.5;
				[vGrid addSubview:line[i]];
			}
			
			[line[0] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.width.mas_equalTo(1);
				make.top.bottom.equalTo(view);
				make.leading.equalTo(spaces[0].mas_trailing);
			}];
			[line[1] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.width.mas_equalTo(1);
				make.top.bottom.equalTo(view);
				make.leading.equalTo(spaces[1].mas_trailing);
			}];
			[line[2] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.height.mas_equalTo(1);
				make.left.right.equalTo(view);
				make.top.equalTo(spaces[3].mas_bottom);
			}];
			[line[3] mas_makeConstraints:^(MASConstraintMaker *make) {
				make.height.mas_equalTo(1);
				make.left.right.equalTo(view);
				make.top.equalTo(spaces[4].mas_bottom);
			}];
		}
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
