//
//  PjsipManager.h
//  PjsipTest
//

//

#import <Foundation/Foundation.h>
#import "pjsua.h"


@interface PjsipManager : NSObject

+ (void)pjsipInit;

+ (instancetype)sharedPjsipManager;

- (BOOL)loginPjsipAccounts:(NSString *)accountsString
                  password:(NSString *)passwordString
                        ip:(NSString *)ipString
                      port:(NSInteger )port;

- (BOOL)loginPjsipAccounts:(NSString *)accountsString
                  password:(NSString *)passwordString
                        ip:(NSString *)ipString;

//呼叫
- (void)callAccount:(NSString *)accountsString;

//挂断
- (void)hangUp;

//接电话
- (void)answerCall:(pjsua_call_id)callId;
- (void)answerCall;

@end
