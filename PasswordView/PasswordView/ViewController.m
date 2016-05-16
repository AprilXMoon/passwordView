//
//  ViewController.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "ViewController.h"
#import "UnitityMethod.h"
#import "Preference.h"

#import "SetPasswordViewController.h"
#import "CheckPasswordViewController.h"
#import "ResetPasswordViewController.h"
#import "RemovePasswordViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *setPasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *checkPasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *resetPasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *removePasswordButton;

@property (strong, nonatomic) UIStoryboard *mainStoryboard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self adjustButtonSkin];
    [self settingComponents];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self resetShowButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initial method

- (void)adjustButtonSkin
{
    [[UnitityMethod shareInstance] adjustButtonSkin:self.setPasswordButton];
    [[UnitityMethod shareInstance] adjustButtonSkin:self.checkPasswordButton];
    [[UnitityMethod shareInstance] adjustButtonSkin:self.resetPasswordButton];
    [[UnitityMethod shareInstance] adjustButtonSkin:self.removePasswordButton];
}

- (void)settingComponents
{
    self.title = NSLocalizedString(@"MainPageTitle", nil);
    
    self.mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

}

#pragma mark - resetShowButtons

- (void)resetShowButtons
{
    Preference *userPreference = [[Preference alloc] init];
    
    NSString *password = [userPreference getUserPassword];
    
    BOOL havePassword = (![password isEqual:[NSNull null]] && (password.length > 0));

    self.setPasswordButton.hidden = havePassword;
    
    self.checkPasswordButton.hidden = !havePassword;
    self.resetPasswordButton.hidden = !havePassword;
    self.removePasswordButton.hidden = !havePassword;
}

#pragma mark - IBAction

- (IBAction)infoButtonPressed:(id)sender
{
    [self showInformationAlertView];
}

- (IBAction)setPasswordButtonPressed:(id)sender
{
    SetPasswordViewController *setPasswordView = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"SetPasswordViewController"];
    
    [self.navigationController pushViewController:setPasswordView animated:YES];
}

- (IBAction)checkPasswordButtonPressed:(id)sender
{
    CheckPasswordViewController *checkPasswordView = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"CheckPasswordViewController"];
    
    [self.navigationController pushViewController:checkPasswordView animated:YES];
}

- (IBAction)resetPasswordButtonPressed:(id)sender
{    
    ResetPasswordViewController *resetPasswordView = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"ResetPasswordViewController"];
    
    [self.navigationController pushViewController:resetPasswordView animated:YES];
}

- (IBAction)removePasswordButtonPressed:(id)sender
{
    RemovePasswordViewController *removePasswordView = [self.mainStoryboard instantiateViewControllerWithIdentifier:@"RemovePasswordViewController"];
    
    [self.navigationController pushViewController:removePasswordView animated:YES];

}

#pragma mark - info alert view

- (void)showInformationAlertView
{
    UIAlertController *infoAlertView = [UIAlertController alertControllerWithTitle:@"Information"
                                                                           message:@"Have fun to password view!!"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@" 😁 OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
    
    [infoAlertView addAction:okAction];
    
    [self presentViewController:infoAlertView animated:YES completion:nil];
}

@end
