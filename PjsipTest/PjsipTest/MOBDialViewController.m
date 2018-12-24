//
//  MOBDialViewController.m
//  PjsipTest
//
//  Created by 崔林豪 on 2018/12/19.
//  Copyright © 2018年 未央生. All rights reserved.
//

#import "MOBDialViewController.h"
#import "PjsipManager.h"
#import "pjsua.h"


@interface MOBDialViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@end

@implementation MOBDialViewController

#pragma mark -  生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handleCallStatusChange:) name:@"SIPCallStatusChangedNotification" object:nil];

}
//拨号的回调
- (void)_handleCallStatusChange:(NSNotification *)notification
{
    pjsip_inv_state state = [notification.userInfo[@"state"] intValue];
    if (state == PJSIP_INV_STATE_DISCONNECTED)
    {
        [_callButton setTitle:@"呼叫" forState:UIControlStateNormal];
        [_callButton setEnabled:YES];
        
    }
    else if(state == PJSIP_INV_STATE_CALLING)
    {
        [_callButton setTitle:@"呼叫中..." forState:UIControlStateNormal];
        [_callButton setEnabled:NO];
    }
    else if(state == PJSIP_INV_STATE_CONNECTING)
    {
        [_callButton setTitle:@"正在连接..." forState:UIControlStateNormal];
        [_callButton setEnabled:NO];
    }
    else if(state == PJSIP_INV_STATE_CONFIRMED)
    {
        [_callButton setTitle:@"挂断" forState:UIControlStateNormal];
        [_callButton setEnabled:YES];
    }
}

//拨号
- (IBAction)callBtnClick:(id)sender {
    if (!_phoneTextField.text)
    {
        return;
    }
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"呼叫"])
    {
        [[PjsipManager sharedPjsipManager] callAccount:_phoneTextField.text];
    }
    else
    {   //挂断
        [[PjsipManager sharedPjsipManager] hangUp];
    }
    
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



@end

