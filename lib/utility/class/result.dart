import 'dart:async';

import 'package:clean_architecture_sample/utility/error/unreachable.dart';
import 'package:clean_architecture_sample/utility/exception/illegal_use.dart';
import 'package:flutter/foundation.dart';

abstract class Result<Success extends Object> {
  factory Result.success(Success value) => _ResultSuccess(value);

  factory Result.failure(Exception error) => _ResultFailure(error);

  factory Result.fromTryCatch(Success Function() fn) {
    try {
      return Result.success(fn());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  const Result();

  bool get isSuccess => this is _ResultSuccess<Success>;

  bool get isFailure => this is _ResultFailure<Success>;

  Success getSuccessOrThrow();

  Success? getSuccessOrNull();

  Success getSuccessOrElse(Success Function(Exception error) elseFn);

  Exception getException();

  Exception getExceptionOrThrowSuccess();

  Exception? getExceptionOrNull();

  V fold<V>(V Function(Success success) onSuccess,
      V Function(Exception error) onFail);

  Result<V> map<V extends Object>(V Function(Success success) onSuccess);

  Result<V> mapWithCatch<V extends Object>(
      V Function(Success success) onSuccess);

  Future<Result<V>> mapAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess);

  Future<Result<V>> mapWithCatchAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess);

  Result<V> flatMap<V extends Object>(
      Result<V> Function(Success success) onSuccess);

  Result<V> flatMapWithCatch<V extends Object>(
      Result<V> Function(Success success) onSuccess);

  Future<Result<V>> flatMapAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess);

  Future<Result<V>> flatMapWithCatchAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess);

  AsyncResult<Success> asAsync() {
    return Future.value(this);
  }
}

extension ResultWithFutureExt<Value extends Object> on Result<Future<Value>> {
  Future<Result<Value>> liftUpFuture() async {
    final _result = this;
    if (_result is _ResultSuccess<Future<Value>>) {
      final Value value = await _result.value;
      return Result.success(value);
    }
    if (_result is _ResultFailure<Future<Value>>) {
      final Exception error = _result.error;
      return Result.failure(error);
    }

    throw UnreachableError();
  }
}

@immutable
class _ResultSuccess<Success extends Object> extends Result<Success> {
  final Success value;

  const _ResultSuccess(this.value);

  @override
  String toString() {
    return "Result.Success($value)";
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _ResultSuccess<Success> && other.value == value;

  @override
  Success getSuccessOrThrow() {
    return value;
  }

  @override
  Success getSuccessOrElse(Success Function(Exception error) elseFunction) {
    return value;
  }

  @override
  Success? getSuccessOrNull() {
    return value;
  }

  @override
  Exception getException() {
    return IllegalUseException(
        "Result is Success Value with the value($value). Not Failure.");
  }

  @override
  Exception getExceptionOrThrowSuccess() {
    throw IllegalUseException(
        "Result is Success Value with the value($value). Not Failure.");
  }

  @override
  Exception? getExceptionOrNull() {
    return null;
  }

  @override
  V fold<V>(V Function(Success success) onSuccess,
      V Function(Exception error) onFail) {
    return onSuccess(value);
  }

  @override
  Result<V> map<V extends Object>(V Function(Success success) onSuccess) {
    return Result.success(onSuccess(value));
  }

  @override
  Result<V> mapWithCatch<V extends Object>(
      V Function(Success success) onSuccess) {
    try {
      return Result.success(onSuccess(value));
    } on Exception catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<V>> mapAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess) async {
    return Result.success(await onSuccess(value));
  }

  @override
  Future<Result<V>> mapWithCatchAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess) async {
    try {
      return Result.success(await onSuccess(value));
    } on Exception catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Result<V> flatMap<V extends Object>(
      Result<V> Function(Success success) onSuccess) {
    return onSuccess(value);
  }

  @override
  Result<V> flatMapWithCatch<V extends Object>(
      Result<V> Function(Success success) onSuccess) {
    try {
      return onSuccess(value);
    } on Exception catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<V>> flatMapAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess) async {
    return await onSuccess(value);
  }

  @override
  Future<Result<V>> flatMapWithCatchAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess) async {
    try {
      return await onSuccess(value);
    } on Exception catch (error) {
      return Result.failure(error);
    }
  }
}

@immutable
class _ResultFailure<Success extends Object> extends Result<Success> {
  final Exception error;

  const _ResultFailure(this.error);

  @override
  String toString() {
    return "Result.Failure($error)";
  }

