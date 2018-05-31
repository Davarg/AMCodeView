//
//  AMCodeView.m
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//
#import <Masonry/Masonry.h>

#import "AMCodeView.h"

@interface AMCodeView ()

@property (strong, nonatomic) id<AMCodeViewConfigurable> configuration;

@property (strong, nonatomic) UIView *digitsContainerView;
@property (strong, nonatomic) UIView *underlineCursorView;
@property (strong, nonatomic) UIView *underlineContainerView;

@end

@implementation AMCodeView

@synthesize digitLabels = _digitLabels;

#pragma mark - Life Cycle

- (void)configure:(id<AMCodeViewConfigurable>)configuration {
    if ([configuration conformsToProtocol:@protocol(AMCodeViewConfigurable)] == YES) {
        self.configuration = configuration;
        
        [self createViews];
        [self createConstraints];
    }
}

- (void)createViews {
    /**
     * Field
     */
    self.fieldContainerView = [[UIView alloc] init];
    self.fieldContainerView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.fieldContainerView];
    
    /**
     * Digits
     */
    self.digitsContainerView = [[UIView alloc] init];
    self.digitsContainerView.backgroundColor = [UIColor clearColor];
    [self.fieldContainerView addSubview:self.digitsContainerView];
    
    NSMutableArray *digits = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < self.configuration.maxCodeLength; index++) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.configuration.digitColor;
        label.font = self.configuration.digitFont;
        
        [digits addObject:label];
        [self.digitsContainerView addSubview:label];
    }
    self.digitLabels = [[NSArray alloc] initWithArray:digits];
    
    /**
     * Textfield
     */
    self.textField = [[AMTextFieldWithoutMenu alloc] init];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.font = self.configuration.digitFont;
    self.textField.textColor = [UIColor clearColor];
    self.textField.tintColor = [UIColor clearColor];
    [self.fieldContainerView addSubview:self.textField];
    
    /**
     * Underline
     */
    self.underlineContainerView = [[UIView alloc] init];
    self.underlineContainerView.backgroundColor = self.configuration.underlineContainerColor;
    self.underlineContainerView.clipsToBounds = YES;
    [self.fieldContainerView addSubview:self.underlineContainerView];
    
    self.underlineCursorView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                        self.configuration.isUnderlineFilled ? -self.configuration.underlineCursorWidth : 0
                                                                        , 0
                                                                        , self.configuration.underlineCursorWidth
                                                                        , self.configuration.underlineCursorHeight
                                                                        )];
    self.underlineCursorView.backgroundColor = self.configuration.underlineCursorColor;
    [self.underlineContainerView addSubview:self.underlineCursorView];
}

- (void)createConstraints {
    /**
     * Field
     */
    [self.fieldContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(@0);
    }];
    
    /**
     * Digits
     */
    [self.digitsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(@0);
        make.height.equalTo(@(self.configuration.height));
        make.width.equalTo(@(self.configuration.underlineCursorWidth * self.configuration.maxCodeLength));
    }];
    
    for (NSInteger index = 0; index < self.digitLabels.count; index++) {
        UILabel *label = [self.digitLabels objectAtIndex:index];
        if (index == 0) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.bottom.equalTo(@0);
                make.width.equalTo(@(self.configuration.underlineCursorWidth));
            }];
        } else if (index == self.digitLabels.count - 1) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.top.bottom.equalTo(@0);
                make.leading.equalTo([self.digitLabels objectAtIndex:index - 1].mas_trailing);
                make.width.equalTo(@(self.configuration.underlineCursorWidth));
            }];
        } else {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(@0);
                make.leading.equalTo([self.digitLabels objectAtIndex:index - 1].mas_trailing);
                make.width.equalTo(@(self.configuration.underlineCursorWidth));
            }];
        }
    }
    
    /**
     * Textfield
     */
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.digitsContainerView.mas_top);
        make.centerX.equalTo(self.digitsContainerView.mas_centerX);
        make.width.equalTo(self.digitsContainerView.mas_width);
        make.height.equalTo(self.digitsContainerView.mas_height);
    }];
    
    /**
     * Underline
     */
    [self.underlineContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.digitsContainerView.mas_leading);
        make.top.equalTo(self.digitsContainerView.mas_bottom);
        make.height.equalTo(@(self.configuration.underlineCursorHeight));
        make.width.equalTo(@(self.configuration.underlineCursorWidth * self.configuration.maxCodeLength));
    }];
}

