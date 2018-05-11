# 阿里云移动用户反馈 cordova 插件

> 支持ios, android
开通服务: [https://www.aliyun.com/product/feedback](https://www.aliyun.com/product/feedback)

## 安装

```
cordova plugin add cordova-plugin-payments-alipay --variable APP_ID=你的ID --save
```
或
```
ionic cordova plugin add cordova-plugin-payments-alipay --variable APP_ID=你的ID
```

> 相关依赖
[cordova-plugin-cocoapod-support](https://www.npmjs.com/package/cordova-plugin-cocoapod-support)
```
cordova plugin add cordova-plugin-cocoapod-support --save
```
或
```
ionic cordova plugin add cordova-plugin-cocoapod-support
```

## 使用方法
>打开支付页面
```js
window.Alipay.pay({
  // ...
}, function() {
  console.log('成功');
}, function(e) {
  console.error(e);
});

```

## IONIC Wrap
[https://github.com/yc-ionic/alipay](https://github.com/yc-ionic/alipay)

## 代码捐献

非常期待您的代码捐献。