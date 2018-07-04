# 支付宝支付 cordova 插件

> 支持ios, android
开通服务: [https://open.alipay.com](https://open.alipay.com)

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
const orderstring = 'xxx'; // 后台生成的字符串
window.Alipay.pay(orderstring, res => {
    console.log('成功');
}, e => {
  console.error(e);
});

```
>打开授权页面
```js
const authstring = 'xxx'; // 后台生成的字符串
window.Alipay.auth(authstring, res => {
    console.log('成功');
}, e => {
  console.error(e);
});

```

## IONIC Wrap
[https://github.com/yc-ionic/alipay](https://github.com/yc-ionic/alipay)

## 代码捐献

非常期待您的代码捐献。