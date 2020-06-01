import 'dart:async';
import 'package:rxdart/rxdart.dart';

class CounterBloc {
  StreamController<int> _controller = StreamController();

  StreamSink get _counter => _controller.sink; //输入
  Stream get counter => _controller.stream; //流出

  void increment(int count) {
    _counter.add(++count);
  }

//  void callBack() {
//    this.counter.listen((event) {
//      print(event.toString());
//    });
//  }
}
