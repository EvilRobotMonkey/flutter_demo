import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/res/gaps.dart';
import 'package:flutterapp/routers/fluro_navigator.dart';
import 'package:flutterapp/utils/theme_utils.dart';
import 'package:flutterapp/utils/toast.dart';
import 'package:flutterapp/widgets/app_bar.dart';
import 'package:flutterapp/widgets/my_button.dart';
import 'package:flutterapp/widgets/my_scroll_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_action.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../store_router.dart';

class StoreAuditPage extends StatefulWidget {
  @override
  _StoreAuditPageState createState() => _StoreAuditPageState();
}

class _StoreAuditPageState extends State<StoreAuditPage> {
  File _imageFile;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  String _address = '北京市 海淀区 中关村科技园';

  void _getLocalImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
    } catch (e) {
      Toast.show('没有权限，无法打开相册！');
    }
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
        nextFocus: true,
        actions: [
          KeyboardAction(
            focusNode: _nodeText1,
            displayDoneButton: false,
          ),
          KeyboardAction(
            focusNode: _nodeText2,
            displayDoneButton: false,
          ),
          KeyboardAction(focusNode: _nodeText2, toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: const Text('关闭'),
                ),
              );
            }
          ]),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '店铺审核资料',
      ),
      body: MyScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
        children: _buildBody(),
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
              text: '提交',
              onPressed: () {
                NavigatorUtils.push(context, StoreRouter.auditResultPage);
              }),
        ),
      ),
      resizeToAvoidBottomInset: defaultTargetPlatform != TargetPlatform.iOS,
    );
  }
}

_buildBody() {
  return [
    Gaps.vGap5,
  ];
}
