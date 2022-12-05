import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/third_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(title: "Home", color: Colors.grey));
      case '/second':
        return MaterialPageRoute(
            builder: (_) => const SecondScreen(title: "SecondScreen", color: Colors.amber));

      case '/third':
        return MaterialPageRoute(
            builder: (_) => const ThirdScreen(title: "ThirdScreen", color: Colors.red));
      default:
        return throw Exception('No route found');
    }

    // add key if needed
    //final GlobalKey<ScaffoldState> key = routeSettings.arguments;
    // switch (routeSettings.name) {
    //   case '/':
    //     return MaterialPageRoute(
    //         builder: (_) => BlocProvider.value(
    //             value: _counterCubit, child: const HomeScreen(title: "Home", color: Colors.grey)));
    //   case '/second':
    //     return MaterialPageRoute(
    //         builder: (_) => BlocProvider.value(
    //             value: _counterCubit,
    //             child: const SecondScreen(title: "SecondScreen", color: Colors.amber)));
    //
    //   case '/third':
    //     return MaterialPageRoute(
    //         builder: (_) => BlocProvider.value(
    //             value: _counterCubit,
    //             child: const ThirdScreen(title: "ThirdScreen", color: Colors.red)));
    //   default:
    //     return throw Exception('No route found');
    // }
  }
  //
  // void dispose() {
  //   _counterCubit.close();
  // }
}
