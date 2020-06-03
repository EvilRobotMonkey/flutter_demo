import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/common/common.dart';
import 'package:flutterapp/login/login_router.dart';
import 'package:flutterapp/provider/theme_provider.dart';
import 'package:flutterapp/routers/fluro_navigator.dart';
import 'package:flutterapp/utils/image_utils.dart';
import 'package:flutterapp/utils/theme_utils.dart';
import 'package:flutterapp/widgets/load_image.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 1;
  List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SpUtil.getInstance();
      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true))
        _guideList.forEach((image) {
          //预加载 图片
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      _initSplash();
    });
  }

  //更新
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //更新
  @override
  void didUpdateWidget(SplashPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  //销毁
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  //销毁
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: ThemeUtils.getBackgroundColor(context),
        child: _status == 0
            ? FractionallySizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                child: const LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: true,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goLogin();
                  }
                },
              ));
  }

  void _initSplash() {
    print("_initSplash");
    _subscription =
        Stream.value(1).delay(Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  _goLogin() {

    NavigatorUtils.push(context, LoginRouter.loginPage, replace: false);
  }
}
