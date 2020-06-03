import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/res/colors.dart';
import 'package:flutterapp/utils/image_utils.dart';
import 'package:flutterapp/utils/theme_utils.dart';

class SelectedImage extends StatelessWidget {
  final double size;
  final GestureTapCallback onTap;
  final File image;

  SelectedImage({Key key, this.size: 80.0, this.onTap, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: image == null
                      ? ImageUtils.getAssetImage('store/icon_zj')
                      : FileImage(image),
                  fit: BoxFit.cover,
                  colorFilter: image == null
                      ? ColorFilter.mode(
                          ThemeUtils.getDarkColor(
                              context, Colours.dark_unselected_item_color),
                          BlendMode.srcIn)
                      : null)),
        ),
      ),
    );
  }
}
