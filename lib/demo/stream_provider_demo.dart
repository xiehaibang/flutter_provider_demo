// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

/// StreamProvider 使用例子
///
/// - 当 Stream 中出现新事件时，会通知 Consumer 重建子组件
/// - 你可以把从 stream 中发出的数据当做是不可变的。也就是说 `StreamProvider` 不会监听 model 自身的数据变更。它只监听 stream 中的新事件。
///
class StreamProviderDemo extends StatelessWidget {
  const StreamProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamProviderDemo'),
      ),
      body: StreamProvider<MyModel>(
        initialData: MyModel(someValue: 'default value'),
        create: (context) => getStreamOfMyModel(),
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

  Stream<MyModel> getStreamOfMyModel() {
    return Stream<MyModel>.periodic(
      const Duration(seconds: 1),
      ((computationCount) => MyModel(someValue: '$computationCount')),
    ).take(10);
  }
}

class MyModel {
  var someValue = 'Hello';

  MyModel({required this.someValue});

  void doSomething() async {
    someValue = 'Goodbye';
    print(someValue);
  }
}
