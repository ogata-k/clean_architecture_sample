import 'dart:async';

import 'package:clean_architecture_sample/utility/error/unreachable.dart';
import 'package:clean_architecture_sample/utility/exception/illegal_use.dart';
import 'package:flutter/foundation.dart';

abstract class Either<Left, Right> {
  factory Either.left(Left value) => _EitherLeft(value);

  factory Either.right(Right value) => _EitherRight(value);

  const Either();

  /// if test is true then build left value, else right value
  factory Either.fromCond(bool test, Left left, Right right) {
    if (test) {
      return Either.left(left);
    } else {
      return Either.right(right);
    }
  }

  /// if test is true then build left value, else right value
  factory Either.fromCondLazy(
      bool test, Left Function() left, Right Function() right) {
    if (test) {
      return Either.left(left());
    } else {
      return Either.right(right());
    }
  }

  bool get isLeft => this is _EitherLeft<Left, Right>;

  bool get isRight => this is _EitherRight<Left, Right>;

  Left getLeftOrThrow();

  Left? getLeftOrNull();

  Right getRightOrThrow();

  Right? getRightOrNull();

  V fold<V>(
    V Function(Left value) onLeft,
    V Function(Right value) onRight,
  );

  Either<L, Right> mapLeft<L>(L Function(Left value) onLeft);

  Either<Left, R> mapRight<R>(R Function(Right value) onRight);

  Either<L, R> apply<L, R>(
    L Function(Left value) onLeft,
    R Function(Right value) onRight,
  );

  Future<Either<L, Right>> mapLeftAsync<L>(
      Future<L> Function(Left value) onLeft);

  Future<Either<Left, R>> mapRightAsync<R>(
      Future<R> Function(Right value) onRight);

  Future<Either<L, R>> applyAsync<L, R>(
    Future<L> Function(Left value) onLeft,
    Future<R> Function(Right value) onRight,
  );

  Either<L, Right> flatMapLeft<L>(Either<L, Right> Function(Left value) onLeft);

  Either<Left, R> flatMapRight<R>(
      Either<Left, R> Function(Right value) onRight);

  Either<L, R> applyFlatMap<L, R>(
    Either<L, R> Function(Left value) onLeft,
    Either<L, R> Function(Right value) onRight,
  );

  Future<Either<L, Right>> flatMapLeftAsync<L>(
      Future<Either<L, Right>> Function(Left value) onLeft);

  Future<Either<Left, R>> flatMapRightAsync<R>(
      Future<Either<Left, R>> Function(Right value) onRight);

  Future<Either<L, R>> applyFlatMapAsync<L, R>(
    Future<Either<L, R>> Function(Left value) onLeft,
    Future<Either<L, R>> Function(Right value) onRight,
  );

  Either<Right, Left> swap();

  AsyncEither<Left, Right> asAsync() {
    return Future.value(this);
  }
}

extension EitherWithFutureLeftExt<Left, Right> on Either<Future<Left>, Right> {
  Future<Either<Left, Right>> liftUpFutureLeft() async {
    final _either = this;
    if (_either is _EitherLeft<Future<Left>, Right>) {
      final Left value = await _either.value;
      return Either.left(value);
    }
    if (_either is _EitherRight<Future<Left>, Right>) {
      final Right value = _either.value;
      return Either.right(value);
    }

    throw UnreachableError();
  }
}

extension EitherWithFutureRightExt<Left, Right> on Either<Left, Future<Right>> {
  Future<Either<Left, Right>> liftUpFutureRight() async {
    final _either = this;
    if (_either is _EitherLeft<Left, Future<Right>>) {
      final Left value = _either.value;
      return Either.left(value);
    }
    if (_either is _EitherRight<Left, Future<Right>>) {
      final Right value = await _either.value;
      return Either.right(value);
    }

    throw UnreachableError();
  }
}

extension EitherWithFutureExt<Left, Right>
    on Either<Future<Left>, Future<Right>> {
  Future<Either<Left, Right>> liftUpFuture() async {
    final _either = this;
    if (_either is _EitherLeft<Future<Left>, Future<Right>>) {
      final Left value = await _either.value;
      return Either.left(value);
    }
    if (_either is _EitherRight<Future<Left>, Future<Right>>) {
      final Right value = await _either.value;
      return Either.right(value);
    }

    throw UnreachableError();
  }
}

@immutable
class _EitherLeft<Left, Right> extends Either<Left, Right> {
  final Left value;

  const _EitherLeft(this.value);

