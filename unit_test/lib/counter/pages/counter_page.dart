import 'package:flutter/material.dart';
import 'package:unit_test/counter/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
   final Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Unit Test for counter programme'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              counter.value.toString(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter.increment();
                });
              },
              child: const Text('Increment'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter.decrement();
                });
              },
              child: const Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}
