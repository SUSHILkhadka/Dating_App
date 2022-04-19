import 'package:flutter/material.dart';
import 'package:plugin_test_2/services/firebase.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plugin_test_2/model/user_model.dart';

double globalheight = 200;

class photoingird2 extends StatefulWidget {
  const photoingird2({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _photoingird2State createState() => _photoingird2State();
}

class _photoingird2State extends State<photoingird2> {
  List<String> urls = [''];
  int len = 0;
  @override
  void initState() {
    super.initState();
    fetchAlbum();
  }

  fetchAlbum() async {
    var list = await listAllPhoto(widget.uid);
    setState(() {
      urls = list;
      len = urls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
      return SizedBox(
          height: globalheight,
          child: len > 0
              ? GridView.builder(
                  itemCount: len - 1,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.5),
                  itemBuilder: (contex, index) => tinyphotoviewer2(
                      uid: appUser.uid,
                      index: index,
                      imgurl: urls[len - index - 1]))
              : Text("no images in album"));
    });
  }
}

class tinyphotoviewer2 extends StatefulWidget {
  const tinyphotoviewer2(
      {Key? key, required this.uid, required this.index, required this.imgurl})
      : super(key: key);
  final int index;
  final String imgurl, uid;

  @override
  _tinyphotoviewer2State createState() => _tinyphotoviewer2State();
}

class _tinyphotoviewer2State extends State<tinyphotoviewer2> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => bigphotoviewer2(
                        uid: widget.uid,
                        index: widget.index,
                        imgurl: widget.imgurl,
                      )));
        },
        child: Image.network(widget.imgurl));
  }
}

class bigphotoviewer2 extends StatefulWidget {
  const bigphotoviewer2({
    Key? key,
    required this.uid,
    required this.index,
    required this.imgurl,
  }) : super(key: key);
  final String uid, imgurl;
  final int index;

  @override
  _bigphotoviewer2State createState() => _bigphotoviewer2State();
}

class _bigphotoviewer2State extends State<bigphotoviewer2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.network(
          widget.imgurl,
          height: 300,
          width: double.infinity,
        ),
        TextButton(onPressed: () {}, child: Text("Edit")),
        TextButton(
          onPressed: () {},
          child: Text("Delete"),
        )
      ],
    ));
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class photosingrid extends StatefulWidget {
  const photosingrid({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _photosingridState createState() => _photosingridState();
}

class _photosingridState extends State<photosingrid> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context11, child, appUser) {
      print(appUser.SHOWTOOTHERcount);
      return SizedBox(
          height: globalheight,
          child: appUser.SHOWTOOTHERcount > 0
              ? GridView.builder(
                  itemCount: appUser.SHOWTOOTHERcount,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.5),
                  itemBuilder: (contex, index) =>
                      tinyphotoviewer(url: appUser.uid, index: index + 1))
              : Text("No images to show"));
    });
  }
}

class tinyphotoviewer extends StatefulWidget {
  const tinyphotoviewer({Key? key, required this.url, required this.index})
      : super(key: key);
  final String url;
  final int index;

  @override
  _tinyphotoState createState() => _tinyphotoState();
}

class _tinyphotoState extends State<tinyphotoviewer> {
  var url = '';

  @override
  void initState() {
    super.initState();
    fetchimgurl();
  }

  fetchimgurl() async {
    var temp = await bodyPicUrl(widget.url, widget.index);
    setState(() {
      url = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    bigphotoviewer(url: url, index: widget.index)));
      },
      child: Image.network(url),
    );
  }
}

class bigphotoviewer extends StatefulWidget {
  const bigphotoviewer({Key? key, required this.url, required this.index})
      : super(key: key);
  final String url;
  final int index;

  @override
  _bigphotoviewerState createState() => _bigphotoviewerState();
}

class _bigphotoviewerState extends State<bigphotoviewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.network(
          widget.url,
          height: 300,
          width: double.infinity,
        ),
        TextButton(onPressed: () {}, child: Text("Edit")),
        TextButton(
          onPressed: () {},
          child: Text("Delete"),
        )
      ],
    ));
  }
}
