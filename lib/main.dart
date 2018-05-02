import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:two_way_binding/app_model.dart';
import 'package:two_way_binding/main_page.dart';
import 'package:two_way_binding/model_provider.dart';



Future<Null> main() async {
  // ignore: deprecated_member_use


  AppModel mainPageModel = new AppModel();

  runApp(new TheApp( model: mainPageModel,));
}

class TheApp extends StatelessWidget {

  final AppModel model;

  const TheApp({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ModelProvider(
      model: model,
      child: new MaterialApp(
        title: 'Binding Demo',
        home: new MainPage(),
      ),
    );
  }
}
