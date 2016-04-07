//
//  BNFormToolbar.m
//  Pods
//
//  Created by Bambora On Mobile AB on 15/01/2016.
//
//

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
