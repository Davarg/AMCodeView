//
//  AMCodeView.h
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import <UIKit/UIKit.h>

#import <AMCodeView/AMCodeViewResponsible.h>
#import <AMCodeView/AMTextFieldWithoutMenu.h>
#import <AMCodeView/AMCodeViewConfigurable.h>

@interface AMCodeView : UIView <AMCodeViewResponsible>

@property (strong, nonatomic) UIView *fieldContainerView;
@property (strong, nonatomic) AMTextFieldWithoutMenu *textField;

/**
 * Call this method
 * after creating
 */
- (void)configure:(id<AMCodeViewConfigurable>)configuration;

@end
