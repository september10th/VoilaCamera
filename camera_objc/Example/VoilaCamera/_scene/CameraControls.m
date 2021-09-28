//
//	CameraControls.m
//	VoilaCamera
//
//	Created by Luo Yu on 2021-04-14.
//	Email: indie.luo@gmail.com
//
//	The MIT License (MIT)
//
//	Copyright (c) 2021 骆昱(Luo Yu). All rights reserved.
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

#import "CameraControls.h"


@implementation CameraControls

- (void)initial {
	[super initial];
	
	self.flip.icon.image = [UIImage imageNamed:@"btn-flip"];
	self.flip.iconSel.image = [UIImage imageNamed:@"btn-flip-sel"];
	self.flash.icon.image = [UIImage imageNamed:@"btn-flash"];
	self.flash.iconSel.image = [UIImage imageNamed:@"btn-flash-sel"];
	self.grid.icon.image = [UIImage imageNamed:@"btn-grid"];
	self.grid.iconSel.image = [UIImage imageNamed:@"btn-grid-sel"];
	
    [self.flip.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.flip.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.flip.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.flip.widthAnchor constraintEqualToConstant:44].active = YES;
    [self.flip.heightAnchor constraintEqualToConstant:44].active = YES;
    
    [self.flash.widthAnchor constraintEqualToAnchor:self.flip.widthAnchor].active = YES;
    [self.flash.topAnchor constraintEqualToAnchor:self.flip.topAnchor].active = YES;
    [self.flash.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.flash.leadingAnchor constraintEqualToAnchor:self.flip.trailingAnchor].active = YES;
    
    [self.grid.widthAnchor constraintEqualToAnchor:self.flip.widthAnchor].active = YES;
    [self.grid.topAnchor constraintEqualToAnchor:self.flip.topAnchor].active = YES;
    [self.grid.bottomAnchor constraintEqualToAnchor:self.flip.bottomAnchor].active = YES;
    [self.grid.leadingAnchor constraintEqualToAnchor:self.flash.trailingAnchor].active = YES;
    [self.grid.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
}

@end
