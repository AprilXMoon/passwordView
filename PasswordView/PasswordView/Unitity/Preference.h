//
//  Preference.h
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preference : NSObject

- (void)saveUserPassword:(NSString *)password;
- (NSString *)getUserPassword;

@end
