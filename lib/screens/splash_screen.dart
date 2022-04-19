import 'package:flutter/material.dart';
import 'package:plugin_test_2/services/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
       Future.delayed(const Duration(milliseconds: 1000), () {
      navigateUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("this is splashscreen"),
    );
  }
}
