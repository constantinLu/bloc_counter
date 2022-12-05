import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';
import '../screens/third_screen.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route onGenerateRoute(RouteSettings routeSettings) {
    // add key if needed
    //final GlobalKey<ScaffoldState> key = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit, child: const HomeScreen(title: "Home", color: Colors.grey)));
      case '/second':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit,
                child: const SecondScreen(title: "SecondScreen", color: Colors.amber)));

      case '/third':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _counterCubit,
                child: const ThirdScreen(title: "ThirdScreen", color: Colors.red)));
      default:
        return throw Exception('No route found');
    }
  }

  void dispose() {
    _counterCubit.close();
  }

}
