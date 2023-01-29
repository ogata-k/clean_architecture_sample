import 'package:meta/meta.dart';

@sealed
class Nothing {
  const Nothing._();

  static Nothing unit() => _nothing;
}

const Nothing _nothing = Nothing._();
