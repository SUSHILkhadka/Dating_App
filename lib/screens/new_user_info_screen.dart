import 'package:flutter/material.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:plugin_test_2/screens/home_screen.dart';
import 'package:plugin_test_2/services/firebase.dart';
import 'package:scoped_model/scoped_model.dart';

var mycontroller1 = TextEditingController();
var mycontroller2 = TextEditingController();
var mycontroller3 = TextEditingController();
var mycontroller4 = TextEditingController();
var mycontroller5 = TextEditingController();

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({Key? key}) : super(key: key);

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
                labelText: 'Name',
                hintText: 'Enter Name',
              ),
            ),
            TextField(
              controller: mycontroller2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'age',
                hintText: 'Enter age',
              ),
            ),
            TextField(
              controller: mycontroller3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'sex',
                hintText: 'Enter sex',
              ),
            ),
            TextField(
              controller: mycontroller4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'country',
                hintText: 'Enter country',
              ),
            ),
            TextField(
              controller: mycontroller5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Preference sex',
                hintText: 'Enter preference sex',
              ),
            ),
            TextButton(
                onPressed: () async {
                  print(int.parse(mycontroller2.text) + 10);
                  appUser.makeNewUser(
                      mycontroller1.text,
                      int.parse(mycontroller2.text),
                      mycontroller3.text,
                      mycontroller4.text,
                      mycontroller5.text);
                  fromModelToMap(appUser);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen2()));
                },
                child: Text("Save and Proceed")),
          ],
        ),
      );
    });
  }
}
