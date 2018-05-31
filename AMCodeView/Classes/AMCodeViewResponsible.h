//
//  AMCodeViewResponsible.h
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol AMCodeViewResponsible <NSObject>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSArray<UILabel*> *digitLabels;

- (void)moveCursorToStart;
- (void)moveCursorForward;
- (void)moveCursorBackward;

@end
