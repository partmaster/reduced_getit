// getit_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

/// Extension on class [ValueNotifier] with support of the [ReducedStore] interface.
extension ReducedValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  ReducedStore<S> get proxy => ReducedStoreProxy(getState, reduce, this);
}
