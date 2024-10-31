import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/bloc/todo_bloc.dart';
import 'package:test_bloc/bloc/todo_event.dart';
import 'package:test_bloc/counter_bloc.dart';
import 'package:test_bloc/counter_cubit.dart';
import 'package:test_bloc/presentation/todo_list_screen.dart';
import 'package:test_bloc/repository/todo_repository.dart';
import 'package:test_bloc/simple_bloc_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TodoBloc(TodoRepository())..add(FetchTodoList()),
            )
          ],
          child: const TodoListScreen(),
        )
        /*
      BlocProvider(
        create: (_) => CounterBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      */
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    inital();
    super.initState();
  }

  inital() async {
    final bloc = CounterBloc()
      ..add(CounterIncrementPressed())
      ..close();

    return;

    print(bloc.state);

    final blocSubscription = bloc.stream.listen((v) => print(v));

    bloc.add(CounterIncrementPressed());

    await Future.delayed(const Duration(seconds: 1));

    await blocSubscription.cancel();

    await bloc.close();

    return;

    bloc.add(CounterIncrementPressed());

    await Future.delayed(const Duration(seconds: 1));

    print(bloc.state);

    bloc.close();

    return;
    Bloc.observer = SimpleBlocObserver();

    final cubit = CounterCubit()
      ..increment()
      ..increment()
      ..close();

    return;

    final subscription = cubit.stream.listen((v) => print(v));

    cubit.increment();

    await Future.delayed(const Duration(seconds: 1));

    await subscription.cancel();

    await cubit.close();

    return;

    print(cubit.state);

    cubit.increment();

    print(cubit.state);

    cubit.close();

    return;
    final cubitA = CounterCubit();
    final cubitB = CounterCubit();

    print(cubitA.state);
    print(cubitB.state);

    return;
    final count = countStream(10);

    int sum = await sumStream(count);

    print(sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<CounterBloc, int>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                state.toString(),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementPressed());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Stream<int> countStream(int max) async* {
    for (var i = 0; i < max; i++) {
      yield i;
    }
  }

  Future<int> sumStream(Stream<int> stream) async {
    int sum = 0;
    await for (int value in stream) {
      sum += value;
    }
    return sum;
  }
}
