//
//  AMCodeViewConfiguration.m
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import "AMCodeViewConfiguration.h"

@implementation AMCodeViewConfiguration

@synthesize height = _height;
@synthesize animDuration = _animDuration;
@synthesize maxCodeLength = _maxCodeLength;
@synthesize underlineCursorWidth = _underlineCursorWidth;
@synthesize underlineCursorHeight = _underlineCursorHeight;

@synthesize isUnderlineFilled = _isUnderlineFilled;

@synthesize digitFont = _digitFont;
@synthesize digitColor = _digitColor;

@synthesize underlineCursorColor = _underlineCursorColor;
@synthesize underlineContainerColor = _underlineContainerColor;

#pragma mark - CodeViewConfigurable

+ (id<AMCodeViewConfigurable>)defaultConfig {
    id<AMCodeViewConfigurable> result = [[AMCodeViewConfiguration alloc] init];
    
    result.height = 47;
    result.animDuration = .3f;
    result.underlineCursorWidth = 44;
    result.underlineCursorHeight = 3;
    result.maxCodeLength = 6;
    result.isUnderlineFilled = NO;
    result.digitColor = [UIColor darkGrayColor];
    result.digitFont = [UIFont systemFontOfSize:44];
    result.underlineCursorColor = [UIColor colorWithRed:.97f
                                                  green:.91f
                                                   blue:.11f
                                                  alpha:1];
    result.underlineContainerColor = [UIColor darkGrayColor];
    
    return result;
}

@end
