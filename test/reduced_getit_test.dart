import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_getit/reduced_getit.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) {
    return state + 1;
  }
}

void main() {
  test('ValueNotifier state 0', () {
    final objectUnderTest = ValueNotifier(0).reducible;
    expect(objectUnderTest.state, 0);
  });

  test('ValueNotifier state 1', () {
    final objectUnderTest = ValueNotifier(1).reducible;
    expect(objectUnderTest.state, 1);
  });

  test('ValueNotifier reduce', () async {
    final objectUnderTest = ValueNotifier(0).reducible;
    objectUnderTest.reduce(Incrementer());
    expect(objectUnderTest.state, 1);
  });

  test('wrapWithConsumer', () {
    final objectUnderTest = wrapWithConsumer(
      builder: ({Key? key, required int props}) => const SizedBox(),
      transformer: (reducible) => 1,
    );
    expect(objectUnderTest, isA<GetItMixin>());
  });
}
