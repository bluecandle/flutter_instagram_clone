import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Center(
          child: Text(
        'UPLOAD',
        style: TextStyle(color: Colors.black),
      )),
    );
  }
}
