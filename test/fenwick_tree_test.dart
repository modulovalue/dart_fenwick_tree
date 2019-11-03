import 'package:abstract_dart/abstract_dart.dart';
import 'package:fenwick_tree/fenwick_tree.dart';
import 'package:test/test.dart';

void main() {
  group("$FenwickTree", () {
    test(".create", () {
      final tree = FenwickTree<double>.create(
        identity: () => 0.0,
        addition: (a, b) => a + b,
        subtraction: (a, b) => a - b,
        size: 3,
      );
      tree.update(0, 1);
      tree.update(1, 2);
      tree.update(2, 3);
      expect(tree.sum(2), 6);
    });
    test("length", () {
      final sut = FenwickTree(group: const IntSumGroup(), size: 100);
      List.generate(100, (a) => a).forEach((a) => sut.update(a, 1));
      expect(sut.length(), 100);
    });
    // https://www.geeksforgeeks.org/binary-indexed-tree-or-fenwick-tree-2/
    test("update", () {
      final sut = FenwickTree(group: const IntSumGroup(), size: 12);
      [2, 1, 1, 3, 2, 3, 4, 5, 6, 7, 8, 9]
          .asMap()
          .entries
          .forEach((entry) => sut.update(entry.key, entry.value));
      expect(sut.array, [0, 2, 3, 1, 7, 2, 5, 4, 21, 6, 13, 8, 30]);
    });
    group("sum", () {
      final sut = FenwickTree(group: const IntSumGroup(), size: 5);
      [
        1,
        2,
        3,
        4,
        5,
      ].asMap().entries.forEach((entry) => sut.update(entry.key, entry.value));
      test("0", () {
        expect(sut.sum(0), 1);
      });
      test("1", () {
        expect(sut.sum(1), 1 + 2);
      });
      test("4", () {
        expect(sut.sum(4), 1 + 2 + 3 + 4 + 5);
      });
      test("5", () {
        expect(() => sut.sum(5), throwsA(const TypeMatcher<AssertionError>()));
      });
    });
    group("rangeSum", () {
      final sut = FenwickTree(group: const IntSumGroup(), size: 5);
      [
        1,
        2,
        3,
        4,
        5,
      ].asMap().entries.forEach((entry) => sut.update(entry.key, entry.value));
      test("[0, 5]", () => expect(sut.rangeSum(0, 5), 15));
      test("[0, 2]", () => expect(sut.rangeSum(0, 2), 3));
      test("[1, 4]", () => expect(sut.rangeSum(1, 4), 9));
      test("[1, 5]", () => expect(sut.rangeSum(1, 5), 14));
      test(
          "[0, 0]",
          () => expect(() => sut.rangeSum(0, 0),
              throwsA(const TypeMatcher<AssertionError>())));
      test(
          "[5, 5]",
          () => expect(() => sut.rangeSum(5, 5),
              throwsA(const TypeMatcher<AssertionError>())));
      test(
          "[3, 2]",
          () => expect(() => sut.rangeSum(3, 2),
              throwsA(const TypeMatcher<AssertionError>())));
      test(
          "[-1, 2]",
          () => expect(() => sut.rangeSum(-1, 2),
              throwsA(const TypeMatcher<AssertionError>())));
      test(
          "[0, 6]",
          () => expect(() => sut.rangeSum(0, 6),
              throwsA(const TypeMatcher<AssertionError>())));
    });
  });
}
