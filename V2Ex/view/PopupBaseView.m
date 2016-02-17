//
//  PopupBaseView.m
//  xmLife
//
//  Created by 胡立 on 14-9-12.
//  Copyright (c) 2014年 PaiTao. All rights reserved.
//

#import "PopupBaseView.h"
#import "NimbusCore.h"
#import "XWindowStack.h"

@implementation PopupBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.frame =
            CGRectMake(0, 0, CGRectGetWidth(self.window.frame), CGRectGetHeight(self.window.frame));
        self.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);
        [self.window addSubview:self];
        [XWindowStack pushWindow:self.window];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addEvent
{
    UIView *recognizerView = [[UIView alloc] initWithFrame:self.bounds];
    recognizerView.userInteractionEnabled = YES;
    [self addSubview:recognizerView];
    UITapGestureRecognizer *recognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    recognizer.numberOfTouchesRequired = 1;
    [recognizerView addGestureRecognizer:recognizer];
}

- (void)show
{
}

- (void)dismiss
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    [CATransaction setCompletionBlock:^{
        [self removeFromSuperview];
        [XWindowStack popWindow];
    }];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    [CATransaction commit];
}

@end
