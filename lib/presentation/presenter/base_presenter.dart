import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BasePresenter extends ChangeNotifier {
  StreamController<String> _errorNotifier;
  StreamSubscription<String>? _errorSubscriber;

  BasePresenter()
      : _errorNotifier = StreamController(sync: true),
        super();

  @override
  void dispose() {
    _errorNotifier.close();
    _errorSubscriber?.cancel();
    _errorSubscriber = null;
    super.dispose();
  }

  void watchError(void Function(String errorMessage) onListen) {
    _errorSubscriber?.cancel();
    _errorNotifier.close();
    _errorNotifier = StreamController(sync: true);

    _errorSubscriber = _errorNotifier.stream.listen(onListen);
  }

  void notifyError(String message) {
    _errorNotifier.sink.add(message);
  }
}
