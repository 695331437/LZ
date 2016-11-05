//
//  UserManager.m
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZUserManager.h"

@implementation LZUserManager

+ (BOOL)firstLaunch
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    
    return NO;
}
+ (BOOL)isLogin
{
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
    
    return NO;
}
@end
