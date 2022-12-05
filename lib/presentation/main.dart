import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter/presentation/router/app_router.dart';
import 'package:bloc_counter/presentation/screens/home_screen.dart';
import 'package:bloc_counter/presentation/screens/second_screen.dart';
import 'package:bloc_counter/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // when we want provide an existing instance of a bloc or cubit we will use BlocProvider.value()
  // final CounterCubit _counterCubit = CounterCubit();

  AppRouter _appRouter = AppRouter();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Counter Cubit Demo',
        theme: ThemeData(
            primarySwatch: Colors.grey, visualDensity: VisualDensity.adaptivePlatformDensity),
        debugShowCheckedModeBanner: false,
        // GENERATED ROUTS
        onGenerateRoute: _appRouter.onGenerateRoute,

        //NAMED ROUTS
        // routes: {
        //   '/': (context) => BlocProvider.value(
        //       value: _counterCubit, child: const HomeScreen(title: "Home", color: Colors.grey)),
        //   '/second': (context) => BlocProvider.value(
        //       value: _counterCubit,
        //       child: const SecondScreen(title: "SecondScreen", color: Colors.amber)),
        //   '/third': (context) => BlocProvider.value(
        //       value: _counterCubit, child: const ThirdScreen(title: "ThirdScreen", color: Colors.red)),
        // },
        //NOT NEEDED SINCE we have routes
        //home: const HomeScreen(title: 'Flutter Demo Home Page', color: Colors.amber),
      ),
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }


}
