import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterapp/provider/theme_provider.dart';
import 'package:flutterapp/routers/application.dart';
import 'package:flutterapp/routers/routers.dart';
import 'package:flutterapp/utils/Device.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/utils/log_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'home/splash_page.dart';

void main() {
  runApp(MyApp());

  if (Device.isAndroid) {
    //设置状态栏目为透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent); //构造函数传 可变参数 声明时 可变参数 用{} 包装
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home}) {
    //日志工具初始化 相对于Android 在Application 中初始化 这个直接在 main 的构造函数实现
    Log.init();
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: Consumer<ThemeProvider>(builder: (_, provider, __) {
            return MaterialApp(
              title: "flutter deer",
//              showPerformanceOverlay: false, //显示性能标签
              debugShowCheckedModeBanner: false,
              // 去除右上角debug的标签
//              checkerboardRasterCacheImages: true,
//              showSemanticsDebugger: true, // 显示语义视图
//              checkerboardOffscreenLayers: false, // 检查离屏渲染
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: home ?? SplashPage(),
              onGenerateRoute: Application.router.generator,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('zh', 'CH'), Locale('en', 'US')],
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
            );
          },
           //还有个 child 熟悉 在状态改变 child 属性下 页面不会走build方法
          )),
    );
  }
}
