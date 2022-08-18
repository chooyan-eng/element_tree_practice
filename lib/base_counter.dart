import 'package:flutter/material.dart';

import 'main.dart';

class BaseCounter extends StatefulWidget {
  const BaseCounter({Key? key}) : super(key: key);

  @override
  BaseCounterState createState() => BaseCounterState();
}

class BaseCounterState extends State<BaseCounter> {
  var _base = 0;

  void reset() {
    setState(() => _base = 0);
  }

  void _countUp(BuildContext context) {
    setState(() => _base += 1);

    // ツリーの祖先から MyHomePageState を探してくる
    final parentState = context.findAncestorStateOfType<MyHomePageState>();
    if (parentState != null) {
      // あれば MyHomePageState.base の値を更新
      parentState.base = _base;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal.shade50,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('かけられる数'),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('$_base', style: const TextStyle(fontSize: 40)),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _countUp(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('+ 1'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
