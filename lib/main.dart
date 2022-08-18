import 'package:element_tree_practice/base_counter.dart';
import 'package:element_tree_practice/multiplier_counter.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var _base = 0;
  var _multiplier = 0;

  set base(int value) {
    setState(() => _base = value);
  }

  set multiplier(int value) {
    setState(() => _multiplier = value);
  }

  void _resetAll(BuildContext context) {
    base = 0;
    multiplier = 0;

    // 子孫の Element を一番下まで走査し、Element が StatefulElement で
    // 且つ .state が BaseCounterState か MultiplierCounterState の場合は
    // .reset() を呼び出す。
    void resetIfPossible(Element element) {
      if (element is StatefulElement) {
        final state = element.state;
        if (state is BaseCounterState) {
          state.reset();
        } else if (state is MultiplierCounterState) {
          state.reset();
        }
      }
      element.visitChildren(resetIfPossible);
    }

    context.visitChildElements(resetIfPossible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${_base * _multiplier}',
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 24),
              Row(
                children: const [
                  Expanded(child: BaseCounter()),
                  SizedBox(width: 16),
                  Expanded(child: MultiplierCounter()),
                ],
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => _resetAll(context),
                child: const Text('リセット', style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
