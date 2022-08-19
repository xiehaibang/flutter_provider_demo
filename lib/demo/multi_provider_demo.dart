// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MultiProviderDemo extends StatelessWidget {
  const MultiProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultiProviderDemo'),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<MyModel>(create: (context) => MyModel()),
          ChangeNotifierProvider<AnotherModel>(create: (context) => AnotherModel()),
        ],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.green[200],
                    child: Consumer<MyModel>(
                      //            <--- MyModel Consumer
                      builder: (context, myModel, child) {
                        return ElevatedButton(
                          child: const Text('Do something'),
                          onPressed: () {
                            // We have access to the model.
                            myModel.doSomething();
                          },
                        );
                      },
                    )),
                Container(
                  padding: const EdgeInsets.all(35),
                  color: Colors.blue[200],
                  child: Consumer<MyModel>(
                    //              <--- MyModel Consumer
                    builder: (context, myModel, child) {
                      return Text(myModel.someValue);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.red[200],
                    child: Consumer<AnotherModel>(
                      //      <--- AnotherModel Consumer
                      builder: (context, anotherModel, child) {
                        return ElevatedButton(
                          child: const Text('Do something'),
                          onPressed: () {
                            anotherModel.doSomething();
                          },
                        );
                      },
                    )),
                Container(
                  padding: const EdgeInsets.all(35),
                  color: Colors.yellow[200],
                  child: Consumer<AnotherModel>(
                    //        <--- AnotherModel Consumer
                    builder: (context, anotherModel, child) {
                      return Text('${anotherModel.someValue}');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
  //                        <--- MyModel
  String someValue = 'Hello';
  void doSomething() {
    someValue = 'Goodbye';
    print(someValue);
    notifyListeners();
  }
}

class AnotherModel with ChangeNotifier {
  //                   <--- AnotherModel
  int someValue = 0;
  void doSomething() {
    someValue = 5;
    print(someValue);
    notifyListeners();
  }
}
