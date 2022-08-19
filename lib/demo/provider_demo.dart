// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// Provider Widget 的使用例子
///
/// Provider 不会监听 model 自身的数据变更，因此更改 model 中的数据时，Consumer 不会重建它的子组件
///
class ProviderDemo extends StatelessWidget {
  const ProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProviderDemo'),
      ),
      body: Provider<MyModel>(
        create: (context) => MyModel(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 事件触发
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green[200],
              child: Consumer<MyModel>(
                builder: (context, myModel, child) => ElevatedButton(
                  onPressed: () {
                    myModel.doSomething();
                  },
                  child: const Text('Do something'),
                ),
              ),
            ),
            // UI 展示
            Container(
              padding: const EdgeInsets.all(35),
              color: Colors.blue[200],
              child: Consumer<MyModel>(
                builder: (context, myModel, child) => Text(myModel.someValue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyModel {
  var someValue = 'Hello';

  void doSomething() {
    someValue = 'Goodbye';
    print(someValue);
  }
}
