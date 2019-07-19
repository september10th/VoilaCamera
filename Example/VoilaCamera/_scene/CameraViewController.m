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


@interface CameraViewController () <PBJVisionDelegate> {
	
	__weak VoilaCamView *preview;
}
@end

@implementation CameraViewController

- (void)loadView {
	[super loadView];
	
	self.view.backgroundColor = [UIColor darkGrayColor];
	
	{
		VoilaCamView *view = [[VoilaCamView alloc] init];
		[self.view addSubview:view];
		preview = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(44);
			make.left.right.equalTo(self.view);
			make.height.equalTo(view.mas_width);
		}];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW.
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[preview previewStart];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	[preview previewStop];
}

// MARK: - DELEGATE

// MARK: PBJVisionDelegate



@end
