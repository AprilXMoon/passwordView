//
//  CheckPasswordViewController.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "CheckPasswordViewController.h"
#import "UnitityMethod.h"
#import "Preference.h"

@interface CheckPasswordViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *inputPassword;
@property (strong, nonatomic) IBOutlet UIButton *checkPasswordButton;
@property (strong, nonatomic) IBOutlet UILabel *responseMessage;

@end

@implementation CheckPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self adjustComponentsSkin];
    [self settingComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - initial method

- (void)adjustComponentsSkin
{
    [[UnitityMethod shareInstance] adjustTextField:self.inputPassword];
    
    [[UnitityMethod shareInstance] adjustButtonSkin:self.checkPasswordButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.9936 green:0.6875 blue:0.1221 alpha:1.0];
}

- (void)settingComponents
{
    self.inputPassword.delegate = self;
    
    self.responseMessage.text = @"";
}

#pragma mark - IBAction

- (IBAction)checkPasswordButtonPressed:(id)sender
{
    [self checkPassword];
    
    [self.inputPassword resignFirstResponder];
}

#pragma mark - check password

- (void)checkPassword
{
    Preference *userPreference = [[Preference alloc] init];
    
    NSString *userPassword = [userPreference getUserPassword];
    NSString *userInputPassword = self.inputPassword.text;
    
    NSString *responseMessage = NSLocalizedString(@"checkPasswordSuccess", nil);
    if (![userInputPassword isEqualToString:userPassword]) {
        responseMessage = NSLocalizedString(@"checkPasswordFail", nil);
    }
    
    self.responseMessage.text = responseMessage;
}

#pragma mark - textField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    BOOL isInputValid = [[UnitityMethod shareInstance] checkInputValid:inputString];
    
    return isInputValid;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.responseMessage.text = @"";
}


@end
