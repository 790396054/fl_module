
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  FlutterErrorDetails? errorDetails;
  ErrorPage({Key? key, this.errorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('错误业务'),),
      body: const Center(
        child: Text("页面丢失了。。。"),
      ),
    );
  }
}
