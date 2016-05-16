//
//  RemovePasswordViewController.m
//  PasswordView
//
//  Created by April Lee on 2016/5/6.
//  Copyright © 2016年 april. All rights reserved.
//

#import "RemovePasswordViewController.h"
#import "UnitityMethod.h"
#import "Preference.h"

@interface RemovePasswordViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *originPassword;
@property (strong, nonatomic) IBOutlet UIButton *removePasswordButton;
@property (strong, nonatomic) IBOutlet UILabel *hintMessage;

@end

@implementation RemovePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self adjustComponentsSkin];
    
    self.originPassword.delegate = self;
    self.hintMessage.text = @"";
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
    [[UnitityMethod shareInstance] adjustTextField:self.originPassword];
    
    [[UnitityMethod shareInstance] adjustButtonSkin:self.removePasswordButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.9936 green:0.6875 blue:0.1221 alpha:1.0];
}

#pragma mark - IBAction

- (IBAction)removePasswordButtonPressed:(id)sender {
    
    BOOL isCheckOK = [self checkUserPassword];
    
    if (isCheckOK) {
        [self removeUserPassword];
    } else {
        self.hintMessage.text = NSLocalizedString(@"checkPasswordFail", nil);
        self.originPassword.text = @"";
    }
    
    [self.originPassword resignFirstResponder];
}

#pragma mark - remove method

- (BOOL)checkUserPassword
{
    Preference *userPreference = [[Preference alloc] init];
    
    NSString *userPassword = [userPreference getUserPassword];
    NSString *inputPassword = self.originPassword.text;
    
    BOOL isCheckOK = [inputPassword isEqualToString:userPassword];
    
    return isCheckOK;
}

- (void)removeUserPassword
{
    Preference *userPreference = [[Preference alloc] init];
    [userPreference saveUserPassword:@""];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextField Delegate

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
    self.hintMessage.text = @"";
}

@end
