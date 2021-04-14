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
#import <Masonry/Masonry.h>


@interface VoilaCamBaseControls () {
}
@end

@implementation VoilaCamBaseControls

- (void)initial {
	[super initial];
	
	{
		// MARK: FLIP BUTTON
		VCButton *view = [[VCButton alloc] init];
		[self addSubview:view];
		_flip = view;
	}
	
	{
		// MARK: FLASH BUTTON
		VCButton *view = [[VCButton alloc] init];
		[self addSubview:view];
		_flash = view;
	}
	
	{
		// MARK: GRID BUTTON
		VCButton *view = [[VCButton alloc] init];
		[self addSubview:view];
		_grid = view;
	}
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
		[self addSubview:view];
		_icon = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self);
		}];
	}
	
	{
		// MARK: ICON VIEW FOR STATE SELECTED
		UIImageView *view = [[UIImageView alloc] init];
		view.hidden = YES;
		[self addSubview:view];
		_iconSel = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self);
		}];
	}
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	
	_icon.hidden = selected;
	_iconSel.hidden = !selected;
}

@end
