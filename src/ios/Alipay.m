#import "Alipay.h"

@implementation Alipay

- (NSString *)appId {
    if (!_appId) {
        _appId = [[self.commandDelegate settings] objectForKey:@"app_id"];
    }
    return _appId;
}

- (NSString *)schema {
    if (!_schema) {
        _schema = [@"ALI" stringByAppendingString:self.appId];
    }
    return _schema;
}

- (void) pay:(CDVInvokedUrlCommand*)command
{
    self.currentCallbackId = command.callbackId;

    if ([self.appId length] == 0)
    {
        [self failWithCallbackID:self.currentCallbackId withMessage:@"支付宝APP_ID设置错误"];
        return;
    }
    
    NSString *orderString = [command argumentAtIndex:0];
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:self.schema callback:^(NSDictionary *resultDic) {
        [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
    }];
}

- (void) auth:(CDVInvokedUrlCommand*)command
{
    self.currentCallbackId = command.callbackId;
    
    if ([self.appId length] == 0)
    {
        [self failWithCallbackID:self.currentCallbackId withMessage:@"支付宝APP_ID设置错误"];
        return;
    }
    
    NSString *authString = [command argumentAtIndex:0];
    
    [[AlipaySDK defaultService] auth_V2WithInfo:authString fromScheme:self.schema callback:^(NSDictionary *resultDic) {
        [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
        NSLog(@"A~%@", resultDic);
    }];
}

- (void)handleOpenURL:(NSNotification *)notification
{
    NSURL* url = [notification object];
    if ([url.scheme isEqualToString:self.schema])
    {
        if([url.host isEqualToString:@"safepay"])
        {
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                if([resultDic[@"resultStatus"] isEqualToString:@"9000"])
                    [self successWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
                else
                    [self failWithCallbackID:self.currentCallbackId messageAsDictionary:resultDic];
            }];
        }
        else
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
