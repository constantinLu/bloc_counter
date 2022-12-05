import 'package:bloc_counter/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter/logic/cubit/internet_cubit.dart';
import 'package:bloc_counter/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({Key? key, required this.appRouter, required this.connectivity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (ctx) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
            create: (ctx) => CounterCubit(internetCubit: BlocProvider.of<InternetCubit>(context)))
      ],
      child: MaterialApp(
        title: 'Counter Cubit Demo',
        theme: ThemeData(
            primarySwatch: Colors.grey, visualDensity: VisualDensity.adaptivePlatformDensity),

        debugShowCheckedModeBanner: false,
        // GENERATED ROUTS
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

// OLD IMPL
// return BlocProvider(
//   create: (context) => CounterCubit(),
//   child: MaterialApp(
//     title: 'Counter Cubit Demo',
//     theme: ThemeData(
//         primarySwatch: Colors.grey, visualDensity: VisualDensity.adaptivePlatformDensity),
//     debugShowCheckedModeBanner: false,
//     // GENERATED ROUTS
//     onGenerateRoute: _appRouter.onGenerateRoute,

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
//     ),
//   );
// }

// @override
// void dispose() {
//   _appRouter.dispose();
//   super.dispose();
// }
//}
