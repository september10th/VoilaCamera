//
//  CameraViewController.m
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

#import "CameraViewController.h"
#import "CameraControls.h"


@interface CameraViewController () {
	
	__weak VoilaCamView *preview;
	__weak CameraControls *controls;
}
@end

@implementation CameraViewController

- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor darkGrayColor];
	
	{
		// MARK: CAMERA PLAYBACK VIEW
		VoilaCamView *view = [[VoilaCamView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:view];
		preview = view;
		
        [view.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:44].active = YES;
        [view.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
        [view.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
        [view.heightAnchor constraintEqualToAnchor:view.widthAnchor].active = YES;
	}
	
	{
		// MARK: CAMERA CONTROL PANEL
		CameraControls *view = [[CameraControls alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:view];
		controls = view;
        
        [view.topAnchor constraintEqualToAnchor:preview.bottomAnchor constant:10].active = YES;
        [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
        [view.widthAnchor constraintEqualToConstant:200].active = YES;
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW.
	
	[preview setupShotMode:VoilaCamModePhoto];
	
	[controls flipButtonAction:^(BOOL front) {
		[self->preview flipCameraDevice];
	}];
	
	[controls flashButtonAction:^(BOOL flashOn) {
		[self->preview setEnableFlash:flashOn];
	}];
	
	[controls gridButtonAction:^(BOOL gridOn) {
		[self->preview setEnableGrid:gridOn];
	}];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[preview previewStart];
	
	[preview performSelector:@selector(takeShot) withObject:nil afterDelay:5];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	[preview previewStop];
}

// MARK: - DELEGATE

// MARK: 



@end
