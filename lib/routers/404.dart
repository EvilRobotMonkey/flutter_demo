import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/app_bar.dart';
import 'package:flutterapp/widgets/state_layout.dart';

class WidgetNotFound extends StatelessWidget {
  static void onpress() {
    print("hello world");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
        actionName: "取消",
        onPressed: onpress,
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: '页面不存在',
      ),
    );
  }
}
