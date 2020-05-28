import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'application.dart';

class NavigatorUtils {
  static void push(BuildContext context, page,
    {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, page, replace: replace, clearStack: clearStack, transition: TransitionType.native);

    }
}
