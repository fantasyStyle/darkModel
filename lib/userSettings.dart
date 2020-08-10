/*
 * @Author: fantasy 
 * @Date: 2019-08-29 16:57:04 
 * @Last Modified by: fantasy
 * @Last Modified time: 2020-08-10 10:35:35
 * 用户调试设置类
 */
import 'package:darkModel/cache.dart';
import 'dart:convert';

class UserSettings {
  int isShowDarkModelCacheKey; //是否开启夜间模式 0:关闭 1:开启 2:跟随系统

  UserSettings.fromJson(Map<String, dynamic> json) {
    isShowDarkModelCacheKey = json['isShowDarkModelCacheKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isShowDarkModelCacheKey'] = this.isShowDarkModelCacheKey;
    return data;
  }

//更新临时信息
  static updateSingleSetting(Map<String, dynamic> newInfo) async {
    if (newInfo != null) {
      UserSettings userProfile = await UserSettings.getUserSettings();
      var newCacheInfo = userProfile.toJson();
      for (var key in newInfo.keys) {
        var newValue = newInfo[key];
        newCacheInfo[key] = newValue;
      }
      //存储用户信息数据
      String jsonstr = json.encode(newCacheInfo);
      await UserSettings.saveUserSettings(jsonstr);
    }
  }

  //获取调试模式信息
  static getUserSettings() async {
    var data = await Cache.getFile('userSettingsKey');
    if (data == null) {
      Map initialValue = {
        'isShowDarkModelCacheKey': 0,
      };
      String jsonstr = json.encode(initialValue);
      await saveUserSettings(jsonstr);
      data = await Cache.getFile('userSettingsKey');
    }
    var jsonData = await json.decode(data);
    UserSettings userSettings = UserSettings.fromJson(jsonData);
    return userSettings;
  }

  //保存调试设置参数
  static saveUserSettings(String data) async {
    await Cache.setFile('userSettingsKey', data);
  }

  //删除临时信息
  static cleanUserSettings() async {
    await Cache.deleteFile('userSettingsKey'); //清空临时数据
  }
}
