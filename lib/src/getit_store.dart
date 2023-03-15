// getit_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

/// Extension on class [ValueNotifier] with support of the [ReducedStore] interface.
extension ReducedValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void process(Event<S> event) => value = event(value);

  Store<S> get proxy => StoreProxy(getState, process, this);
}
