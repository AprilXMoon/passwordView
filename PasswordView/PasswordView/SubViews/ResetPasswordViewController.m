//
//  ResetPasswordViewController.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "UnitityMethod.h"
#import "Preference.h"

@interface ResetPasswordViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *userNewPassword;
@property (strong, nonatomic) IBOutlet UIButton *resetPassword;
@property (strong, nonatomic) IBOutlet UILabel *hintMessage;

@end

@implementation ResetPasswordViewController

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
    [[UnitityMethod shareInstance] adjustTextField:self.oldPassword];
    [[UnitityMethod shareInstance] adjustTextField:self.userNewPassword];
    
    [[UnitityMethod shareInstance] adjustButtonSkin:self.resetPassword];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.9936 green:0.6875 blue:0.1221 alpha:1.0];
}

- (void)settingComponents
{
    self.oldPassword.delegate = self;
    self.userNewPassword.delegate = self;
    
    self.hintMessage.text = @"";
}

#pragma mark - IBAction

- (IBAction)resetPasswordButtonPressed:(id)sender {
    
    BOOL isFinalCheckOK = [self finalCheck];
    
    if (isFinalCheckOK) {
        Preference *userPreference = [[Preference alloc] init];
        [userPreference saveUserPassword:self.userNewPassword.text];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.oldPassword resignFirstResponder];
    [self.userNewPassword resignFirstResponder];
}

#pragma mark - check method

- (BOOL)finalCheck
{
    BOOL isFinalCheckOK = YES;
    
    NSMutableString *hintMesssage = [[NSMutableString alloc] init];

    BOOL isCheckUserPassword = [self checkUserPassword];
    BOOL isCheckNewPassword = (self.userNewPassword.text.length < 8 || self.userNewPassword.text.length > 12);
    
    if (!isCheckUserPassword) {
        isFinalCheckOK = NO;
        [hintMesssage appendString:[NSString stringWithFormat:@"%@ \n", NSLocalizedString(@"checkPasswordFail", nil)]];
    }
    
    if (isCheckNewPassword) {
        isFinalCheckOK = NO;
        [hintMesssage appendString:[NSString stringWithFormat:@"%@ \n", NSLocalizedString(@"passwordMessage", nil)]];
    }
    
    if (!isFinalCheckOK) {
        self.hintMessage.text = hintMesssage;
    }
    
    return isFinalCheckOK;
}

- (BOOL)checkUserPassword
{
    Preference *userPreference = [[Preference alloc] init];
    NSString *userPassword = [userPreference getUserPassword];
    
    BOOL isUserPassword = [self.oldPassword.text isEqualToString:userPassword];
    
    return isUserPassword;
}


#pragma mark - textField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.userNewPassword) {
        
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
