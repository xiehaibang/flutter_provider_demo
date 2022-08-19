// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider_demo/demo/future_provider_demo.dart';
import 'package:provider_demo/demo/multi_provider_demo.dart';

import 'package:provider_demo/demo/provider_demo.dart';
import 'package:provider_demo/demo/change_notifier_provider_demo.dart';
import 'package:provider_demo/demo/proxy_provider_demo.dart';
import 'package:provider_demo/demo/stream_provider_demo.dart';
import 'package:provider_demo/demo/value_listenable_provider_demo.dart';

enum ProviderType {
  multi,
  proxy,
  future,
  stream,
  provider,
  changeNotifier,
  valueListenable,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Provider的使用')),
        body: ListView.separated(
          itemCount: ProviderType.values.length,
          itemBuilder: (context, index) => TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                switch (ProviderType.values[index]) {
                  case ProviderType.multi:
                    return const MultiProviderDemo();
                  case ProviderType.proxy:
                    return const ProxyProviderDemo();
                  case ProviderType.future:
                    return const FutureProviderDemo();
                  case ProviderType.stream:
                    return const StreamProviderDemo();
                  case ProviderType.provider:
                    return const ProviderDemo();
                  case ProviderType.changeNotifier:
                    return const ChangeNotifierProviderDeomo();
                  case ProviderType.valueListenable:
                    return const ValueListenableProviderDemo();
                }
              }));
            },
            child: Container(
              height: 60,
              alignment: Alignment.centerLeft,
              child: Text(ProviderType.values[index].toString()),
            ),
          ),
          separatorBuilder: (context, index) => Container(color: Colors.grey[300], height: 1),
        ),
      ),
    );
  }
}
