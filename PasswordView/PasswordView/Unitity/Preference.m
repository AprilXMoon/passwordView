//
//  Preference.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "Preference.h"

@implementation Preference

- (void)saveUserPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"Password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserPassword
{
    NSString *userPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"Password"];
    return userPassword;
}

@end
