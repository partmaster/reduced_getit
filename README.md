![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced_getit)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced_getit/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced_getit)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced_getit)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced_getit)
# reduced_getit

Implementation of the 'reduced' API for the 'GetIt' state management framework with following features:

1. Implementation of the ```Reducible``` interface 
2. Register a state for management.
3. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```Reducible``` interface

```dart
extension ReducibleValueNotifier<S> on ValueNotifier<S> {
  S getState() => value;

  void reduce(Reducer<S> reducer) {
    value = reducer(value);
  }

  Reducible<S> get reducible =>
      ReducibleProxy(getState, reduce, this);
}
```

#### 2. Register a state for management.

```dart
void registerState<S>({required S initialState}) =>
    GetIt.instance.registerSingleton(
      ValueNotifier<S>(initialState),
    );
```

#### 3. Trigger a rebuild on widgets selectively after a state change.

```dart
Widget wrapWithConsumer<S, P>({
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    _WrapWithConsumer(
      builder: builder,
      transformer: transformer,
    );
```dart

````
class _WrapWithConsumer<S, P> extends StatelessWidget
    with GetItMixin {
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
          (ValueNotifier<S> notifier) =>
              transformer(notifier.reducible),
        ),
      );
}
```

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package  'reduced_getit'.

```
dependencies:
  reduced: ^0.1.0
  reduced_getit: ^0.1.0
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import package 'reduced' to use the logic.

```dart
import 'package:reduced_getit/reduced_getit.dart';
```

## Usage

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

class Incrementer extends Reducer<int> {
  int call(int state) => state + 1;
}

class Props {
  Props({required this.counterText, required this.onPressed});
  final String counterText;
  final Callable<void> onPressed;
}

Props transformer(Reducible<int> reducible) => Props(
      counterText: '${reducible.state}',
      onPressed: CallableAdapter(reducible, Incrementer()),
    );

Widget builder({Key? key, required Props props}) => Scaffold(
      appBar: AppBar(title: Text('reduced_getit example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text('${props.counterText}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: props.onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
```

Finished counter demo app using logic.dart and 'reduced_getit' package:

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_getit/reduced_getit.dart';
import 'logic.dart';

void main() {
  registerState(initialState: 0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Builder(
          builder: (context) => wrapWithConsumer(
            transformer: transformer,
            builder: builder,
          ),
        ),
      );
}
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|framework|implementation package for 'reduced' API|
|---|---|
|[Bloc](https://bloclibrary.dev/#/)|[reduced_bloc](https://github.com/partmaster/reduced_bloc)|
|[GetIt](https://pub.dev/packages/get_it)|[reduced_getit](https://github.com/partmaster/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[reduced_getx](https://github.com/partmaster/reduced_getx)|
|[Redux](https://pub.dev/packages/redux)|[reduced_redux](https://github.com/partmaster/reduced_redux)|
|[Riverpod](https://riverpod.dev/)|[reduced_riverpod](https://github.com/partmaster/reduced_riverpod)|
