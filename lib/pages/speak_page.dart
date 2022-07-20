
import 'package:flutter/material.dart';

class SpeakPage extends StatefulWidget {
  const SpeakPage({Key? key}) : super(key: key);

  @override
  State<SpeakPage> createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Speak"),);
  }
}
