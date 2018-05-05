import 'package:flutter/material.dart';
import 'package:two_way_binding/helpers.dart';
import 'package:two_way_binding/keys.dart';
import 'package:two_way_binding/model_provider.dart';



class MainPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Binding Demo")),
      body:
        SingleChildScrollView(child: 
          Padding(padding: const EdgeInsets.all(8.0),
                  child: 
            Column(children: <Widget>
            [
              Text("Single Text field:"),

              TextField( controller:  TextEditingController(text: ModelProvider.of(context).singleFieldValue),
                         onChanged: ModelProvider.of(context).updateSingleValueField),
              Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                  child: Container(
                  color: Colors.blue,
                  height: 3.0,
                ),
              ),

              Text("Multiple Fields:"),

              new Form(key: AppKeys.form,
                    child: 
                    ColumnBuilder(
                        itemCount: ModelProvider.of(context).formEntries.length,
                        itemBuilder: (context, index) 
                        {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child:    
                              EnsureVisible(duration: Duration(milliseconds: 200), ensureVisibleBuilder: (context, focusNode) =>
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    Text(ModelProvider.of(context).formEntries[index].title,
                                         style: TextStyle(fontSize: 20.0),
                                         ),
                                  
                                    TextFormField(
                                        focusNode: focusNode,
                                        controller: TextEditingController(text: ModelProvider.of(context).formEntries[index].content),
                                        // because a new lambda function is created for each item, it can capture the current value of index
                                        onSaved: (newValue) => ModelProvider.of(context).updateFormEntry(index, newValue),
                                        )
                                  ],
                                ),
                              )
                            );
                          }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: MaterialButton( color: Theme.of(context).buttonColor,
                          child: Text("Print"),
                          onPressed: () 
                                { 
                                  FormState state = AppKeys.form.currentState;
                                  state.save();
                                  ModelProvider.of(context).printContent();
                                }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
