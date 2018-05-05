import 'dart:async';

import 'package:flutter/material.dart';
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
        theme: new ThemeData.dark().copyWith(
          disabledColor: Colors.white12,
          primaryColor: new Color(0xFF1C262A),
          buttonColor: new Color(0xFF1C262A),
          accentColor: new Color(0xFFA7D9D5),
          scaffoldBackgroundColor: new Color.fromRGBO(38, 50, 56, 1.0),),
        
        home: new MainPage(),
      ),
    );
  }
}
