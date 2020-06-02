import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class CounterBloc extends BlocBase {
  StreamController<int> _controller = StreamController();

  StreamSink get _counter => _controller.sink; //输入
  Stream get counter => _controller.stream; //流出

  void increment(int count) {
    _counter.add(++count);
  }

  @override
  void dispost() {
    // TODO: implement dispost
    _controller.close();
  }

//  void callBack() {
//    this.counter.listen((event) {
//      print(event.toString());
//    });
//  }
}