  @override
  String toString() {
    return "Either.Left($value)";
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _EitherLeft<Left, Right> && other.value == value;

  @override
  Left getLeftOrThrow() {
    return value;
  }

  @override
  Left? getLeftOrNull() {
    return value;
  }

  @override
  Right getRightOrThrow() {
    throw IllegalUseException(
        "Either is Left Value with the value($value). Not Right.");
  }

  @override
  Right? getRightOrNull() {
    return null;
  }

  @override
  V fold<V>(
    V Function(Left value) onLeft,
    V Function(Right value) onRight,
  ) {
    return onLeft(value);
  }

  @override
  Either<L, Right> mapLeft<L>(L Function(Left value) onLeft) {
    return Either.left(onLeft(value));
  }

  @override
  Either<Left, R> mapRight<R>(R Function(Right value) onRight) {
    return Either.left(value);
  }

  @override
  Either<L, R> apply<L, R>(
    L Function(Left value) onLeft,
    R Function(Right value) onRight,
  ) {
    return Either.left(onLeft(value));
  }

  @override
  Future<Either<L, Right>> mapLeftAsync<L>(
      Future<L> Function(Left value) onLeft) async {
    return Either.left(await onLeft(value));
  }

  @override
  Future<Either<Left, R>> mapRightAsync<R>(
      Future<R> Function(Right value) onRight) async {
    return Either.left(value);
  }

  @override
  Future<Either<L, R>> applyAsync<L, R>(
    Future<L> Function(Left value) onLeft,
    Future<R> Function(Right value) onRight,
  ) async {
    return Either.left(await onLeft(value));
  }

  @override
  Either<L, Right> flatMapLeft<L>(
      Either<L, Right> Function(Left value) onLeft) {
    return onLeft(value);
  }

  @override
  Either<Left, R> flatMapRight<R>(
      Either<Left, R> Function(Right value) onRight) {
    return Either.left(value);
  }

  @override
  Either<L, R> applyFlatMap<L, R>(
    Either<L, R> Function(Left value) onLeft,
    Either<L, R> Function(Right value) onRight,
  ) {
    return onLeft(value);
  }

  @override
  Future<Either<L, Right>> flatMapLeftAsync<L>(
      Future<Either<L, Right>> Function(Left value) onLeft) async {
    return await onLeft(value);
  }

  @override
  Future<Either<Left, R>> flatMapRightAsync<R>(
      Future<Either<Left, R>> Function(Right value) onRight) async {
    return Either.left(value);
  }

  @override
  Future<Either<L, R>> applyFlatMapAsync<L, R>(
    Future<Either<L, R>> Function(Left value) onLeft,
    Future<Either<L, R>> Function(Right value) onRight,
  ) async {
    return await onLeft(value);
  }

  @override
  Either<Right, Left> swap() {
    return Either.right(value);
  }
}

@immutable
class _EitherRight<Left, Right> extends Either<Left, Right> {
  final Right value;

  const _EitherRight(this.value);

  @override
  String toString() {
    return "Either.Right($value)";
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _EitherRight<Left, Right> && other.value == value;

  @override
  Left getLeftOrThrow() {
    throw IllegalUseException(
        "Either is Right Value with the value($value). Not Left.");
  }

  @override
  Left? getLeftOrNull() {
    return null;
  }

  @override
  Right getRightOrThrow() {
    return value;
  }

  @override
  Right? getRightOrNull() {
    return value;
  }

  @override
  V fold<V>(
    V Function(Left value) onLeft,
    V Function(Right value) onRight,
  ) {
    return onRight(value);
  }

  @override
  Either<L, Right> mapLeft<L>(L Function(Left value) onLeft) {
    return Either.right(value);
  }

  @override
  Either<Left, R> mapRight<R>(R Function(Right value) onRight) {
    return Either.right(onRight(value));
  }

  @override
  Either<L, R> apply<L, R>(
    L Function(Left value) onLeft,
    R Function(Right value) onRight,
  ) {
    return Either.right(onRight(value));
  }

  @override
  Future<Either<L, Right>> mapLeftAsync<L>(
      Future<L> Function(Left value) onLeft) async {
    return Either.right(value);
  }

  @override
  Future<Either<Left, R>> mapRightAsync<R>(
      Future<R> Function(Right value) onRight) async {
    return Either.right(await onRight(value));
  }

  @override
  Future<Either<L, R>> applyAsync<L, R>(
    Future<L> Function(Left value) onLeft,
    Future<R> Function(Right value) onRight,
  ) async {
    return Either.right(await onRight(value));
  }

  @override
  Either<L, Right> flatMapLeft<L>(
      Either<L, Right> Function(Left value) onLeft) {
    return Either.right(value);
  }

  @override
  Either<Left, R> flatMapRight<R>(
      Either<Left, R> Function(Right value) onRight) {
    return onRight(value);
  }

  @override
  Either<L, R> applyFlatMap<L, R>(
    Either<L, R> Function(Left value) onLeft,
    Either<L, R> Function(Right value) onRight,
  ) {
    return onRight(value);
  }

  @override
  Future<Either<L, Right>> flatMapLeftAsync<L>(
      Future<Either<L, Right>> Function(Left value) onLeft) async {
    return Either.right(value);
  }

  @override
  Future<Either<Left, R>> flatMapRightAsync<R>(
      Future<Either<Left, R>> Function(Right value) onRight) async {
    return onRight(value);
  }

  @override
  Future<Either<L, R>> applyFlatMapAsync<L, R>(
    Future<Either<L, R>> Function(Left value) onLeft,
    Future<Either<L, R>> Function(Right value) onRight,
  ) async {
    return await onRight(value);
  }

  @override
  Either<Right, Left> swap() {
    return Either.left(value);
  }
}

typedef AsyncEither<Left, Right> = Future<Either<Left, Right>>;

extension AsyncEitherExt<Left, Right> on AsyncEither<Left, Right> {
  Future<bool> get isLeft => then((either) => either.isLeft);

