//
//  AMTextFieldWithoutMenu.m
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import "AMTextFieldWithoutMenu.h"

@implementation AMTextFieldWithoutMenu

#pragma mark - UITextInput

- (UITextPosition *)closestPositionToPoint:(CGPoint)point {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *end = [self positionFromPosition:beginning offset:self.text.length];
    
    return end;
}

#pragma mark - UIResponder

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

#pragma mark - UIViewGestureRecognizers

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] == YES) {
        return NO;
    }
    
    return YES;
}

@end
