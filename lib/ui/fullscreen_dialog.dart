import 'package:flutter/material.dart';

class FullScreenDialog extends StatelessWidget {
  final Widget child;
  final Color color;

  FullScreenDialog({@required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 50),
        Expanded(
          child: Material(
            elevation: 20,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: this.color ?? Colors.white,
            child: child,
          ),
        ),
      ],
    );
  }
}