//
//  ViewController.m
//  PjsipTest
//


#import "ViewController.h"
#import "PjsipManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *ip;
@property (weak, nonatomic) IBOutlet UITextField *port;
@property (weak, nonatomic) IBOutlet UITextField *callId;
@property (weak, nonatomic) IBOutlet UILabel *calledAccount;

@property (nonatomic , strong)PjsipManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [PjsipManager sharedPjsipManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calling:) name:@"calling" object:nil];
}

- (void)calling:(NSNotification *)notification{
    NSString *callId = notification.userInfo[@"calledCAcount"];
    _calledAccount.text = [NSString stringWithFormat:@"来电：%@",callId];
}

- (IBAction)login:(id)sender {
    if (!_account.text || !_password.text || !_ip.text || !_port.text) {
        return;
    }
    if ([_manager loginPjsipAccounts:_account.text password:_password.text ip:_ip.text port:[_port.text integerValue]]){
        NSLog(@"成功");
    }
    else{
        NSLog(@"失败");
    }
    
}

- (IBAction)call:(id)sender {
    if (!_callId.text) return;
    [_manager callAccount:_callId.text];
}
- (IBAction)answer:(id)sender {
    [_manager answerCall];
}
- (IBAction)hangUp:(id)sender {
    [_manager hangUp];
}

@end
