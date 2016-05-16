//
//  UnitityMethod.h
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...)
#endif

@interface UnitityMethod : NSObject

+ (UnitityMethod *)shareInstance;

- (void)adjustButtonSkin:(UIButton *)adjustedButton;
- (void)adjustTextField:(UITextField *)adjustedTextField;

- (BOOL)checkInputValid:(NSString *)InputText;


@end
