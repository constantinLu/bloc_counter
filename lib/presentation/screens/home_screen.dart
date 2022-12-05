import 'package:bloc_counter/logic/cubit/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';
import '../../logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //listen to changes
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            const snackBar = SnackBar(
              content: Text('Yay! A SnackBar!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Center(
          child: BlocBuilder<InternetCubit, InternetState>(
            builder: (ctx, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Counter:",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return Text(
                        state.counterValue.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: UniqueKey(),
                        onPressed: () {
                          //change state
                          BlocProvider.of<CounterCubit>(context).decrement();
                          //or context.read<CounterCubit>().decrement();
                        },
                        tooltip: "Decrement",
                        child: const Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        heroTag: UniqueKey(),
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).resetCounter();
                        },
                        tooltip: "Reset Counter",
                        child: const Icon(Icons.restart_alt),
                      ),
                      FloatingActionButton(
                        heroTag: UniqueKey(),
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).increment();
                        },
                        tooltip: "Increment",
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    color: widget.color,
                    onPressed: () {
                      // Named Routing
                      Navigator.of(context).pushNamed('/second');
                    },
                    child: const Text("Go to second screen"),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    color: widget.color,
                    onPressed: () {
                      // Named Routing
                      Navigator.of(context).pushNamed('/third');
                    },
                    child: const Text("Go to third screen"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
