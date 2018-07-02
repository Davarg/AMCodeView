//
//  AMCodeViewResponder.m
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import "AMCodeViewResponder.h"

@interface AMCodeViewResponder ()

@property (strong, nonatomic) NSString *code;
@property (assign, nonatomic) NSInteger lastCursorIndex;
@property (strong, nonatomic) id<AMCodeViewResponsible> view;
@property (strong, nonatomic) id<AMCodeViewConfigurable> config;

@end

@implementation AMCodeViewResponder

#pragma mark - Life Cycle

- (instancetype)initWithConfig:(id<AMCodeViewConfigurable>)config
               viewResponsible:(id<AMCodeViewResponsible>)view {
    self = [super init];
    
    self.config = config;
    self.view = view;
    self.code = @"";
    self.view.textField.delegate = self;
    
    [self.view.textField addTarget:self
                            action:@selector(onAllEditingEvents:)
                  forControlEvents:UIControlEventAllEditingEvents];
    
    return self;
}

- (void)dealloc {
    [self.view.textField removeTarget:self
                               action:@selector(onAllEditingEvents:)
                     forControlEvents:UIControlEventAllEditingEvents];
}

#pragma mark - UITextField Notifications

- (void)onAllEditingEvents:(UITextField *)textField {
    if ([self isStringEmpty:self.code] == NO
        && [self isStringEmpty:textField.text] == YES) {
        self.code = @"";
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result = YES;
    BOOL isStringEmpty = [self isStringEmpty:string];
    
    if (self.code.length < self.config.maxCodeLength
        || isStringEmpty == YES) {
        NSMutableString *mString = [[NSMutableString alloc] initWithString:self.code];
        [mString replaceCharactersInRange:range withString:string];
        
        self.code = mString;
        
        if (isStringEmpty == NO) {
            self.lastCursorIndex = self.code.length > 0 ? self.code.length - 1 : 0;
            
            if (self.code.length <= self.config.maxCodeLength) {
                [self.view.digitLabels objectAtIndex:self.lastCursorIndex].text = string;
            }
        } else {
            self.lastCursorIndex = self.code.length;
            
            [self.view.digitLabels objectAtIndex:self.lastCursorIndex].text = @"";
        }
    }
    
    if (self.code.length == self.config.maxCodeLength) {
        [textField resignFirstResponder];
    }
    
    if (isStringEmpty == NO
        && self.code.length > 0) {
        [self.view moveCursorForward];
    } else {
        [self.view moveCursorBackward];
    }
    
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(codeChanged:)] == YES) {
            [self.delegate codeChanged:self.code];
        }
    }
    
    return result;
}

#pragma mark -

- (BOOL)isStringEmpty:(NSString *)testString {
    if ((NSNull*)testString == [NSNull null] ) {
        return YES;
    }
    
    if ([testString isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    
    if (testString == nil) {
        return YES;
    } else if ([testString length] == 0) {
        return YES;
    } else {
        testString = [testString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([testString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
