import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutterapp/login/page/login_page.dart';
import 'package:flutterapp/routers/router_init.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';

  @override
  void initRouter(Router router) {
    print("初始化 登陆页面路由");
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
  }
}
