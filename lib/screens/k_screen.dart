import 'package:flutter/material.dart';

class kScreen extends StatefulWidget {
  const kScreen({ Key? key }) : super(key: key);

  @override
  _kScreenState createState() => _kScreenState();
}

class _kScreenState extends State<kScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('other screen'),
      
    );
  }
}