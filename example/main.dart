import 'package:abstract_dart/abstract_dart.dart';
import 'package:fenwick_tree/fenwick_tree.dart';

void example() {
  // A Fenwick Tree needs addition, subtraction and identity which are provided
  // in form of a Group. See https://pub.dev/packages/abstract_dart
  final tree = FenwickTree(group: const DoubleSumGroup(), size: 5);
  // or
  final tree2 = FenwickTree<double>.create(
    identity: () => 0.0,
    addition: (a, b) => a + b,
    subtraction: (a, b) => a - b,
    size: 5,
  );

  tree.update(0, 1.0);
  tree.update(1, 2.0);
  tree.update(2, 3.0);
  tree.update(3, 4.0);
  tree.update(4, 5.0);

  print(tree.sum(4)); // 15 (1+2+3+4+5)
  print(tree.rangeSum(3, 5)); // 9 (4+5)
  print(tree.length()); // 5
}

void example2() {
  print("\t\t\tInit");
  const size = 10000000;

  final list = List.generate(size, (a) => a.toDouble());
  final tree = FenwickTree(group: const DoubleSumGroup(), size: size);

  list.asMap().entries.forEach((i) => tree.update(i.key, i.value));
  print("\t\t\tTree Updated");

  print("\t\t\tList.reduce");
  for (int i = 0; i <= 10; i++) {
    print(list.reduce((a, b) => a + b));
  }

  print("\t\t\tFenwickTree.sum");
  for (int i = 0; i <= 10; i++) {
    print(tree.sum(list.length - 1));
  }

  print("\t\t\tEnd");
}

void main() {
  example();
//  example2();
}
