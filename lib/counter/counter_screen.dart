import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';
import 'counter_state.dart';
import 'counter_storage.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: CounterStorage.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Failed to initialize storage'),
            ),
          );
        }

        return BlocProvider(
          create: (_) => CounterCubit(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Counter App'),
              centerTitle: true,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  final cubit = context.read<CounterCubit>();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            cubit.increment();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'data',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 24),

                      Text(
                        '${state.counter}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              cubit.increment();
                            },
                            icon: const Icon(Icons.add),
                            iconSize: 36,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 24),
                          IconButton(
                            onPressed: () {
                              cubit.decrement();
                            },
                            icon: const Icon(Icons.remove),
                            iconSize: 36,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}