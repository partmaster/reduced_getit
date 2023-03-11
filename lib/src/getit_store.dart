// getit_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

/// Extension on class [ValueNotifier] with support of the [ReducedStore] interface.
extension ReducedValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void dispatch(Event<S> event) => value = event(value);

  ReducedStore<S> get proxy => ReducedStoreProxy(getState, dispatch, this);
}
