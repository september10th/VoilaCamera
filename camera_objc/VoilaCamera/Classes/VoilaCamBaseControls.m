//
//	VoilaCamBaseControls.m
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

#import "VoilaCamBaseControls.h"
#import <LYCategory/LYCategory.h>


@interface VoilaCamBaseControls () {
	
	LYCBoolean actionFlip;
	LYCBoolean actionFlash;
	LYCBoolean actionGrid;
}
@end

@implementation VoilaCamBaseControls

// MARK: - ACTION

- (void)flipButtonPressed:(id)sender {
	_flip.selected = !_flip.isSelected;
	
	if (actionFlip != nil) {
		actionFlip(_flip.isSelected);
	} else {
		NSLog(@"BLOCK NOT FOUND");
	}
}

- (void)flashButtonPressed:(id)sender {
	_flash.selected = !_flash.isSelected;
	
	if (actionFlash != nil) {
		actionFlash(_flash.isSelected);
	} else {
		NSLog(@"BLOCK NOT FOUND");
	}
}

- (void)gridButtonPressed:(id)sender {
	_grid.selected = !_grid.isSelected;
	
	if (actionGrid != nil) {
		actionGrid(_grid.isSelected);
	} else {
		NSLog(@"BLOCK NOT FOUND");
	}
}

// MARK: - INIT

- (void)initial {
	[super initial];
	
	{
		// MARK: FLIP BUTTON
		VCButton *view = [[VCButton alloc] init];
		[self addSubview:view];
		_flip = view;
		
		[view addTarget:self action:@selector(flipButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	{
		// MARK: FLASH BUTTON
		VCButton *view = [[VCButton alloc] init];
		[self addSubview:view];
		_flash = view;
		
		[view addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	{
		// MARK: GRID BUTTON
		VCButton *view = [[VCButton alloc] init];
		[self addSubview:view];
		_grid = view;
		
		[view addTarget:self action:@selector(gridButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)flipButtonAction:(void (^)(BOOL))action {
	actionFlip = action;
}

- (void)flashButtonAction:(void (^)(BOOL))action {
	actionFlash = action;
}

- (void)gridButtonAction:(void (^)(BOOL))action {
	actionGrid = action;
}

@end

// MARK: - VCButton
@interface VCButton () {}
@end

@implementation VCButton

- (void)initial {
	[super initial];
	
	{
		// MARK: ICON VIEW
		UIImageView *view = [[UIImageView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:view];
		_icon = view;
		
        [view.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [view.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [view.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
	}
	
	{
		// MARK: ICON VIEW FOR STATE SELECTED
		UIImageView *view = [[UIImageView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = NO;
		view.hidden = YES;
		[self addSubview:view];
		_iconSel = view;
		
        [view.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [view.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [view.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
	}
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	
	_icon.hidden = selected;
	_iconSel.hidden = !selected;
}

@end
