// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProxyProviderDemo extends StatelessWidget {
  const ProxyProviderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProxyProviderDemo'),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<MyModel>(
            create: (context) => MyModel(),
          ),
          ProxyProvider<MyModel, AnotherModel>(
            update: (context, myModel, anotherModel) => AnotherModel(myModel),
          ),
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
                            myModel.doSomething('Goodbye');
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
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.red[200],
              child: Consumer<AnotherModel>(
                //      <--- AnotherModel Consumer
                builder: (context, anotherModel, child) {
                  return ElevatedButton(
                    child: const Text('Do something else'),
                    onPressed: () {
                      anotherModel.doSomethingElse();
                    },
                  );
                },
              ),
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
  void doSomething(String value) {
    someValue = value;
    print(someValue);
    notifyListeners();
  }
}

class AnotherModel {
  //                   <--- AnotherModel
  final MyModel _myModel;

  AnotherModel(this._myModel);

  void doSomethingElse() {
    _myModel.doSomething('See you later');
    print('doing something else');
  }
}
