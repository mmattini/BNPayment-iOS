//
//  BNFormToolbar.m
//  Copyright (c) 2016 Bambora ( http://bambora.com/ )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import "BNFormToolbar.h"

@implementation BNFormToolbar

- (instancetype)init {
    self = [super init];
    [self sizeToFit];
    if (self) {
        [self setupFormToolbar];
    }
    
    return self;
}

- (void)setupFormToolbar {

    /*
    UIBarButtonItem* PrevButton = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:105
                                                                                 target:self
                                                                                 action:nil];
    PrevButton.enabled = NO;
    
    UIBarButtonItem*  NextButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:106
                                                                                 target:self
                                                                                 action:nil];
     */
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    
    UIBarButtonItem* flexSpace = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self setItems:@[flexSpace,doneButton] animated:YES];
}

- (void)doneClicked:(id)sender {
    if (_doneBlock) {
        _doneBlock();
    }
}

@end
