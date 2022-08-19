// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// FutureProvider 的使用例子
///
/// - Provider 不会监听 model 自身的数据变更，因此更改 model 中的数据时，Consumer 不会重建它的子组件。
///
/// - FutureProvider 会监听一个 Future，当 Future 完成时，会通知 Consumer 重建它的子组件。
///
/// - 在使用上和 FutureBuilder 基本一样，并没有什么明显的优势。
///
class FutureProviderDemo extends StatelessWidget {
  const FutureProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProviderDemo'),
      ),
      body: FutureProvider<MyModel>(
        initialData: MyModel(someValue: 'default value'),
        create: (context) => someAsyncFunctionToGetMyModel(),
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
              child: Consumer<MyModel>(
                builder: (context, myModel, child) => Text(myModel.someValue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<MyModel> someAsyncFunctionToGetMyModel() async {
    await Future.delayed(const Duration(seconds: 3));
    return MyModel(someValue: 'new data');
  }
}

class MyModel {
  var someValue = 'Hello';

  MyModel({required this.someValue});

  void doSomething() async {
    await Future.delayed(const Duration(seconds: 2));
    someValue = 'Goodbye';
    print(someValue);
  }
}
