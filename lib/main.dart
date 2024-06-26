import 'dart:math';

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

  String getLabel(integer) {
    if(isPrime(integer)) {
      return 'premier';
    } else if (integer % 2 == 0) {
      return 'pair';
    } else {
      return 'impair';
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
        title: Text('$_counter : Nombre ${getLabel(_counter)}'),
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
                  title: Text(index.toString(), style: const TextStyle(
                    color: Colors.white,
                  )),
                  tileColor: getColor(index),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(isPrime(index) ? 'images/ananas.png' : getColor(index) == Colors.indigo ? 'images/poire.png' : 'images/pomme.png'),
                  ),
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Text('$index : Nombre ${getLabel(index)}', style: const TextStyle(
                        color: Colors.white,
                      )),
                      backgroundColor: getColor(index),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(
                            isPrime(index) ? 'images/ananas.png' : getColor(index) == Colors.indigo ? 'images/poire.png' : 'images/pomme.png', // Replace with your image path
                            width: 150,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel', style: TextStyle(
                            color: Colors.white,
                          )),
                        ),
                        TextButton(
                          onPressed: () => {
                            setState(() {
                              _fruits.removeAt(index);
                            }),
                            Navigator.pop(context, 'Cancel')
                          },
                          child: const Text('Supprimer de la liste', style: TextStyle(
                            color: Colors.white,
                          )),
                        ),
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
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
