import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk/ui/navigation/main_navigation.dart';
import 'package:vk/widgets/loader_widget/loader_view_cubit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderViewCubitState>(
      listenWhen: (prev, current) => current != LoaderViewCubitState.unknown,
      listener: onLoaderViewCubitStateChange,
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
          ),
      ),
    );
  }

  void onLoaderViewCubitStateChange(BuildContext context, LoaderViewCubitState state) {
        final nextScreen = state == LoaderViewCubitState.authorized // если стейт == authorized
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.authorization;
        Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}



