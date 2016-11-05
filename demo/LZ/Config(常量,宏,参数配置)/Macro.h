


//本地环境
#define LocalEnvironment

//正式环境
//#define OfficialEnvironment
/**
 *  APIURL 服务器地址
 */

#ifdef LocalEnvironment
#define APIURL              @"http://192.168.0.62:9500"
#endif

#ifdef OfficialEnvironment
#define APIURL              @"https://ezgapi.edsmall.cn"
#endif

#pragma mark **************** 个人信息

//发送验证码到手机
#define APISendMobile               [APIURL stringByAppendingString:@"/v1/send/"]




