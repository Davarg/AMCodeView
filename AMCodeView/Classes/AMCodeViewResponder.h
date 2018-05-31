//
//  AMCodeViewResponder.h
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import <Foundation/Foundation.h>

#import <AMCodeView/AMCodeViewResponsible.h>
#import <AMCodeView/AMCodeViewConfigurable.h>
#import <AMCodeView/AMCodeViewResponderDelegate.h>

@interface AMCodeViewResponder : NSObject <UITextFieldDelegate>

@property (weak, nonatomic) id<AMCodeViewResponderDelegate> delegate;

- (instancetype)initWithConfig:(id<AMCodeViewConfigurable>)config
               viewResponsible:(id<AMCodeViewResponsible>)view;

@end
