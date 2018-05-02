import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:two_way_binding/model_provider.dart';


typedef Widget EnsureVisibleBuilder(BuildContext context, FocusNode focusNode);

class EnsureVisible extends StatefulWidget {
    final EnsureVisibleBuilder ensureVisibleBuilder;
    final double alignment;
    final Duration duration;
    final Curve curve;

    const EnsureVisible({
        Key key,
        @required this.ensureVisibleBuilder,
        this.alignment: 0.0,
        this.duration: Duration.zero,
        this.curve: Curves.ease,
    }) : super(key: key);

    @override
    _EnsureVisibleState createState() => _EnsureVisibleState();
}

class _EnsureVisibleState extends State<EnsureVisible> {
    final FocusNode _focusNode = new FocusNode();

    @override
    void initState() {
        super.initState();
        _focusNode.addListener(_ensureVisible);
    }

    @override
    void dispose() {
        _focusNode.removeListener(_ensureVisible);
        super.dispose();
    }

    void _ensureVisible() {
        if(_focusNode.hasFocus){
            new Future.delayed(Duration(milliseconds: 400),()=>
            Scrollable.ensureVisible(context, alignment: widget.alignment,
                duration: widget.duration, curve: widget.curve));
        

        }
    }

    @override
    Widget build(BuildContext context) {
        return widget.ensureVisibleBuilder(context, _focusNode);
    }
}

class ScrollViewWithHeight extends StatelessWidget {
    final Widget child;

    const ScrollViewWithHeight({Key key, this.child}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return new SingleChildScrollView(
                child: new ConstrainedBox(
                    constraints: constraints.copyWith(minHeight: constraints.maxHeight, maxHeight: double.infinity),
                    child: child,
                ),
            );
        });
    }
}


class ColumnBuilder extends StatelessWidget {
    final IndexedWidgetBuilder itemBuilder;
    final MainAxisAlignment mainAxisAlignment;
    final MainAxisSize mainAxisSize;
    final CrossAxisAlignment crossAxisAlignment;
    final TextDirection textDirection;
    final VerticalDirection verticalDirection;
    final int itemCount;

    const ColumnBuilder({
        Key key,
        @required this.itemBuilder,
        @required this.itemCount,
        this.mainAxisAlignment: MainAxisAlignment.start,
        this.mainAxisSize: MainAxisSize.max,
        this.crossAxisAlignment: CrossAxisAlignment.center,
        this.textDirection,
        this.verticalDirection: VerticalDirection.down,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Column(
            children: new List.generate(this.itemCount,
                    (index) => this.itemBuilder(context, index)).toList(),
        );
    }
}


class MainPage extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Binding Demo")),
      body: new ScrollViewWithHeight(
              child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Single Text field:"),
              TextField(
                  controller: TextEditingController(
                    text: ModelProvider.of(context).singleFieldValue,
                  ),
                  onChanged: ModelProvider.of(context).updateSingleValueField),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Container(
                  color: Colors.blue,
                  height: 3.0,
                ),
              ),
              Text("Multiple Fields:"),
              ColumnBuilder(
                  itemCount: ModelProvider.of(context).formEntries.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ModelProvider.of(context).formEntries[index].title,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        
                          EnsureVisible(duration: Duration(milliseconds: 200), ensureVisibleBuilder: (context, focusNode)
                          =>
                          TextField(focusNode: focusNode,
                            controller: TextEditingController(
                                text: ModelProvider
                                    .of(context)
                                    .formEntries[index]
                                    .content),
                            // because a new lambda function is created for each item, it can capture the current value of index
                            onChanged: (newValue) => ModelProvider
                                .of(context)
                                .updateFormEntry(index, newValue),
                          ))
                        ],
                      ),
                    );
                  }),
              MaterialButton(
                child: Text("Print"),
                onPressed: ModelProvider.of(context).printContent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
