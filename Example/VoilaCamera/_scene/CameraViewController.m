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
#import <Masonry/Masonry.h>
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
		[self.view addSubview:view];
		preview = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
			make.left.right.equalTo(self.view);
			make.height.equalTo(view.mas_width);
		}];
	}
	
	{
		// MARK: CAMERA CONTROL PANEL
		CameraControls *view = [[CameraControls alloc] init];
		[self.view addSubview:view];
		controls = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self->preview.mas_bottom).offset(10);
			make.centerX.equalTo(self.view);
		}];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW.
	
	[preview setupShotMode:VoilaCamModePhoto];
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
