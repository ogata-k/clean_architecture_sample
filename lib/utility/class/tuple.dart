class Pair<T1, T2> {
  final T1 item1;

  final T2 item2;

  const Pair(this.item1, this.item2);

  Pair<P1, T2> withItem1<P1>(P1 v) => Pair(v, item2);

  Pair<T1, P2> withItem2<P2>(P2 v) => Pair(item1, v);

  Pair<P1, T2> mapItem1<P1>(P1 Function(T1 v) fn) => Pair(fn(item1), item2);

  Pair<T1, P2> mapItem2<P2>(P2 Function(T2 v) fn) => Pair(item1, fn(item2));

  Future<Pair<P1, T2>> mapItem1Async<P1>(Future<P1> Function(T1 v) fn) async =>
      Pair(await fn(item1), item2);

  Future<Pair<T1, P2>> mapItem2Async<P2>(Future<P2> Function(T2 v) fn) async =>
      Pair(item1, await fn(item2));

  List<dynamic> toList({bool growable = false}) =>
      List.from([item1, item2], growable: growable);

  @override
  String toString() => 'Pair($item1, $item2)';

  @override
  bool operator ==(Object other) =>
      other is Pair<T1, T2> && other.item1 == item1 && other.item2 == item2;

  @override
  int get hashCode => Object.hash(item1, item2);

  Future<Pair<T1, T2>> asAsync() {
    return Future.value(this);
  }
}

extension PairWithFuture1Ext<T1, T2, T3> on Pair<Future<T1>, T2> {
  Future<Pair<T1, T2>> liftUpFuture1() async {
    return Pair(await item1, item2);
  }
}

extension PairWithFuture2Ext<T1, T2, T3> on Pair<T1, Future<T2>> {
  Future<Pair<T1, T2>> liftUpFuture2() async {
    return Pair(item1, await item2);
  }
}

extension PairWithFutureExt<T1, T2, T3> on Pair<Future<T1>, Future<T2>> {
  Future<Pair<T1, T2>> liftUpFuture() async {
    return Pair(await item1, await item2);
  }
}

class Triple<T1, T2, T3> {
  final T1 item1;

  final T2 item2;

  final T3 item3;

  const Triple(this.item1, this.item2, this.item3);

  Triple<P1, T2, T3> withItem1<P1>(P1 v) => Triple(v, item2, item3);

  Triple<T1, P2, T3> withItem2<P2>(P2 v) => Triple(item1, v, item3);

  Triple<T1, T2, P3> withItem3<P3>(P3 v) => Triple(item1, item2, v);

  Triple<P1, T2, T3> mapItem1<P1>(P1 Function(T1 v) fn) =>
      Triple(fn(item1), item2, item3);

  Triple<T1, P2, T3> mapItem2<P2>(P2 Function(T2 v) fn) =>
      Triple(item1, fn(item2), item3);

  Triple<T1, T2, P3> mapItem3<P3>(P3 Function(T3 v) fn) =>
      Triple(item1, item2, fn(item3));

  Future<Triple<P1, T2, T3>> mapItem1Async<P1>(
          Future<P1> Function(T1 v) fn) async =>
      Triple(await fn(item1), item2, item3);

  Future<Triple<T1, P2, T3>> mapItem2Async<P2>(
          Future<P2> Function(T2 v) fn) async =>
      Triple(item1, await fn(item2), item3);

  Future<Triple<T1, T2, P3>> mapItem3Async<P3>(
          Future<P3> Function(T3 v) fn) async =>
      Triple(item1, item2, await fn(item3));

  List<dynamic> toList({bool growable = false}) =>
      List.from([item1, item2, item3], growable: growable);

  @override
  String toString() => 'Triple($item1, $item2, $item3)';

  @override
  bool operator ==(Object other) =>
      other is Triple<T1, T2, T3> &&
      other.item1 == item1 &&
      other.item2 == item2 &&
      other.item3 == item3;

  @override
  int get hashCode =>
      Object.hash(item1.hashCode, item2.hashCode, item3.hashCode);

  Future<Triple<T1, T2, T3>> asAsync() {
    return Future.value(this);
  }
}

extension TripleWithFuture1Ext<T1, T2, T3> on Triple<Future<T1>, T2, T3> {
  Future<Triple<T1, T2, T3>> liftUpFuture1() async {
    return Triple(await item1, item2, item3);
  }
}

extension TripleWithFuture2Ext<T1, T2, T3> on Triple<T1, Future<T2>, T3> {
  Future<Triple<T1, T2, T3>> liftUpFuture2() async {
    return Triple(item1, await item2, item3);
  }
}

extension TripleWithFuture3Ext<T1, T2, T3> on Triple<T1, T2, Future<T3>> {
  Future<Triple<T1, T2, T3>> liftUpFuture3() async {
    return Triple(item1, item2, await item3);
  }
}

extension TripleWithFutureExt<T1, T2, T3>
    on Triple<Future<T1>, Future<T2>, Future<T3>> {
  Future<Triple<T1, T2, T3>> liftUpFuture3() async {
    return Triple(await item1, await item2, await item3);
  }
}