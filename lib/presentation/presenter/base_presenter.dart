import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BasePresenter extends ChangeNotifier {
  StreamController<String>? _errorNotifier;

  BasePresenter()
      : _errorNotifier = StreamController(sync: true),
        super();

  @override
  void dispose() {
    _errorNotifier?.close();
    _errorNotifier = null;
    super.dispose();
  }

  void watchError(void Function(String errorMessage) onListen) {
    _errorNotifier?.stream.asBroadcastStream().listen(onListen);
  }

  void notifyError(String message) {
    _errorNotifier?.sink.add(message);
  }
}
