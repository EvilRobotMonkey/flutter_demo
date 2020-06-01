import 'package:flutter/cupertino.dart';
import 'bloc_base.dart';

Type _typeOf<T>() => T;

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  @override
  State createState() => BlocProviderState<T>();
  final Widget child;
  final List<T> blocs;


  BlocProvider({
    Key key,
    @required this.child,
    @required this.blocs
  }) : super(key: key);

  static List<T> of<T extends BlocBase>(BuildContext context) {
    var type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context
            .ancestorInheritedElementForWidgetOfExactType(type)
            .widget;
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
    @required child: widget.child,
    @required blocs: widget.blocs,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  final List<T> blocs;

  _BlocProviderInherited({Key key, Widget child, this.blocs}) : super(key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
