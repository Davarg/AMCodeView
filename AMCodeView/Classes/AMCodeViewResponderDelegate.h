//
//  AMCodeViewResponderDelegate.h
//  AMCodeView
//
//  Created by Александр Макушкин on 30.05.2018.
//

#import <Foundation/Foundation.h>

@protocol AMCodeViewResponderDelegate <NSObject>

- (void)codeChanged:(NSString *)code;

@end
