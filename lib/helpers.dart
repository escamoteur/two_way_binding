import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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