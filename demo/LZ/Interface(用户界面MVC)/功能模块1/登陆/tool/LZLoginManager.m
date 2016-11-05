//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZLoginManager.h"

@interface LZLoginManager ()

@end

@implementation LZLoginManager

/* 保存电话号码，登陆状态*/
+ (void)savePhoneNumWithString:(NSString *)phoneNum
{
    NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
    
    if(!phoneListArray)
    {
        phoneListArray = [NSMutableArray new];
    }
    if ([phoneListArray containsObject:phoneNum])
    {
        [phoneListArray removeObject:phoneNum];
        [phoneListArray insertObject:phoneNum atIndex:0];
    }
    else
    {
        [phoneListArray insertObject:phoneNum atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:phoneListArray forKey:PHONE_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self saveLoginState];//保存登陆状态
    
}
+ (void)saveLoginState
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ISLOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
