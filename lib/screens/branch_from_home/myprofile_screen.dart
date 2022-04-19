import 'package:flutter/material.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:plugin_test_2/services/firebase.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plugin_test_2/widget/widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
      return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Text(appUser.name),
                Text("${appUser.age}"),
                Text("${appUser.sex}")
              ],
            ),
            Row(
              children: [
                Text("SHOW TO OTHERS"),
                Text('${appUser.SHOWTOOTHERcount}'),
                IconButton(
                  onPressed: () async {
                    appUser.addtoSHOWTOOTHERcount();
                    // fromModelToMap(appUser);
                  },
                  icon: Icon(Icons.add_a_photo),
                )
              ],
            ),
            photosingrid(
              uid: appUser.uid,
            ),
            Row(
              children: [
                Text("ALBUM"),
                IconButton(
                  onPressed: () {
                    appUser.addtoALBUMcount();
                    // fromModelToMap(appUser);
                  },
                  icon: Icon(Icons.add_a_photo),
                )
              ],
            ),
            photoingird2(
              uid: appUser.uid,
            ),
          ],
        ),
      );
    });
  }
}
