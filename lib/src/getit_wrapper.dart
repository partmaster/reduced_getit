// getit_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:reduced/reduced.dart';

import 'getit_reducible.dart';

void registerState<S>({required S initialState}) =>
    GetIt.instance.registerSingleton(
      ValueNotifier<S>(initialState),
    );

Widget wrapWithConsumer<S, P>({
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    _WrapWithConsumer(
      builder: builder,
      transformer: transformer,
    );

class _WrapWithConsumer<S, P> extends StatelessWidget with GetItMixin {
  final ReducedTransformer<S, P> transformer;
  final ReducedWidgetBuilder<P> builder;

  _WrapWithConsumer({
    super.key,
    required this.transformer,
    required this.builder,
  });

  @override
  Widget build(context) => builder(
        props: watchOnly(
          (ValueNotifier<S> notifier) => transformer(notifier.reducible),
        ),
      );
}
