import 'package:flutter/material.dart';

class EditableTextWidget extends StatefulWidget {
  final double initialValue;

  const EditableTextWidget({super.key, required this.initialValue});

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.initialValue.toStringAsFixed(1)} kg",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
