import 'dart:async';

import 'package:clean_architecture_sample/utility/error/unreachable.dart';
import 'package:clean_architecture_sample/utility/exception/illegal_use.dart';
import 'package:flutter/foundation.dart';

abstract class Option<V extends Object> {
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

  bool get isSome => this is _OptionSome<V>;

  bool get isNone => this is _OptionNone<V>;

  V getSomeOrThrow();

  V? getSomeOrNull();

  V getSomeOrElse(V Function() elseFn);

  W fold<W extends Object>(
    W Function(V value) onSome,
    W Function() onNone,
  );

  Option<W> map<W extends Object>(W Function(V value) onSome);

  Future<Option<W>> mapAsync<W extends Object>(
      FutureOr<W> Function(V value) onSome);

  Option<W> flatMap<W extends Object>(Option<W> Function(V value) onSome);

  Future<Option<W>> flatMapAsync<W extends Object>(
      FutureOr<Option<W>> Function(V value) onSome);

  AsyncOption<V> asAsync() {
    return Future.value(this);
  }
}

extension OptionWithFutureExt<V extends Object> on Option<Future<V>> {
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
class _OptionSome<V extends Object> extends Option<V> {
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
  W fold<W extends Object>(
    W Function(V value) onSome,
    W Function() onNone,
  ) {
    return onSome(value);
  }

  @override
  Option<W> map<W extends Object>(W Function(V value) onSome) {
    return Option.some(onSome(value));
  }

  @override
  Future<Option<W>> mapAsync<W extends Object>(
      FutureOr<W> Function(V value) onSome) async {
    return Option.some(await onSome(value));
  }

  @override
  Option<W> flatMap<W extends Object>(Option<W> Function(V value) onSome) {
    return onSome(value);
  }

  @override
  Future<Option<W>> flatMapAsync<W extends Object>(
      FutureOr<Option<W>> Function(V value) onSome) async {
    return await onSome(value);
  }
}

@immutable
class _OptionNone<V extends Object> extends Option<V> {
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
  W fold<W extends Object>(
    W Function(V value) onSome,
    W Function() onNone,
  ) {
    return onNone();
  }

  @override
  Option<W> map<W extends Object>(W Function(V value) onSome) {
    return Option.none();
  }

  @override
  Future<Option<W>> mapAsync<W extends Object>(
      FutureOr<W> Function(V value) onSome) async {
    return Option.none();
  }

  @override
  Option<W> flatMap<W extends Object>(Option<W> Function(V value) onSome) {
    return Option.none();
  }

  @override
  Future<Option<W>> flatMapAsync<W extends Object>(
      FutureOr<Option<W>> Function(V value) onSome) async {
    return Option.none();
  }
}

typedef AsyncOption<V extends Object> = Future<Option<V>>;

extension AsyncOptionExt<V extends Object> on AsyncOption<V> {
  Future<bool> get isSome => then((option) => option.isSome);

  Future<bool> get isNone => then((option) => option.isNone);

  Future<V> getSomeOrThrow() {
    return then((option) => option.getSomeOrThrow());
  }

  Future<V?> getSomeOrNull() {
    return then((option) => option.getSomeOrNull());
  }

  Future<V> getSomeOrElse(FutureOr<V> Function() elseFn) {
    return then(
        (option) => option.fold((v) async => v, () async => await elseFn()));
  }

  Future<W> fold<W extends Object>(
    FutureOr<W> Function(V value) onSome,
    FutureOr<W> Function() onNone,
  ) {
    return then((option) => option.fold(onSome, onNone));
  }

  AsyncOption<W> map<W extends Object>(W Function(V value) onSome) {
    return then((option) => option.map(onSome));
  }

  AsyncOption<W> mapAsync<W extends Object>(
      FutureOr<W> Function(V value) onSome) {
    return then((option) =>
        option.map((value) async => await onSome(value)).liftUpFuture());
  }

  AsyncOption<W> flatMap<W extends Object>(Option<W> Function(V value) onSome) {
    return then((option) => option.flatMap(onSome));
  }

  AsyncOption<W> flatMapAsync<W extends Object>(
      FutureOr<Option<W>> Function(V value) onSome) {
    return then(
        (option) => option.flatMapAsync((value) async => await onSome(value)));
  }
}
