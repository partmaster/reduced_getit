import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_getit/reduced_getit.dart';

class CounterIncremented extends Event<int> {
  @override
  int call(int state) => state + 1;
}

void main() {
  test('ValueNotifier state 0', () {
    final objectUnderTest = ValueNotifier(0).proxy;
    expect(objectUnderTest.state, 0);
  });

  test('ValueNotifier state 1', () {
    final objectUnderTest = ValueNotifier(1).proxy;
    expect(objectUnderTest.state, 1);
  });

  test('ValueNotifier dispatch', () async {
    final objectUnderTest = ValueNotifier(0).proxy;
    objectUnderTest.dispatch(CounterIncremented());
    expect(objectUnderTest.state, 1);
  });
}
