import 'dart:async';

import 'package:clean_architecture_sample/utility/error/unreachable.dart';
import 'package:clean_architecture_sample/utility/exception/illegal_use.dart';
import 'package:flutter/foundation.dart';

abstract class Option<V> {
  factory Option.some(V value) => _OptionSome(value);

  factory Option.none() => const _OptionNone();

  const Option();

  /// if test is true then build some value, else none value
  factory Option.fromCond(bool test, V value) {
    if (test) {
      return Option.some(value);
    } else {
      return Option.none();
    }
  }

  /// if test is true then build some value, else none value
  factory Option.fromCondLazy(bool test, V Function() value) {
    if (test) {
      return Option.some(value());
    } else {
      return Option.none();
    }
  }

  factory Option.fromNullable(V? value) {
    if (value != null) {
      return Option.some(value);
    } else {
      return Option.none();
    }
  }

  bool get isSome => this is _OptionSome<V>;

  bool get isNone => this is _OptionNone<V>;

  V getSomeOrThrow();

  V? getSomeOrNull();

  V getSomeOrElse(V Function() elseFn);

  W fold<W>(
    W Function(V value) onSome,
    W Function() onNone,
  );

  Option<W> map<W>(W Function(V value) onSome);

  Future<Option<W>> mapAsync<W>(Future<W> Function(V value) onSome);

  Option<W> flatMap<W>(Option<W> Function(V value) onSome);

  Future<Option<W>> flatMapAsync<W>(Future<Option<W>> Function(V value) onSome);
}

extension OptionWithFutureExt<V> on Option<Future<V>> {
  Future<Option<V>> liftUpFuture() async {
    final _result = this;
    if (_result is _OptionSome<Future<V>>) {
      final V value = await _result.value;
      return Option.some(value);
    }
    if (_result is _OptionNone<Future<V>>) {
      return Option.none();
    }

    throw UnreachableError();
  }
}

@immutable
class _OptionSome<V> extends Option<V> {
  final V value;

  const _OptionSome(this.value);

  @override
  String toString() {
    return "Option.Some($value)";
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _OptionSome<V> && other.value == value;

  @override
  V getSomeOrThrow() {
    return value;
  }

  @override
  V? getSomeOrNull() {
    return value;
  }

  @override
  V getSomeOrElse(V Function() elseFn) {
    return value;
  }

  @override
  W fold<W>(
    W Function(V value) onSome,
    W Function() onNone,
  ) {
    return onSome(value);
  }

  @override
  Option<W> map<W>(W Function(V value) onSome) {
    return Option.some(onSome(value));
  }

  @override
  Future<Option<W>> mapAsync<W>(Future<W> Function(V value) onSome) async {
    return Option.some(await onSome(value));
  }

  @override
  Option<W> flatMap<W>(Option<W> Function(V value) onSome) {
    return onSome(value);
  }

  @override
  Future<Option<W>> flatMapAsync<W>(
      Future<Option<W>> Function(V value) onSome) async {
    return await onSome(value);
  }
}

@immutable
class _OptionNone<V> extends Option<V> {
  const _OptionNone();

  @override
  String toString() {
    return "Option.None()";
  }

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(Object other) => other is _OptionNone<V>;

  @override
  V getSomeOrThrow() {
    throw const IllegalUseException("Option is None Value. Not Some.");
  }

  @override
  V? getSomeOrNull() {
    return null;
  }

  @override
  V getSomeOrElse(V Function() elseFn) {
    return elseFn();
  }

  @override
  W fold<W>(
    W Function(V value) onSome,
    W Function() onNone,
  ) {
    return onNone();
  }

  @override
  Option<W> map<W>(W Function(V value) onSome) {
    return Option.none();
  }

  @override
  Future<Option<W>> mapAsync<W>(Future<W> Function(V value) onSome) async {
    return Option.none();
  }

  @override
  Option<W> flatMap<W>(Option<W> Function(V value) onSome) {
    return Option.none();
  }

  @override
  Future<Option<W>> flatMapAsync<W>(
      Future<Option<W>> Function(V value) onSome) async {
    return Option.none();
  }
}