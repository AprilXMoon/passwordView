//
//  UnitityMethod.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "UnitityMethod.h"


@implementation UnitityMethod

#pragma mark - shareInstance

+ (UnitityMethod *)shareInstance
{
    static UnitityMethod *unitityMethod = nil;
    
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        unitityMethod = [[UnitityMethod alloc] init];
    });
    
    return unitityMethod;
}

#pragma mark - skin

- (void)adjustButtonSkin:(UIButton *)adjustedButton
{
    adjustedButton.layer.cornerRadius = 6.0;
}

- (void)adjustTextField:(UITextField *)adjustedTextField
{
    adjustedTextField.layer.borderWidth = 1.0;
    adjustedTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    
    adjustedTextField.layer.cornerRadius = 6.0;
}

#pragma mark - check

- (BOOL)checkInputValid:(NSString *)InputText
{
    NSString *regExPattern = @"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regExPattern];
    
    BOOL isInputValid = [predicate evaluateWithObject:InputText];
    
    return isInputValid;
}

@end
