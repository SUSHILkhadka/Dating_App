import 'package:flutter/material.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:plugin_test_2/screens/home_screen.dart';
import 'package:plugin_test_2/screens/new_user_info_screen.dart';
import 'package:plugin_test_2/services/firebase.dart';
import 'package:scoped_model/scoped_model.dart';

TextEditingController mycontroller1 = TextEditingController();
TextEditingController mycontroller2 = TextEditingController();
int loginstat = 1;
var snackbar_object0 = SnackBar(
  content: Text('logged in successfully'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);
var snackbar_object1 = SnackBar(
  content: Text('some unknown error'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

var snackbar_object2 = SnackBar(
  content: Text('No user found'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

var snackbar_object3 = SnackBar(
  content: Text('wrong password'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

class LoginOrRegisterScreen extends StatelessWidget {
  const LoginOrRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ff"),
        ),
        body: Column(
          children: [
            TextField(
              controller: mycontroller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter Email',
              ),
            ),
            TextField(
              controller: mycontroller2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter Password',
              ),
            ),
            TextButton(
                onPressed: () async {
                  await register(mycontroller1.text, mycontroller2.text);
                  
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewUserScreen()));
                },
                child: Text("Register")),
            TextButton(
                onPressed: () async {
                  // loginstat =
                  //     await signin(mycontroller1.text, mycontroller2.text);
                  loginstat=await signin('a@gmail.com', 'aaaaaa');
                  if (loginstat == 1) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackbar_object1);
                  } else if (loginstat == 2) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackbar_object2);
                  } else if (loginstat == 3) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackbar_object3);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackbar_object0);
                  }
                  await appUser.fromJsonToModel();
                  print('This is after ${appUser.hasSavedData}');
                  if (appUser.hasSavedData == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewUserScreen()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen2()));
                  }
                },
                child: Text("SignIn")),
            TextButton(
                onPressed: () async {
                  signout();
                },
                child: Text("SignOut")),
          ],
        ),
      );
    });
  }
}
