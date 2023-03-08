// getit_widgets.dart

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduced/reduced.dart';

import 'getit_store.dart';

Object registerState<S>(S initialState) {
  final instance = ValueNotifier(initialState);
  GetIt.instance.registerSingleton(instance);
  return instance;
}

FutureOr unregisterState(Object instance) =>
    GetIt.instance.unregister(instance: instance);

/*
class ReducedProvider<S> extends StatefulWidget {
  ReducedProvider({
    super.key,
    required this.child,
    required S initialState,
  }) : instance = ValueNotifier(initialState);

  final ValueNotifier<S> instance;
  final Widget child;

  @override
  State<ReducedProvider> createState() => _ReducedProviderState();
}

class _ReducedProviderState extends State<ReducedProvider> {
  @override
  void initState() {
    super.initState();
    print('registerSingleton(${widget.instance})');
  }

  @override
  void dispose() {
    // GetIt.instance.unregister(instance: widget.instance);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
*/

class ReducedConsumer<S, P> extends StatelessWidget with GetItMixin {
  ReducedConsumer({
    super.key,
    required this.transformer,
    required this.builder,
  });

  final ReducedTransformer<S, P> transformer;
  final ReducedWidgetBuilder<P> builder;

  @override
  Widget build(BuildContext context) => builder(
        props: watchOnly<ValueNotifier<S>, P>(
          (ValueNotifier<S> notifier) => transformer(notifier.proxy),
        ),
      );
}