  Future<bool> get isRight => then((either) => either.isRight);

  Future<Left> getLeftOrThrow() {
    return then((either) => either.getLeftOrThrow());
  }

  Future<Left?> getLeftOrNull() {
    return then((either) => either.getLeftOrNull());
  }

  Future<Right> getRightOrThrow() {
    return then((either) => either.getRightOrThrow());
  }

  Future<Right?> getRightOrNull() {
    return then((either) => either.getRightOrNull());
  }

  Future<V> fold<V>(
    V Function(Left value) onLeft,
    V Function(Right value) onRight,
  ) {
    return then((either) => either.fold(onLeft, onRight));
  }

  AsyncEither<L, Right> mapLeft<L>(L Function(Left value) onLeft) {
    return then((either) => either.mapLeft(onLeft));
  }

  AsyncEither<Left, R> mapRight<R>(R Function(Right value) onRight) {
    return then((either) => either.mapRight(onRight));
  }

  AsyncEither<L, R> apply<L, R>(
    L Function(Left value) onLeft,
    R Function(Right value) onRight,
  ) {
    return then((either) => either.apply(onLeft, onRight));
  }

  AsyncEither<L, Right> mapLeftAsync<L>(Future<L> Function(Left value) onLeft) {
    return then((either) => either.mapLeftAsync(onLeft));
  }

  AsyncEither<Left, R> mapRightAsync<R>(
      Future<R> Function(Right value) onRight) {
    return then((either) => either.mapRightAsync(onRight));
  }

  AsyncEither<L, R> applyAsync<L, R>(
    Future<L> Function(Left value) onLeft,
    Future<R> Function(Right value) onRight,
  ) {
    return then((either) => either.applyAsync(onLeft, onRight));
  }

  AsyncEither<L, Right> flatMapLeft<L>(
      Either<L, Right> Function(Left value) onLeft) {
    return then((either) => either.fold(onLeft, Either.right));
  }

  AsyncEither<Left, R> flatMapRight<R>(
      Either<Left, R> Function(Right value) onRight) {
    return then((either) => either.fold(Either.left, onRight));
  }

  AsyncEither<L, R> applyFlatMap<L, R>(
    Either<L, R> Function(Left value) onLeft,
    Either<L, R> Function(Right value) onRight,
  ) {
    return then((either) => either.fold(onLeft, onRight));
  }

  AsyncEither<L, Right> flatMapLeftAsync<L>(
      Future<Either<L, Right>> Function(Left value) onLeft) {
    return then((either) => either.fold(
          (value) async => await onLeft(value),
          (value) async => Either.right(value),
        ));
  }

  AsyncEither<Left, R> flatMapRightAsync<R>(
      Future<Either<Left, R>> Function(Right value) onRight) {
    return then((either) => either.fold(
          (value) async => Either.left(value),
          (value) async => await onRight(value),
        ));
  }

  AsyncEither<L, R> applyFlatMapAsync<L, R>(
    Future<Either<L, R>> Function(Right value) onRight,
    Future<Either<L, R>> Function(Left value) onLeft,
  ) {
    return then((either) => either.fold(
          (value) async => await onLeft(value),
          (value) async => await onRight(value),
        ));
  }

  AsyncEither<Right, Left> swap() {
    return then((either) => either.swap());
  }
}
