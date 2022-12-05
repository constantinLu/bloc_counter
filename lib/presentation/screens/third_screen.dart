import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    //listen to changes
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
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
          child: Column(
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
                    backgroundColor: widget.color,
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
                    backgroundColor: widget.color,
                    heroTag: UniqueKey(),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).resetCounter();
                    },
                    tooltip: "Reset Counter",
                    child: const Icon(Icons.restart_alt),
                  ),
                  FloatingActionButton(
                    backgroundColor: widget.color,
                    heroTag: UniqueKey(),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: "Increment",
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
