// getit_reducible.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

/// Extension on class [ValueNotifier] with support of the [Reducible] interface.
extension ReducibleValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  Reducible<S> get reducible =>
      ReducibleProxy(getState, reduce, this);
}
