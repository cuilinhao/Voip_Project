//
//  MOBIncomimgViewController.m
//  PjsipTest
//
//  Created by 崔林豪 on 2018/12/19.
//  Copyright © 2018年 未央生. All rights reserved.
//

#import "MOBIncomimgViewController.h"
#import "PjsipManager.h"


@interface MOBIncomimgViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@end

@implementation MOBIncomimgViewController


#pragma mark -  生命周期 Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _phoneLab.text = self.phoneNum;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handleCallStatuschange:) name:@"SIPCallStatusChangedNotification" object:nil];
}


- (void)_handleCallStatuschange:(NSNotification *)notification
{
    pjsip_inv_state state = [notification.userInfo[@"state"] intValue];
    
    if (state == PJSIP_INV_STATE_DISCONNECTED)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (state == PJSIP_INV_STATE_CONNECTING)
    {
        NSLog(@"连接中....");
    }
    else if(state == PJSIP_INV_STATE_CONFIRMED)
    {
        NSLog(@"---接听成功!");
        [_connectButton setTitle:@"通话中" forState:UIControlStateNormal];
        [_connectButton setEnabled:NO];
    }
    
}


- (IBAction)listenBtnclick:(id)sender {
    
    [[PjsipManager sharedPjsipManager] answerCall:self.callId];
    
}

- (IBAction)downBtnClick:(id)sender {
    
    [[PjsipManager sharedPjsipManager] hangUp];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
