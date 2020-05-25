import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/res/colors.dart';
import 'package:flutterapp/res/dimens.dart';
import 'package:flutterapp/res/gaps.dart';
import 'package:flutterapp/utils/theme_utils.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  const MyAppBar(
      {Key key,
      this.backgroundColor,
      this.title: '',
      this.centerTitle: '',
      this.backImg: 'assets/images/ic_back_black.png',
      this.actionName: '',
      this.onPressed,
      this.isBack: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    var back = isBack
        ? IconButton(
            onPressed: () {
              /*设置 获取焦点*/
              // FocusScope.of(context).requestFocus(focus1);
              /*传入空的焦点 则隐藏键盘*/
              // FocusScope.of(context).requestFocus(FocusNode());
              FocusScope.of(context).unfocus();
              /**
         * pop 导航到新页面，或者返回到上个页面。
         * canPop 判断是否可以导航到新页面
         * maybePop 可能会导航到新页面
         */
              Navigator.maybePop(context);
            },
            tooltip: 'Back',
            /**
       *fromLTRB(double left, double top, double right, double
       * bottom)：分别指定四个方向的填充。
       * all(double value) : 所有方向均使用相同数值的填充。
       * only({left, top, right ,bottom })：可以设置具体某个方向的填充(可以同时指定多个方向)。
       * symmetric({vertical, horizontal})：用于设置对称方向的填充，vertical指top和bottom，horizontal指left和right
       */
            padding: const EdgeInsets.all(12.0),
            icon: Image.asset(
              backImg,
              color: ThemeUtils.getIconColor(context),
            ),
          )
        : Gaps.empty;

    /**
     * Positioned()用在Stack()组件中
     * Positioned组件的属性
     *  bottom: 距离层叠组件下边的距离
     *  left：距离层叠组件左边的距离
     *  top：距离层叠组件上边的距离
     *  right：距离层叠组件右边的距离
     *  width: 层叠定位组件的宽度
     *  height: 层叠定位组件的高度

        类似 Stack
     */
    var action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      minWidth: 60.0)),
              child: FlatButton(
                child: Text(actionName, key: const Key("actionName")),
                textColor: ThemeUtils.isDark(context)
                    ? Colours.dark_text
                    : Colours.text,
                highlightColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.empty;

    var titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(title.isEmpty ? centerTitle : title,
            style: TextStyle(
              fontSize: Dimens.font_sp18,
            )),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(48.0);
}
