import 'package:flutter/cupertino.dart';
import 'bloc_base.dart';

/**
 * BlockProvider 复杂写法
 * https://www.jianshu.com/p/ff471e41f978
 * 目的是：其子Widget都能访问BlocProvider的内部数据.
 */

Type _typeOf<T>() => T;

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  @override
  State createState() => BlocProviderState<T>();
  final Widget child;
  final List<T> blocs;

  BlocProvider({Key key, @required this.child, @required this.blocs})
      : super(key: key);

  static List<T> of<T extends BlocBase>(BuildContext context) {
    var type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type).widget;
    return provider.blocs;
  }
}

class BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    // TODO: implement dispose
    widget.blocs.map((e) => e.dispost());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      child: widget.child,
      blocs: widget.blocs,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  final List<T> blocs;

  _BlocProviderInherited({Key key, Widget child, this.blocs}) : super(key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
