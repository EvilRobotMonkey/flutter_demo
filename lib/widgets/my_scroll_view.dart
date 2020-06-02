import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class MyScrollView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget bottomButton;
  final KeyboardActionsConfig keyboardConfig;

  /// 键盘外部按下将其关闭
  final bool tapOutsideToDismiss;

  /// 默认弹起位置在TextField的文字下面，可以添加此属性继续向上滑动一段距离。用来露出完整的TextField。
  final double overScroll;

  const MyScrollView({
    Key key,
    this.children,
    this.padding,
//      BouncingScrollPhysics ：允许滚动超出边界，但之后内容会反弹回来。
//      ClampingScrollPhysics ： 防止滚动超出边界，夹住 。
//      AlwaysScrollableScrollPhysics ：始终响应用户的滚动。
//      NeverScrollableScrollPhysics ：不响应用户的滚动。
    this.physics: const BouncingScrollPhysics(),
//      MainAxisAlignment是水平的，默认起始位置在左边，排列方向为从左至右，此时可以通过textDirection来改变MainAxisAlignment的起始位置和排列方向
//      CrossAxisAlignment是垂直的，默认起始位置在中间，排列方向为从上至下，此时可以通过verticalDirection来改变CrossAxisAlignment的起始位置及排列方向
    this.crossAxisAlignment: CrossAxisAlignment.start,
    this.bottomButton,
    this.keyboardConfig,
    this.tapOutsideToDismiss: false,
    this.overScroll: 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget contents = Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
    if (defaultTargetPlatform == TargetPlatform.iOS && keyboardConfig != null) {
      if (padding != null) {
        contents = Padding(
          padding: padding,
          child: contents,
        );
      }
      contents = KeyboardActions(
          isDialog: bottomButton != null,
          overscroll: overScroll,
          config: keyboardConfig,
          tapOutsideToDismiss: tapOutsideToDismiss,
          child: contents);
    } else {
      contents = SingleChildScrollView(
        padding: padding,
        physics: physics,
        child: contents,
      );
    }
    if (bottomButton != null) {
      contents = Column(
        children: <Widget>[
          Expanded(
            child: contents,
          ),
          SafeArea(
            child: bottomButton,
          )
        ],
      );
    }

    return contents;
  }
}
