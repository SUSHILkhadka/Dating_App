import 'package:flutter/material.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:plugin_test_2/services/firebase.dart';
import 'package:scoped_model/scoped_model.dart';

var mycontroller1 = TextEditingController();
var mycontroller2 = TextEditingController();
var mycontroller3 = TextEditingController();
var mycontroller4 = TextEditingController();
var mycontroller5 = TextEditingController();

class PreferenceScreen extends StatelessWidget {
  PreferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Preference Setup"),
        ),
        body: Column(
          children: [
            TextField(
              controller: mycontroller1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Preferred sex',
                hintText: 'Enter Preferred sex',
              ),
            ),
            TextField(
              controller: mycontroller2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Lower age limit',
                hintText: 'Enter lower age limit',
              ),
            ),
            TextField(
              controller: mycontroller3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Upper age limit',
                hintText: 'Enter upper age limit',
              ),
            ),
            TextField(
              controller: mycontroller4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Preferred country',
                hintText: 'Enter preferred country',
              ),
            ),
            TextButton(
                onPressed: () {
                  appUser.changePreferences(
                      mycontroller1.text,
                      int.parse(mycontroller2.text),
                      int.parse(mycontroller3.text),
                      mycontroller4.text);
                  fromModelToMap(appUser);
                  Navigator.pop(context);
                },
                child: Text("Save and Back to Home Screen")),
          ],
        ),
      );
    });
  }
}
