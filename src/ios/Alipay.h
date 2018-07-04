#import <Cordova/CDVPlugin.h>
#import <AlipaySDK/AlipaySDK.h>

@interface Alipay : CDVPlugin

@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *schema;
@property(nonatomic,strong)NSString *currentCallbackId;

- (void)pay:(CDVInvokedUrlCommand*)command;
- (void) auth:(CDVInvokedUrlCommand*)command;

@end
