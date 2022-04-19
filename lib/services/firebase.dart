import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:html';

Future<void> register(String name, String passwor) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: name, password: passwor);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  }
}

Future<int> signin(String name, String passwor) async {
  int result = 0;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: name, password: passwor);
  } on FirebaseAuthException catch (e) {
    result = 1;
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      result = 2;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      result = 3;
    }
  }

  var firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) {
    print('user is null');
  }
  if (firebaseUser != null) {
    print("current user's uid isnot NULL.uid= ");
    print(firebaseUser.uid);
  }

  return result;
}

void signout() async {
  await FirebaseAuth.instance.signOut();
  var firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser == null) {
    print("signed out successfully with id= $firebaseUser.uid");
  }
  if (firebaseUser != null) {
    print("user isnot null");
  }
}

 Future<String> giveuid() async{
  String temp='defaultUID';
    var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    temp=a.uid;
  }
  return temp;

}

Future<void> fromModelToMap(AppUser appUser) async {
  Map<String, dynamic> map = appUser.fromModelToJson();

  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    await FirebaseFirestore.instance
        .collection('appUser')
        .doc('${a.uid}')
        .set(map);
  }
}

Future<Map<String, dynamic>?> fromDatabasetoJson() async {
  var a = await FirebaseAuth.instance.currentUser;
  var json;
  if (a != null) {
    var snapshot =
        await FirebaseFirestore.instance.collection('appUser').doc(a.uid).get();

    if (snapshot.exists) {
      print(snapshot.data());
      json = snapshot.data();
    }

    // Stream for_dynamicWidgets =
    //     FirebaseFirestore.instance.collection('appUser').doc(a.uid).snapshots();
    // for_dynamicWidgets.listen((event) {
    //   print(event['name']);
    //   json = event;
    // });
  }
  return json;
}

// void read() async {
//   AppUser appUser = AppUser();
//   var a = FirebaseAuth.instance.currentUser;
//   if (a != null) {
//     var collection =
//         await FirebaseFirestore.instance.collection('appUser').doc(a.uid).get();
//     var json = collection.data();
//     print(json);
//     var b = json as Map<String, dynamic>;
//     print('name is is ${json['name']}');
//     appUser.fromMapToModel(b);
//     print(appUser.name);
//   }
// }

AddProposal(String uid) async {
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    List<String> elements = ['${a.uid}'];

    await FirebaseFirestore.instance
        .collection('appUser')
        .doc('$uid')
        .update({'Proposals': FieldValue.arrayUnion(elements)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}

CancelProposal(String uid) async {
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    List<String> elements = ['${a.uid}'];

    await FirebaseFirestore.instance
        .collection('appUser')
        .doc('$uid')
        .update({'Proposals': FieldValue.arrayRemove(elements)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}

AcceptProposal(String uid) async {
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    List<String> elements = ['${a.uid}'];

    await FirebaseFirestore.instance
        .collection('appUser')
        .doc('$uid')
        .update({'MyMatches': FieldValue.arrayUnion(elements)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}

RejectProposal(String uid) async {
  var a = await FirebaseAuth.instance.currentUser;
  if (a != null) {
    List<String> elements = ['${a.uid}'];

    await FirebaseFirestore.instance
        .collection('appUser')
        .doc('$uid')
        .update({'RejectedBy': FieldValue.arrayUnion(elements)})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}

Future<Map<String, dynamic>?> getShowingData(String uid) async {
  var json;
  var snapshot =
      await FirebaseFirestore.instance.collection('appUser').doc(uid).get();

  if (snapshot.exists) {
    print(snapshot.data());
    json = snapshot.data();
  }
  return json;
}

Future<String> bodyPicUrl(uid, index) async {
  var a = await FirebaseStorage.instance
      .ref()
      .child('appUser/${uid}/SHOWTOOTHER/${index}')
      .getDownloadURL();
  return a;
}

Future<String> getuid() async {
  var a = await FirebaseAuth.instance.currentUser;
  var temp = '';
  if (a != null) {
    temp = a.uid;
  }
  return temp;
}

Future<void> uploadPhoto(uid, where, int name) async {
  var uploadInput = FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final file = uploadInput.files?.first;
    final reader = FileReader();
    if (file != null) reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) async {
      var temp = name + 1;
      if (file != null) {
        FirebaseStorage.instance
            .ref('appUser/${uid}/SHOWTOOTHER/${temp}')
            .putBlob(file);
      }
    });
  });
}

uploadPhoto2(uid, where) async {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  var uploadInput = FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final file = uploadInput.files?.first;
    final reader = FileReader();
    if (file != null) reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) async {
      if (file != null) {
        FirebaseStorage.instance
            .ref('appUser/${uid}/ALBUM/${timestamp()}')
            .putBlob(file);
      }
    });
  });
}

Future<List<String>> listAllPhoto(uid) async {
  var gg = await FirebaseStorage.instance.ref("appUser/${uid}/ALBUM").listAll();
  List<String> temp = [''];
  for (var a in gg.items) {
    var url = await a.getDownloadURL();
    temp.add(url);
  }
  return temp;
}
