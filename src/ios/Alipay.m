#import "Alipay.h"

@implementation Alipay

- (NSString *)appId {
    if (!_appId) {
        _appId = [[self.commandDelegate settings] objectForKey:@"app_id"];
    }
    return _appId;
}

- (void) pay:(CDVInvokedUrlCommand*)command
{
    self.currentCallbackId = command.callbackId;

    if ([self.appId length] == 0)
    {
        [self failWithCallbackID:self.currentCallbackId withMessage:@"支付APP_ID设置错误"];
        return;
    }
    
    NSString *orderString = [command argumentAtIndex:0];
    NSMutableString * schema = [NSMutableString string];
    [schema appendFormat:@"ALI%@", self.appId];
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:schema callback:^(NSDictionary *resultDic) {
        [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
    }];
}

- (void)handleOpenURL:(NSNotification *)notification
{
    NSURL* url = [notification object];
    
    if ([url.scheme rangeOfString:self.appId].length > 0)
    {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if([[[resultDic objectForKey:@""] stringValue] isEqualToString:@"9000"])
                [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
            else
                [self failWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
        }];
    }
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)successWithCallbackID:(NSString *)callbackID messageAsDictionary:(NSDictionary *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID messageAsDictionary:(NSDictionary *)message
{
    NSLog(@"message = %@",message);
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

@end
