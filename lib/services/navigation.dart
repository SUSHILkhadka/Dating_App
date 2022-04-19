import 'package:flutter/material.dart';
import 'package:plugin_test_2/screens/login_or_register.dart';

void navigateUser(BuildContext context){
  //state chcking then routing
    // Navigator.push(
	  //   context,MaterialPageRoute(builder: (context) => NewUserScreen())
	  //   );
      Navigator.push(
	    context,MaterialPageRoute(builder: (context) => LoginOrRegisterScreen())
	    );

}