  @override
  int get hashCode => error.hashCode;

  @override
  bool operator ==(Object other) =>
      other is _ResultFailure<Success> && other.error == error;

  @override
  Success getSuccessOrThrow() {
    throw error;
  }

  @override
  Success? getSuccessOrNull() {
    return null;
  }

  @override
  Success getSuccessOrElse(Success Function(Exception error) elseFn) {
    return elseFn(error);
  }

  @override
  Exception getException() {
    return error;
  }

  @override
  Exception getExceptionOrThrowSuccess() {
    return error;
  }

  @override
  Exception? getExceptionOrNull() {
    return error;
  }

  @override
  V fold<V>(V Function(Success success) onSuccess,
      V Function(Exception error) onFail) {
    return onFail(error);
  }

  @override
  Result<V> map<V extends Object>(V Function(Success success) onSuccess) {
    return Result.failure(error);
  }

  @override
  Result<V> mapWithCatch<V extends Object>(
      V Function(Success success) onSuccess) {
    return Result.failure(error);
  }

  @override
  Future<Result<V>> mapAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess) async {
    return Result.failure(error);
  }

  @override
  Future<Result<V>> mapWithCatchAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess) async {
    return Result.failure(error);
  }

  @override
  Result<V> flatMap<V extends Object>(
      Result<V> Function(Success success) onSuccess) {
    return Result.failure(error);
  }

  @override
  Result<V> flatMapWithCatch<V extends Object>(
      Result<V> Function(Success success) onSuccess) {
    return Result.failure(error);
  }

  @override
  Future<Result<V>> flatMapAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess) async {
    return Result.failure(error);
  }

  @override
  Future<Result<V>> flatMapWithCatchAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess) async {
    return Result.failure(error);
  }
}

typedef AsyncResult<Success extends Object> = Future<Result<Success>>;

extension AsyncResultExt<Success extends Object> on AsyncResult<Success> {
  static AsyncResult<Success> fromTryCatch(
      FutureOr<Success> Function() fn) async {
    try {
      return Result.success(await fn());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<bool> get isSuccess => then((result) => result.isSuccess);

  Future<bool> get isFailure => then((result) => result.isFailure);

  Future<Success> getSuccessOrThrow() {
    return then((result) => result.getSuccessOrThrow());
  }

  Future<Success?> getSuccessOrNull() {
    return then((result) => result.getSuccessOrNull());
  }

  Future<Success> getSuccessOrElse(
      FutureOr<Success> Function(Exception error) onFailure) {
    return then((result) => result.fold(
        (success) async => success, (error) async => await onFailure(error)));
  }

  Future<Exception> getException() async {
    return then((result) => result.getException());
  }

  Future<Exception> getExceptionOrThrowSuccess() {
    return then((result) => result.getExceptionOrThrowSuccess());
  }

  Future<Exception?> getExceptionOrNull() {
    return then((result) => result.getExceptionOrNull());
  }

  Future<V> fold<V>(
    V Function(Success success) onSuccess,
    V Function(Exception error) onFail,
  ) async {
    return then((result) => result.fold(onSuccess, onFail));
  }

  AsyncResult<V> map<V extends Object>(V Function(Success success) onSuccess) {
    return then((result) => result.map(onSuccess));
  }

  AsyncResult<V> mapWithCatch<V extends Object>(
      V Function(Success success) onSuccess) {
    return then((result) => result.mapWithCatch(onSuccess));
  }

  AsyncResult<V> mapAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess) {
    return then((result) => result.mapAsync(onSuccess));
  }

  AsyncResult<V> mapWithCatchAsync<V extends Object>(
      FutureOr<V> Function(Success success) onSuccess) {
    return then((result) => result.mapWithCatchAsync(onSuccess));
  }

  AsyncResult<V> flatMap<V extends Object>(
      Result<V> Function(Success success) onSuccess) {
    return then((result) => result.flatMap(onSuccess));
  }

  AsyncResult<V> flatMapWithCatch<V extends Object>(
      Result<V> Function(Success success) onSuccess) {
    return then((result) => result.flatMapWithCatch(onSuccess));
  }

  AsyncResult<V> flatMapAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess) {
    return then((result) => result.flatMapAsync(onSuccess));
  }

  AsyncResult<V> flatMapWithCatchAsync<V extends Object>(
      FutureOr<Result<V>> Function(Success success) onSuccess) {
    return then((result) => result.flatMapWithCatchAsync(onSuccess));
  }
}
