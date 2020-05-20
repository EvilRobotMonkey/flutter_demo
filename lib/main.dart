import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/routers/application.dart';
import 'package:flutterapp/routers/routers.dart';
import 'package:flutterapp/utils/Device.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/utils/log_utils.dart';

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
    // TODO: implement build
    throw UnimplementedError();
  }
}
