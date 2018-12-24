//
//  MOBLoginViewController.m
//  PjsipTest
//
//  Created by 崔林豪 on 2018/12/19.
//  Copyright © 2018年 未央生. All rights reserved.
//

#import "MOBLoginViewController.h"
#import "PjsipManager.h"
#import "pjsua.h"


@interface MOBLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;

@end

@implementation MOBLoginViewController

#pragma mark -  生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handleRegisterStatus:) name:@"SIPRegisterStatusNotification" object:nil];
    
}

//登录回调成功
- (void)_handleRegisterStatus:(NSNotification *)notification
{
    pjsip_status_code status = [notification.userInfo[@"status"] intValue];
    NSString *statusText = notification.userInfo[@"status_text"];
    
    
    //---
    //账号ID
    //pjsua_acc_id acc_id = [notification.userInfo[@"acc_id"] intValue];
    
    if (status != PJSIP_SC_OK)
    {
        NSLog(@"--------登录失败,错误信息: %d(%@)", status, statusText);
        return;
    }
    
    NSLog(@"----->>>登录回调成功");
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *dialViewController = [sb instantiateViewControllerWithIdentifier:@"DialVC"];
    
    
    CATransition *transition = [[CATransition alloc] init];
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionFade;
    transition.duration  = 0.5;
    transition.removedOnCompletion = YES;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow.layer addAnimation:transition forKey:@"change_view_controller"];
    
    keyWindow.rootViewController = dialViewController;
    
}

- (IBAction)loginBtnClick:(id)sender {
    
    if (!_accountTextField.text || !_secretTextField.text || !_ipTextField.text)
    {
        return;
    }
    
    if ([[PjsipManager sharedPjsipManager] loginPjsipAccounts:_accountTextField.text password:_secretTextField.text ip:_ipTextField.text])
    {
        NSLog(@"----登录 成功");
        //成功后进入登录状态改变
    }
    else
    {
        NSLog(@"----登录失败");
    }
    
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



@end
