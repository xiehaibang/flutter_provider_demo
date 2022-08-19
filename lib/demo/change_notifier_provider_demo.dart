import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// ChangeNotifierProvider 的使用例子
///
/// - 监听的 model 需要 extends 或 mixin ChangeNotifier
/// - 每当 model 调用 notifyListeners() 时，会通知 Consumer 重建子组件。
///
class ChangeNotifierProviderDeomo extends StatelessWidget {
  const ChangeNotifierProviderDeomo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProviderDemo'),
      ),
      body: ChangeNotifierProvider<MyModel>(
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

class MyModel with ChangeNotifier {
  var someValue = 'Hello';

  void doSomething() {
    someValue = 'Goodbye';
    print(someValue);
    notifyListeners();
  }
}
