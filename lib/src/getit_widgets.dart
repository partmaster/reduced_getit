// getit_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduced/reduced.dart';

import 'getit_store.dart';

void registerState<S>({required S initialState}) =>
    GetIt.instance.registerSingleton(
      ValueNotifier<S>(initialState),
    );

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
        props: watchOnly(
          (ValueNotifier<S> notifier) => transformer(notifier.proxy),
        ),
      );
}
