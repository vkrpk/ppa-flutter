import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  final List<int> _fruits = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
      _fruits.add(_counter);
    });
  }

  getColor(number) {
    if (number % 2 == 0) {
      return Colors.indigo;
    } else {
      return Colors.cyan;
    }
  }

  bool isPrime(int num) {
    if (num <= 1) {
      return false;
    }

    for (int i = 2; i <= num / 2; i++) {
      if (num % i == 0) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ListView.builder(
              itemCount: _fruits.length,
              shrinkWrap: true,
              // prototypeItem: ListTile(
              //   title: Text(_fruits.first.toString(), style: const TextStyle(color: Colors.red)),
              // ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_fruits[index].toString(), style: const TextStyle(
                    color: Colors.white,
                  )),
                  tileColor: getColor(index),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(isPrime(index + 1) ? 'images/ananas.png' : getColor(index + 1) == Colors.indigo ? 'images/poire.png' : 'images/pomme.png'),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: _counter == 0 ? Colors.orange : getColor(_counter),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
