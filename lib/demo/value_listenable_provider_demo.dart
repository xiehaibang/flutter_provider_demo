// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// ValueListenableProvider 使用例子
///
///
class ValueListenableProviderDemo extends StatelessWidget {
  const ValueListenableProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueListenableProviderDemo'),
      ),
      body: Provider(
        create: (context) => MyModel(),
        child: Consumer<MyModel>(
          builder: (context, myModel, child) => ValueListenableProvider<String>.value(
            value: myModel.someValue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 事件触发
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green[200],
                  child: Consumer<MyModel>(
                    builder: (context, myModel, child) {
                      return ElevatedButton(
                        onPressed: () {
                          myModel.doSomething();
                        },
                        child: const Text('Do something'),
                      );
                    },
                  ),
                ),
                // UI 展示
                Container(
                  padding: const EdgeInsets.all(35),
                  color: Colors.blue[200],
                  child: Consumer<String>(
                    builder: (context, myValue, child) => Text(myValue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyModel {
  var someValue = ValueNotifier('Hello');

  void doSomething() async {
    someValue.value = 'Goodbye';
    print(someValue.value);
  }
}
