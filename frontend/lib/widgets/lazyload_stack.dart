import 'package:flutter/material.dart';

class LazyLoadIndexedStack extends StatefulWidget {
  LazyLoadIndexedStack({
    required this.index,
    required this.children,
    super.key,
    Widget? unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
  }) {
    this.unloadWidget = unloadWidget ?? Container();
  }
  late final Widget unloadWidget;
  final AlignmentGeometry alignment;
  final StackFit sizing;
  final TextDirection? textDirection;
  final int index;
  final List<Widget> children;

  @override
  LazyLoadIndexedStackState createState() => LazyLoadIndexedStackState();
}

class LazyLoadIndexedStackState extends State<LazyLoadIndexedStack> {
  late List<Widget> _children;
  final _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _children = _initialChildren();
  }

  @override
  void didUpdateWidget(LazyLoadIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      key: _stackKey,
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }

  List<Widget> _initialChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;
      return index == widget.index ? childWidget : widget.unloadWidget;
    }).toList();
  }
}
