/*
 * @Author: fantasy 
 * @Date: 2020-08-10 10:16:42 
 * @Last Modified by:   fantasy 
 * @Last Modified time: 2020-08-10 10:16:42 
 */
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Cache {
  //存储缓存
  static setFile(String key, data) async {
    if (key == null) {
      return false;
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, data);
      setMem(key, data);
      // debugPrint('文件存储成功key='+key+'\n'+'data='+data);
      return true;
    } catch (error) {
      debugPrint('文件存储失败' + error);
      return false;
    }
  }

  /**
   * @date 2018/10/30 10:10:57
   * @author:wz
   * @desc: 内存缓存对象
   **/

  static var _memData = Map<String, dynamic>();

  /**
   * @date 2018/10/30 10:11:09
   * @author:wz
   * @desc:保存到内存中
   **/
  static setMem(String key, data) async {
    Cache._memData[key] = data;
  }

  /**
   * @date 2018/10/30 10:11:27
   * @author:wz
   * @desc:从内存中加载
   */
  static getMem(key) {
    if (_memData.containsKey(key)) {
      return _memData[key];
    }
    return null;
  }

  static deleteMem(String key) {
    if (_memData.containsKey(key)) {
      _memData.remove(key);
    }
  }

  //读取缓存
  static getFile(key) async {
    try {
      var data = getMem(key);
      if (data != null) {
        return data;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      data = prefs.getString(key);
      setMem(key, data);
      return data;
    } catch (error) {
      debugPrint('文件读取失败' + error);
      return null;
    }
  }

  //删除缓存
  static deleteFile(key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
      deleteMem(key);
      return true;
    } catch (error) {
      debugPrint('文件删除失败' + error);
      return false;
    }
  }

  //删除所有缓存
  static deleteAllFile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return true;
    } catch (error) {
      debugPrint('文件删除失败' + error);
      return false;
    }
  }
}
