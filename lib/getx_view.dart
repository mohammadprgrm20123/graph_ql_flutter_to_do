import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef GetxViewBuilder<S> = S Function();

abstract class GetxView<T> extends StatelessWidget {
  final GetxViewBuilder<T> _controller;
  const GetxView(this._controller, {final Key? key}) : super(key: key);

  final String? tag = null;

  T get controller => GetInstance().putOrFind<T>(_controller, tag: tag)!;

  @override
  Widget build(final BuildContext context);
}