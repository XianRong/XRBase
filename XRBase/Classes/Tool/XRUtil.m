//
// Created by Captain on 2018/9/10. 
//  
//

#import "XRUtil.h"
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <netinet/in.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreTelephony/CTCarrier.h>
#import <UIKit/UIDevice.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation XRUtil

+(NSString*)formatterWithTimeStr:(NSString*)str{
    //    1、把服务器返回的时间字符串转成NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //    注意：时间转化之前，需要设置NSDateFormatter的local，因为真机上转化时间的时候会为nil
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate*confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[str intValue]];
    
    NSString * showTimeStr = [dateFormatter stringFromDate:confromTimesp];
    return showTimeStr;
}


/**
 获取当前时间戳
 */
+ (NSString *)timestamp {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *result = [formatter stringFromDate:now];
    return result;
}

/**
 获取UUID
 */
+ (NSString *)uuid {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""]?:@"";
}

/**
 判断是否Sim卡
 */
+ (BOOL)hasSim {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    return (carrier && carrier.mobileNetworkCode);
}


/**
 判断是否开启数据流量
 */
+ (BOOL)isCellularUsable {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = getifaddrs(&interfaces);;
    if (success == 0) { // 0 表示获取成功
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // SIM卡端口是否可以获取
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    freeifaddrs(interfaces);
                    return YES;
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return NO;
}

/**
 获取当前网络状态
 */
+ (XRReachableType)networkStatus {
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return XRReachableNO;
        
    }else {
        BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
        if (!isReachable) {
            
            return XRReachableNO;
        }else {
            XRReachableType returnValue = XRReachableNO;
            
            //  WIFI
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
                
                returnValue = XRReachableViaWiFi;
            }
            
            //  WIFI
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                    
                    returnValue = XRReachableViaWiFi;
                }
            }
            
            //  手机数据流量
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
                
                returnValue = XRReachableViaWWAN;
            }
            
            //  WIFI + 手机数据流量
            if ((returnValue == XRReachableViaWiFi) && [self isCellularUsable]) {
                
                returnValue = XRReachableWiFiWAN;
            }
            
            return returnValue;
        }
    }
}


/**
 当前网络数据类型
 */
+(XRNetworkClassType)networkClassType{
    NSArray *typeStrings2G = @[CTRadioAccessTechnologyEdge,
                               CTRadioAccessTechnologyGPRS,
                               CTRadioAccessTechnologyCDMA1x];
    
    NSArray *typeStrings3G = @[CTRadioAccessTechnologyHSDPA,
                               CTRadioAccessTechnologyWCDMA,
                               CTRadioAccessTechnologyHSUPA,
                               CTRadioAccessTechnologyCDMAEVDORev0,
                               CTRadioAccessTechnologyCDMAEVDORevA,
                               CTRadioAccessTechnologyCDMAEVDORevB,
                               CTRadioAccessTechnologyeHRPD];
    
    NSArray *typeStrings4G = @[CTRadioAccessTechnologyLTE];
    XRNetworkClassType networkClass = XRNetworkClass_UNKNOWN;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CTTelephonyNetworkInfo *teleInfo= [[CTTelephonyNetworkInfo alloc] init];
        id accessString = teleInfo.currentRadioAccessTechnology;
        if ([accessString isKindOfClass:[NSNull class]]) {
            return networkClass;
        }
        if ([typeStrings4G containsObject:accessString]) {
            networkClass = XRNetworkClass_4G;
        } else if ([typeStrings3G containsObject:accessString]) {
            networkClass = XRNetworkClass_3G;
        } else if ([typeStrings2G containsObject:accessString]) {
            networkClass = XRNetworkClass_2G;
        }
    }
    return networkClass;
}

/**
 获取运营商
 */
+ (XRCarrierType)carrier {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *name = carrier.carrierName;
    XRCarrierType type = XRCarrierUnkown;
    if ([self hasSim]) {
        if ([name isEqualToString:@"中国移动"]) {
            type = XRCarrierCMCC;
        } else if ([name isEqualToString:@"中国联通"]) {
            type = XRCarrierUnicom;
        } else if ([name isEqualToString:@"中国电信"]) {
            type = XRCarrierTelecom;
        }
    }
    return type;
}

/**
 获取设备系统
 */
+ (NSString *)deviceSystem {
    UIDevice *device = [UIDevice currentDevice];
    NSString *result = [NSString stringWithFormat:@"iOS %@", device.systemVersion];
    return result;
}

/**
 设备模型
 */
+ (NSString *)deviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

/**
 设备品牌
 */
+ (NSString *)deviceBrand {
    return UIDevice.currentDevice.model;
}

+ (NSString *)IMSI {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *imsi = [NSString stringWithFormat:@"%@%@", carrier.mobileCountryCode, carrier.mobileNetworkCode];
    return imsi;
}

+ (NSString *)IMEI {
    return @"imei";
}


/**
 JSON字符串转字典
 
 @param jsonString  JSON字符串
 @return 字典
 */
+ (NSDictionary *)convertToDictionary:(NSString *)jsonString {
    
    if (![jsonString isKindOfClass:[NSString class]] || jsonString.length == 0) {
        return @{};
    }
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = (data.length > 0) ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : @{};
    
    return dict;
}


/**
 字典转JSON字符串
 
 @param dict 字典
 @param flag 是否需要去除转义符（"\\\"）
 @return JSON字符串
 */
+ (NSString *)convertToJSONString:(NSDictionary *)dict withEscapeCharacters:(BOOL)flag {
    
    NSString *jsonString = @"";
    if (dict.count > 0) {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        if (jsonData.length > 0) {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] ?: @"";
        }
    }
    return flag ? [jsonString stringByReplacingOccurrencesOfString:@"\\\"" withString:@""] : jsonString;
}


/**
 子线程回调数据到主线程
 
 @param result 回调参数
 @param completion 回调
 */
+ (void)subThreadResult:(id)result toMainThread:(void(^)(id))completion {
    
    if (completion) {
        
        if (result) {
            if (NSThread.isMainThread) {
                completion(result);
            }else {
                [NSOperationQueue.mainQueue addOperationWithBlock:^{
                    completion(result);
                }];
            }
        }
        
    }
    
}

// md5加密字符串
+ (NSString *)md5:(NSString *)src {
    
    NSMutableString *retString = @"".mutableCopy;
    if (src && [src isKindOfClass:NSString.class]) {
        const char *source = [src UTF8String];
        unsigned char md5[CC_MD5_DIGEST_LENGTH];
        CC_MD5(source, (uint32_t)strlen(source), md5);
        
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            NSString *strValue = [NSString stringWithFormat:@"%02X", md5[i]];
            
            [retString appendString:([strValue length] == 0) ? @"":strValue];
        }
    }
    
    return [retString lowercaseString];
}

@end
