import 'dart:core';

import 'package:abstract_dart/abstract_dart.dart';
import 'package:meta/meta.dart';

// ignore_for_file: parameter_assignments
/// Efficient prefix sums.
///
/// Based on: https://algs4.cs.princeton.edu/99misc/FenwickTree.java.html
class FenwickTree<T> {
  @visibleForTesting
  final List<T> array;

  final Group_<T> group;

  /// For groups see: https://pub.dev/packages/abstract_dart
  /// A Fenwick Tree needs addition, subtraction and identity
  /// which are provided by the group.
  FenwickTree({
    @required this.group,
    @required int size,
  }) : array = List.generate(size + 1, (_) => group.identity());

  factory FenwickTree.create({
    @required T Function() identity,
    @required T Function(T a, T b) addition,
    @required T Function(T a, T b) subtraction,
    @required int size,
  }) =>
      FenwickTree(
          group: Group_.create(identity, addition, subtraction), size: size);

  /// If the tree is built with [1, 2, 3, 4, 5],
  /// then sum(4) will return the sum of [1, 2, 3, 4, 5] which is 15.
  ///
  /// Time-Complexity:    O(log(n))
  T sum(int index) {
    assert(index > -1 && array.length > index + 1);
    T sum = group.identity();
    index++;
    while (index > 0) {
      sum = group.operate(sum, array[index]);
      index -= index & -index;
    }
    if (index == array.length - 1) return group.operate(sum, array[index]);
    return sum;
  }

  /// If the tree is built with [1, 2, 3, 4, 5],
  /// then rangeSum(1, 4) will return the sum of [2, 3, 4] which is 9.
  ///
  /// Time-Complexity:    O(log(n))
  T rangeSum(int a, int b) {
    assert(b > a);
    assert(a > -1);
    assert(b > -1);
    assert(array.length > a + 1);
    assert(array.length > b);
    if (a == 0) return sum(b - 1);
    return group.inverse(sum(b - 1), sum(a - 1));
  }

  /// Updates the value at [index] with [value].
  ///
  /// Time-Complexity:    O(log(n))
  void update(int index, T value) {
    assert(index > -1);
    index++;
    while (index < array.length) {
      array[index] = group.operate(array[index], value);
      index += index & -index;
    }
  }

  /// Returns the length of this tree which will be
  /// equal to the size provided in the constructor.
  int length() => array.length - 1;
}
