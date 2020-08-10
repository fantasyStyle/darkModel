/*
 * @Author: fantasy 
 * @Date: 2020-01-10 10:18:47 
 * @Last Modified by: fantasy
 * @Last Modified time: 2020-08-10 11:04:12
 * 设置夜间模式
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:darkModel/userSettings.dart';

class DarkMU extends StatefulWidget {
  @override
  _DarkMUState createState() => _DarkMUState();
}

class _DarkMUState extends State<DarkMU> {
  /// 夜间模式 0: 关闭 1: 开启 2: 随系统
  int _darkMode;

  static const Map<int, String> darkModeMap = {0: "关闭", 1: "开启", 2: "跟随系统"};

  _DarkMUState() : super() {
    init();
  }

//初始化数据
  init() async {
    UserSettings settings = await UserSettings.getUserSettings();
    _darkMode = settings.isShowDarkModelCacheKey ?? 0;
    debugPrint('当前的选择$_darkMode');
    if (!mounted) {
      return;
    }
    setState(() {});
  }

//列表单项显示g
  Widget singleItem(int index) {
    return GestureDetector(
        onTap: () async {
          _darkMode = index;
          Provider.of<DarkModeModel>(context, listen: false).changeMode(index);
          setState(() {});
        },
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.only(left: 30, right: 30),
          margin: EdgeInsets.only(bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(darkModeMap[index],
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        fontSize: 16)),
              ),
              _darkMode == index
                  ? Container(
                      child: Icon(
                        Icons.check,
                        color: Theme.of(context).textTheme.bodyText2.color,
                        size: 11.0,
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('夜间模式'),
        elevation: 0.0,
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          singleItem(0),
          singleItem(1),
          singleItem(2),
        ],
      ),
    );
  }
}

class DarkModeModel with ChangeNotifier {
  /// 夜间模式 0: 关闭 1: 开启 2: 随系统
  int _darkMode;

  DarkModeModel() {
    _init();
  }

  void _init() async {
    UserSettings settings = await UserSettings.getUserSettings();
    _darkMode = settings.isShowDarkModelCacheKey ?? 0;
    changeMode(_darkMode);
  }

  static const Map<int, String> darkModeMap = {0: "关闭", 1: "开启", 2: "跟随系统"};

  static const String STORE_KEY = 'darkMode';

  int get darkMode => _darkMode;

  void changeMode(int darkMode) async {
    _darkMode = darkMode;
    notifyListeners();
    await UserSettings.updateSingleSetting(
        {'isShowDarkModelCacheKey': darkMode});
  }
}