#pragma mark - CodeViewResponsible

- (void)moveCursorToStart {
    if (self.configuration.isUnderlineFilled == YES) {
        [UIView animateWithDuration:self.configuration.animDuration
                         animations:^{
                             self.underlineCursorView.frame = CGRectMake(
                                                                         -self.configuration.underlineCursorWidth
                                                                         , 0
                                                                         , self.configuration.underlineCursorWidth
                                                                         , self.configuration.underlineCursorHeight
                                                                         );
                         }];
    } else {
        [UIView animateWithDuration:self.configuration.animDuration
                         animations:^{
                             self.underlineCursorView.frame = CGRectMake(
                                                                         0
                                                                         , self.underlineCursorView.frame.origin.y
                                                                         , self.underlineCursorView.frame.size.width
                                                                         , self.underlineCursorView.frame.size.height
                                                                         );
                         }];
    }
}

- (void)moveCursorForward {
    if (self.configuration.isUnderlineFilled == YES) {
        if ((self.underlineCursorView.frame.size.width + self.configuration.underlineCursorWidth) <= (self.underlineContainerView.frame.size.width + self.configuration.underlineCursorWidth)) {
            [UIView animateWithDuration:self.configuration.animDuration
                             animations:^{
                                 self.underlineCursorView.frame = CGRectMake(
                                                                             self.underlineCursorView.frame.origin.x
                                                                             , self.underlineCursorView.frame.origin.y
                                                                             , self.underlineCursorView.frame.size.width + self.configuration.underlineCursorWidth
                                                                             , self.underlineCursorView.frame.size.height
                                                                             );
                             }];
        }
    } else {
        if ((self.underlineCursorView.frame.origin.x + self.configuration.underlineCursorWidth) < self.underlineContainerView.frame.size.width) {
            [UIView animateWithDuration:self.configuration.animDuration
                             animations:^{
                                 self.underlineCursorView.frame = CGRectMake(
                                                                             (self.underlineCursorView.frame.origin.x + self.configuration.underlineCursorWidth)
                                                                             , self.underlineCursorView.frame.origin.y
                                                                             , self.underlineCursorView.frame.size.width
                                                                             , self.underlineCursorView.frame.size.height
                                                                             );
                             }];
        }
    }
}

- (void)moveCursorBackward {
    if (self.configuration.isUnderlineFilled == YES) {
        if (self.configuration.underlineCursorWidth <= (self.underlineCursorView.frame.size.width - self.configuration.underlineCursorWidth)) {
            [UIView animateWithDuration:self.configuration.animDuration
                             animations:^{
                                 self.underlineCursorView.frame = CGRectMake(
                                                                             self.underlineCursorView.frame.origin.x
                                                                             , self.underlineCursorView.frame.origin.y
                                                                             , self.underlineCursorView.frame.size.width - self.configuration.underlineCursorWidth
                                                                             , self.underlineCursorView.frame.size.height
                                                                             );
                             }];
        }
    } else {
        if (0 <= (self.underlineCursorView.frame.origin.x - self.configuration.underlineCursorWidth)) {
            [UIView animateWithDuration:self.configuration.animDuration
                             animations:^{
                                 self.underlineCursorView.frame = CGRectMake(
                                                                             (self.underlineCursorView.frame.origin.x - self.configuration.underlineCursorWidth)
                                                                             , self.underlineCursorView.frame.origin.y
                                                                             , self.underlineCursorView.frame.size.width
                                                                             , self.underlineCursorView.frame.size.height
                                                                             );
                             }];
        }
    }
}

@end
