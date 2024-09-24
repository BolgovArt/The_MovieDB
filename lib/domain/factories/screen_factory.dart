import 'package:provider/provider.dart';
import 'package:vk/widgets/loader_widget/loader_view_model.dart';
import 'package:vk/widgets/loader_widget/loader_widget.dart';
import 'package:flutter/material.dart';

// класс будет создавать экран
class ScreenFactory {
  Widget makeLoader() {
  return Provider(
    create: (context) => LoaderViewModel(context),
    child: const LoaderWidget(),
    lazy: false,
  );
  }
}