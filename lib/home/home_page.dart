import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/home/provider/home_provider.dart';
import 'package:flutterapp/utils/double_tap_back_exit_app.dart';
import 'package:flutterapp/utils/theme_utils.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeProvider provider = HomeProvider();

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    HomeProvider provider = HomeProvider();

    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(),
          body: PageView(),
        ),
      ),
    );
  }
}
