import 'dart:async';

import 'package:flutter/cupertino.dart';

class SplashPage extends StatefulWidget {
  final String value = "hello";

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _streamSubscription;

  @override
  Widget build(BuildContext context) {
//    return
  }
}
