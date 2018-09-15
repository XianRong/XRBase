//
// Created by Captain on 2018/9/10. 
//  
//

#import <Foundation/Foundation.h>

/**
 网络状态
 
 - XRReachableNO:      没有网络
 - XRReachableViaWWAN: 手机数据网络
 - XRReachableViaWiFi: WIFI
 - XRReachableWiFiWAN: WIFI + 手机数据网络
 */
typedef NS_ENUM(NSInteger,XRReachableType) {
    XRReachableNO = 0,
    XRReachableViaWWAN = 1,
    XRReachableViaWiFi = 2,
    XRReachableWiFiWAN = 3,
};

/**
 数据网络类型
 
 - XRNetworkClass_UNKNOWN: 未知
 - XRNetworkClass_2G: 2G
 - XRNetworkClass_3G: 3G
 - XRNetworkClass_4G: 4G
 */
typedef NS_ENUM(NSInteger,XRNetworkClassType) {
    XRNetworkClass_UNKNOWN = 0,
    XRNetworkClass_2G = 1,
    XRNetworkClass_3G = 2,
    XRNetworkClass_4G = 3,
};

/**
 供应商类型
 */
typedef NS_ENUM(NSInteger, XRCarrierType) {
    XRCarrierUnkown = 0,   //未知
    XRCarrierCMCC = 1,     //中国移动
    XRCarrierUnicom = 2,   //中国联通
    XRCarrierTelecom = 3   //中国电信
};



@interface XRUtil : NSObject

/**
 时间戳
 */
@property (nonatomic,class,readonly) NSString *timestamp;

/**
 uuid
 */
@property (nonatomic,class,readonly) NSString *uuid;

/**
 是否有sim卡
 */
@property (nonatomic,class,readonly) BOOL hasSim;

/**
 数据流量
 */
@property (nonatomic,class,readonly) BOOL isCellularUsable;

/**
 网络状态
 */
@property (nonatomic,class,readonly) XRReachableType networkStatus;


/**
 网络数据类型
 */
@property (nonatomic,class,readonly) XRNetworkClassType networkClassType;

/**
 运营商
 */
@property (nonatomic,class,readonly) XRCarrierType carrier;

/**
 设备系统
 */
@property (nonatomic,class,readonly) NSString *deviceSystem;

/**
 设备模型
 */
@property (nonatomic,class,readonly) NSString *deviceModel;

/**
 设备品牌
 */
@property (nonatomic,class,readonly) NSString *deviceBrand;

/**
 IMSI
 */
@property (nonatomic,class,readonly) NSString *IMSI;

/**
 IMSI
 */
@property (nonatomic,class,readonly) NSString *IMEI;


/**
 JSON字符串转字典
 
 @param jsonString json字符串
 @return 返回字典
 */
+ (NSDictionary *)convertToDictionary:(NSString *)jsonString;

/**
 字典转JSON字符串
 
 @param dict 字典
 @param flag 是否带转义字符
 @return 返回字符串
 */
+ (NSString *)convertToJSONString:(NSDictionary *)dict withEscapeCharacters:(BOOL)flag;

/**
 子线程回调数据到主线程
 
 @param result 回调参数
 @param completion 回调
 */
+ (void)subThreadResult:(id)result toMainThread:(void(^)(id))completion;


/**
 MD5加密
 
 @param src 加密前字符串
 @return 返回加密后的字符串
 */
+ (NSString *)md5:(NSString *)src;


/**
 格式化时间
 
 @param str 时间戳
 @return 格式化好的时间字符串
 */
+(NSString*)formatterWithTimeStr:(NSString*)str;

@end
