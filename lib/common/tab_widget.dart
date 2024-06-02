import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width / 3.4,
      height: 28,
      child: Center(
          child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      )),
    );
  }
}
