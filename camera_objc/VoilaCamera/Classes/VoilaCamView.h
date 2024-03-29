//
//	VoilaCamView.h
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

#import <VoilaCamera/VoilaCamera.h>


@interface VoilaCamView : VCView

/**
 Start camera preview.
 */
- (void)previewStart;

/**
 Stop camera preview.
 */
- (void)previewStop;

/**
 Flash enable.
 */
@property (nonatomic, assign, getter=isFlashEnable) BOOL enableFlash;

/**
 Grid enable.
 */
@property (nonatomic, assign, getter=isGridEnable) BOOL enableGrid;

/**
 Current camera device.
 */
@property (nonatomic, assign) VoilaCamDevice device;

/**
 Flip camera device.
 */
- (void)flipCameraDevice;

/**
 Setup camera shot mode

 @param mode mode video or photo
 */
- (void)setupShotMode:(VoilaCamMode)mode;

/**
 Capture photo
 */
- (void)takeShot;

/**
 Did capure photo call back

 @param action callback
 */
- (void)didCapturePhoto:(void (^)(UIImage *image))action;

@end
