//
//  AMCodeViewConfigurable.h
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol AMCodeViewConfigurable <NSObject>

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat animDuration;
@property (assign, nonatomic) NSInteger maxCodeLength;
@property (assign, nonatomic) CGFloat underlineCursorWidth;
@property (assign, nonatomic) CGFloat underlineCursorHeight;

/**
 * Growing cursor
 */
@property (assign, nonatomic) BOOL isUnderlineFilled;

@property (strong, nonatomic) UIFont *digitFont;
@property (strong, nonatomic) UIColor *digitColor;

@property (strong, nonatomic) UIColor *underlineCursorColor;
@property (strong, nonatomic) UIColor *underlineContainerColor;

+ (id<AMCodeViewConfigurable>)defaultConfig;

@end
