import 'package:flutter/material.dart';

import 'main.dart';

class MultiplierCounter extends StatefulWidget {
  const MultiplierCounter({Key? key}) : super(key: key);

  @override
  MultiplierCounterState createState() => MultiplierCounterState();
}

class MultiplierCounterState extends State<MultiplierCounter> {
  var _multiplier = 0;

  void reset() {
    setState(() => _multiplier = 0);
  }

  void _countUp(BuildContext context) {
    setState(() => _multiplier += 1);

    // ツリーの祖先から MyHomePageState を探してくる
    final parentState = context.findAncestorStateOfType<MyHomePageState>();
    if (parentState != null) {
      parentState.multiplier = _multiplier;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.shade50,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('かける数'),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('$_multiplier', style: const TextStyle(fontSize: 40)),
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
