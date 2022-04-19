import 'package:flutter/material.dart';
import 'package:plugin_test_2/model/index/index1.dart';
import 'package:plugin_test_2/model/index/index2.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:plugin_test_2/screens/branch_from_home/myprofile_screen.dart';
import 'package:plugin_test_2/screens/branch_from_home/pro_screen.dart';
import 'package:plugin_test_2/screens/preference_screen.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class HomeScreen2 extends StatefulWidget {
//   const HomeScreen2({Key? key}) : super(key: key);

//   @override
//   _HomeScreen2State createState() => _HomeScreen2State();
// }

// class _HomeScreen2State extends State<HomeScreen2> {
//   int? _dynamicProposals, _dynamicMyMatches, _dynamicSentProposals;
//   @override
//   void initState() {
//     super.initState();
//     activeListeners();
//   }

//   activeListeners() async {
//     var d = await FirebaseAuth.instance.currentUser;
//     if (d != null) {
//       Stream stream = await FirebaseFirestore.instance
//           .collection('appUser')
//           .doc(d.uid)
//           .snapshots();
//       stream.listen((event) {
//         var a = (event['Proposals'].length);
//         var b = (event['MyMatches'].length);
//         var c = (event['SentProposals'].length);
//         setState(() {
//           _dynamicProposals = a;
//           _dynamicMyMatches = b;
//           _dynamicSentProposals = c;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text("Preference Setup"),
//         ),
// body: Column(
//   children: [
//     TextButton(onPressed: () {}, child: Text("Search New Matches")),
//     TextButton(
//         onPressed: () {
//           print("inside homescreen");
//           print(appUser.uid);
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => MyProfileScreen()));
//         },
//         child: Text("Edit Profile")),
//     TextButton(
//         onPressed: () {
//           appUser.fromJsonToModel();
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ProposalsScreen(
//                         index: appUser.Proposals.length,
//                         appUser: appUser,
//                       )));
//         },
//         child: Text("Proposals  ${_dynamicProposals}")),
//     TextButton(
//         onPressed: () {},
//         child: Text("Sent Proposals  ${_dynamicSentProposals}")),
//     TextButton(
//         onPressed: () {},
//         child: Text("My Matches  ${_dynamicMyMatches}")),
//     TextButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => PreferenceScreen()));
//         },
//         child: Text("Preferences")),
//     TextButton(onPressed: () {}, child: Text("My Rejected Trashes list ")),
//     TextButton(onPressed: () {}, child: Text("Rejected By list")),
//   ],
// ),
//       );
//     });
//   }
// }

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  _HomeScreen2State createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int? _dynamicProposals, _dynamicMyMatches, _dynamicSentProposals;
  @override
  void initState() {
    super.initState();
    activeListeners();
  }

  activeListeners() async {
    var d = await FirebaseAuth.instance.currentUser;
    if (d != null) {
      Stream stream = await FirebaseFirestore.instance
          .collection('appUser')
          .doc(d.uid)
          .snapshots();
      stream.listen((event) {
        var a = (event['Proposals'].length);
        var b = (event['MyMatches'].length);
        var c = (event['SentProposals'].length);
        setState(() {
          _dynamicProposals = a;
          _dynamicMyMatches = b;
          _dynamicSentProposals = c;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Preference Setup"),
        ),
        body: Column(
          children: [
            TextButton(onPressed: () {}, child: Text("Search New Matches")),
            TextButton(
                onPressed: () {
                  print("inside homescreen");
                  print(appUser.uid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfileScreen()));
                },
                child: Text("Edit Profile")),
            TextButton(
                onPressed: () {
                  // appUser.fromJsonToModel();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                      create: (context) => index2())
                                ],
                                child: ProScreen(),
                              )));
                  // print(" in home screen=${context.watch<index2>().index}");
                },
                child: Text("Proposals  ${_dynamicProposals}")),
            TextButton(
                onPressed: () {},
                child: Text("Sent Proposals  ${_dynamicSentProposals}")),
            TextButton(
                onPressed: () {},
                child: Text("My Matches  ${_dynamicMyMatches}")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreferenceScreen()));
                },
                child: Text("Preferences")),
            TextButton(
                onPressed: () {}, child: Text("My Rejected Trashes list ")),
            TextButton(onPressed: () {}, child: Text("Rejected By list")),
          ],
        ),
      );
    });
  }
}
