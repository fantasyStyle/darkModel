import 'package:darkModel/darkMU.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DarkModeModel()),
        ],
        child: Consumer<DarkModeModel>(
          builder: (context, darkmodeModel, _) {
            debugPrint('当前的模式${darkmodeModel.darkMode}');
            return MaterialApp(
              title: 'darkModel',
              supportedLocales: [
                //此处
                const Locale('zh', 'CH'),
                const Locale('en', 'US'),
              ],

              theme: ThemeData(
                  //brightness: Brightness.light,

                  ///主色调
                  primaryColor: Color(0xff1185ff),

                  //tabBarTheme样式
                  tabBarTheme: TabBarTheme(
                    labelColor: Color(0xff1185ff),
                  ),

                  ///分割线
                  dividerColor: Color(0xfff4f4f4),

                  ///标题文字颜色大小
                  textTheme: TextTheme(
                      //一级标题主要内容颜色
                      bodyText2: TextStyle(
                        color: Color(0xff2f2f2f),
                      ),
                      //辅助性文字,时间
                      bodyText1: TextStyle(
                        color: Color(0xff888888),
                      ),
                     ),

                  ///标题栏样式
                  appBarTheme: AppBarTheme(
                    color: Color(0xff1185ff), //标题栏颜色背景色
                    elevation: 0.0, //标题栏的阴影
                    textTheme: TextTheme(
                      //标题栏文字样式
                      headline6: TextStyle(
                        fontSize: 17,
                        color: Color(0xffffffff), //标题文字颜色
                      ),
                    ),
                  ),
                  cursorColor: Colors.black, //例如TextField中的光标颜色
                  hintColor: Color(0xffa9a9a9), //例如TextField中提示文字的颜色
                  //TextField样式
                  inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xffa9a9a9),
                    ),
                  ),

                  ///scaffold的背景色
                  scaffoldBackgroundColor: Color(0xffffffff),
                  backgroundColor: Color(0xfff4f4f4)),
              darkTheme: darkmodeModel.darkMode == 0
                  ? null
                  : ThemeData(
                      brightness: Brightness.dark,

                      ///主色调
                      primaryColor: Color(0xff303030),

                      //tabBarTheme样式
                      tabBarTheme: TabBarTheme(
                        labelColor: Color(0xff1185ff),
                      ),

                      ///分割线
                      dividerColor: Colors.grey[850],

                      ///标题文字颜色大小
                      textTheme: TextTheme(
                          //一级标题主要内容颜色
                          bodyText2: TextStyle(
                            color: Color(0xffffffff),
                          ),
                          //辅助性文字,时间
                          bodyText1: TextStyle(
                            color: Colors.white60,
                          ),
                      ),

                      ///标题栏样式
                      appBarTheme: AppBarTheme(
                        color: Color(0xff303030), //标题栏颜色背景色
                        elevation: 0.0, //标题栏的阴影
                        textTheme: TextTheme(
                          //标题栏文字样式
                          headline6: TextStyle(
                            fontSize: 17,
                            color: Color(0xffffffff), //标题文字颜色
                          ),
                        ),
                      ),
                      cursorColor: Colors.black, //例如TextField中的光标颜色
                      hintColor: Color(0xffa9a9a9), //例如TextField中提示文字的颜色
                      //TextField样式
                      inputDecorationTheme: InputDecorationTheme(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xffa9a9a9),
                        ),
                      ),

                      ///scaffold的背景色
                      scaffoldBackgroundColor: Colors.black87,
                      backgroundColor: Colors.grey[900]),
              routes: {
                //定义路由的时候‘/’表示路由的根或者初始路由，默认显示的
                '/': (context) => DarkMU(),
              },
            );
          },
        ));
  }
}

