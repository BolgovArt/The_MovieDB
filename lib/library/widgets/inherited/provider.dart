import 'package:flutter/material.dart';
// код ниже делается через библиотеку dispose, но сейчас все сами руками пишем

// P.S. Появился универсальный stf виджет, который за нас создает _InheritedNotifierProvider, за нас его хранит, создается только при первой
// инициализации (_model = widget.create();), при ребилдах его уже не пересоздает + dispose.
// методы watch и create перенесены


class NotifierProvider<Model extends ChangeNotifier> extends StatefulWidget {

  final Model Function() create; // функция будет собираться один раз. В случае использования переменной при ее передаче снаружи все равно все будет заново собираться, потому функция
                             // Эта функция будет возвращать модель виджета InheritedNotifierProvider
  
  final Widget child;
  final bool isManagingModel; // управляем ли моделью сейчас или нет

  const NotifierProvider({
    super.key, 
    required this.create, 
    required this.child, 
    this.isManagingModel = true,
    });

  @override
  _NotifierProviderState<Model> createState() => 
    _NotifierProviderState<Model>();

    static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = 
      context.getElementForInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()?.widget;
    return widget is _InheritedNotifierProvider<Model> ? widget.model : null; 
  }
}

class _NotifierProviderState<Model extends ChangeNotifier> 
    extends State<NotifierProvider<Model>> {
  late final Model _model;

  @override 
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierProvider(
      model: _model, 
      child: widget.child,
      );
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {
      _model.dispose();
    }
    super.dispose();
  }
}



class _InheritedNotifierProvider<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;

  const _InheritedNotifierProvider({
  Key? key,
  required this.model,
  required Widget child,
}) : super(
  key: key,
  notifier: model,
  child: child,
);


}

class Provider<Model> extends InheritedWidget {
  final Model model;

  const Provider({
    Key? key, 
    required this.model,
    required Widget child,
  }) : super(
    key: key,
    child: child,
  );

  static Model? watch<Model>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<Provider<Model>>()
        ?.widget;
    return widget is Provider<Model> ? widget.model : null;
  }

  @override 
  bool updateShouldNotify(Provider oldWidget) {
    return model != oldWidget.model;
  }
}
