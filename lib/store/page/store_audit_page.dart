import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/res/dimens.dart';
import 'package:flutterapp/res/gaps.dart';
import 'package:flutterapp/res/styles.dart';
import 'package:flutterapp/routers/fluro_navigator.dart';
import 'package:flutterapp/utils/theme_utils.dart';
import 'package:flutterapp/utils/toast.dart';
import 'package:flutterapp/widgets/app_bar.dart';
import 'package:flutterapp/widgets/my_button.dart';
import 'package:flutterapp/widgets/my_scroll_view.dart';
import 'package:flutterapp/widgets/selected_image.dart';
import 'package:flutterapp/widgets/store_select_text_item.dart';
import 'package:flutterapp/widgets/text_field_item.dart';
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

  void _getImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);

      print(_imageFile.path);
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

  _buildBody() {
    return [
      Gaps.vGap5,
      const Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: const Text('店铺资料', style: TextStyles.textBold18),
      ),
      Gaps.vGap16,
      Center(
        child: SelectedImage(image: _imageFile, onTap: _getImage),
      ),
      Gaps.vGap10,
      Center(
        child: Text('店主手持身份证或营业执照',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: Dimens.font_sp14)),
      ),
      Gaps.vGap16,
      TextFieldItem(focusNode: _nodeText1, title: '店铺名称', hintText: '填写店铺名称'),
      StoreSelectTextItem(
          title: '主营范围', content: _sortName, onTap: () => _showBottomSheet()),
      StoreSelectTextItem(
        title: '店铺地址',
        content: _address,
        onTap: () {
//          NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage, (result) {
//            setState(() {
//              PoiSearch model = result;
//              _address = model.provinceName + ' ' +
//                  model.cityName + ' ' +
//                  model.adName + ' ' +
//                  model.title;
//            });
//          });
        },
      ),
      Gaps.vGap32,
      const Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: const Text('店主信息', style: TextStyles.textBold18),
      ),
      Gaps.vGap16,
      TextFieldItem(focusNode: _nodeText2, title: '店主姓名', hintText: '填写店主姓名'),
      TextFieldItem(
          focusNode: _nodeText3,
          keyboardType: TextInputType.phone,
          title: '联系电话',
          hintText: '填写店主联系电话')
    ];
  }

  String _sortName = '';
  var _list = [
    '水果生鲜',
    '家用电器',
    '休闲食品',
    '茶酒饮料',
    '美妆个护',
    '粮油调味',
    '家庭清洁',
    '厨具用品',
    '儿童玩具',
    '床上用品'
  ];

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 360.0,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(_list[index]),
                  ),
                  onTap: () {
                    setState(() {
                      _sortName = _list[index];
                    });
                    NavigatorUtils.goBack(context);
                  },
                );
              },
              itemExtent: 48.0,
              itemCount: _list.length,
            ),
          );
        });
  }
}
