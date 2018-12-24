//
//  MOBIncomimgViewController.h
//  PjsipTest
//
//  Created by 崔林豪 on 2018/12/19.
//  Copyright © 2018年 未央生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pjsua.h"


NS_ASSUME_NONNULL_BEGIN

@interface MOBIncomimgViewController : UIViewController

@property (nonatomic, strong) NSString *phoneNum;

@property (nonatomic, assign) pjsua_call_id callId;



@end

NS_ASSUME_NONNULL_END
