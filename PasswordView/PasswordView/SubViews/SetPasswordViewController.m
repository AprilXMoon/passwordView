//
//  SetPasswordViewController.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "UnitityMethod.h"
#import "Preference.h"

@interface SetPasswordViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *retypePasswordText;
@property (strong, nonatomic) IBOutlet UIButton *setPasswordButton;
@property (strong, nonatomic) IBOutlet UILabel *hintMessage;

@end

@implementation SetPasswordViewController

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
    [[UnitityMethod shareInstance] adjustTextField:self.passwordTextField];
    [[UnitityMethod shareInstance] adjustTextField:self.retypePasswordText];
    
    [[UnitityMethod shareInstance] adjustButtonSkin:self.setPasswordButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.9936 green:0.6875 blue:0.1221 alpha:1.0];
}

- (void)settingComponents
{
    self.passwordTextField.delegate = self;
    self.retypePasswordText.delegate = self;
    
    self.hintMessage.text = @"";
}

#pragma mark - IBAction

- (IBAction)setPasswordButtonPressed:(id)sender
{
    BOOL isFinalCheckOK = [self finalCheck];
    
    if (isFinalCheckOK) {
        Preference *userPreference = [[Preference alloc] init];
        [userPreference saveUserPassword:self.passwordTextField.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.passwordTextField resignFirstResponder];
    [self.retypePasswordText resignFirstResponder];
    
}

#pragma mark - final check

- (BOOL)finalCheck
{
    BOOL isFinalCheckOK = YES;
    
    NSMutableString *hintMessage = [[NSMutableString alloc] init];
    
    if (self.passwordTextField.text.length < 8 || self.passwordTextField.text.length > 12) {
        isFinalCheckOK = NO;
        [hintMessage appendString:[NSString stringWithFormat:@"%@ \n", NSLocalizedString(@"passwordMessage", nil)]];
    }
    
    if (![self.retypePasswordText.text isEqualToString:self.passwordTextField.text]) {
        isFinalCheckOK = NO;
        [hintMessage appendString:NSLocalizedString(@"retypePasswordError", nil)];
    }
    
    if (!isFinalCheckOK) {
        self.hintMessage.text = hintMessage;
    }
    
    return isFinalCheckOK;
}

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.passwordTextField) {
        
        NSString *inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        BOOL isInputValid = [[UnitityMethod shareInstance] checkInputValid:inputString];
        
        return isInputValid;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.hintMessage.text = @"";
}


@end
