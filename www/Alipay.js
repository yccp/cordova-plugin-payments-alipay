// AlicloudFeedback
// Author: Yu Chen <yu.chen@live.ie>
// License: Apache License 2.0

'use strict';

module.exports = {
  /**
   * @param {object|string} order
   * @param {Function} successCallback ['success']
   * @param {Function} errorCallback ['fail'|'cancel'|'invalid']
   */
  pay: function (order, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "Alipay", "pay", [order]);
  },
};