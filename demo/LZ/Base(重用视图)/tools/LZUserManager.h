//
//  UserManager.h
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LZUserManager : NSObject



/** 用户是否第一次运行*/
+ (BOOL)firstLaunch;


/** 用户是否登陆*/
+ (BOOL)isLogin;




@end
