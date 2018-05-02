import 'package:flutter/material.dart';
import 'package:two_way_binding/model_provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = ModelProvider.of(context);
    return new Scaffold(
      appBar: new AppBar(title: Text("Binding Demo")),
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text("Single Text field:"),
            TextField(
                controller: TextEditingController(
              text: ModelProvider.of(context).singleFieldValue,
            ),
            onChanged: ( newValue) => ModelProvider.of(context).singleFieldValue = newValue,),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Container(
                color: Colors.blue,
                height: 3.0,
              ),
            ),
            Text("Multiple Fields:"),
            Expanded(
              child: new ListView.builder(
                  itemCount: ModelProvider.of(context).formEntries.length,
                  itemBuilder: (context, index) {
                    return new Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ModelProvider.of(context).formEntries[index].title,
                            style: new TextStyle(fontSize: 20.0),
                          ),
                          TextField(
                            controller: new TextEditingController(
                                text: ModelProvider.of(context).formEntries[index].content),
                            onChanged: (newValue) => ModelProvider.of(context).formEntries[index].content = newValue ,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            MaterialButton(
              child: Text("Print"),
              onPressed: ModelProvider.of(context).printContent,
            )
          ],
        ),
      ),
    );
  }
}
