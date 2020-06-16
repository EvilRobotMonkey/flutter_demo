import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/home/home_page.dart';
import 'package:flutterapp/login/login_router.dart';
import 'package:flutterapp/routers/404.dart';
import 'package:flutterapp/routers/router_init.dart';
import 'package:flutterapp/store/store_router.dart';

class Routes {
  static String home = '/home';
  static String webViewPage = '/webview';
  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    //配置路由表
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return WidgetNotFound();
    });
    router.define(home, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return null;
    }));
    _listRouter.clear();
    _listRouter.add(LoginRouter());
    _listRouter.add(StoreRouter());
    _listRouter.forEach((element) {
      element.initRouter(router);
    });
  }
}
