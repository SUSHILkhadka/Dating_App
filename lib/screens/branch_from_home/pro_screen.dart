import 'package:flutter/material.dart';
import 'package:plugin_test_2/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';
import 'package:plugin_test_2/model/index/index2.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:plugin_test_2/services/firebase.dart';

class ProScreen extends StatefulWidget {
  const ProScreen({Key? key}) : super(key: key);

  @override
  _ProScreenState createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  String namer = 'f';
  int searchIndex = 1;
  String temp = '';
  int bodyPicIndex = 1;
  int acceptButton = 0, rejectButton = 0;
  Map<String, dynamic>? json;
  String _profilePicUrl = '';
  String _bodyPicUrl = '';
  String uid='';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchIndex = context.watch<index2>().index;
    print("search indes is ${searchIndex}");
    func();
  }

  func() async {
     uid = ScopedModel.of<AppUser>(context).Proposals[searchIndex];
    Map<String, dynamic>? temp1 = await getShowingData(uid);
    String temp2 = await bodyPicUrl(uid, 1);

    setState(() {
      json = temp1;
      _profilePicUrl = temp2;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppUser>(builder: (context, child, appUser) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Proposals List"),
          ),
          body: Column(
            children: [
              SimpleGestureDetector(
                onHorizontalSwipe: (direction) {
                  if (direction == SwipeDirection.left) {
                    if (searchIndex < appUser.Proposals.length - 1)
                      context.read<index2>().increment();
                  }
                  if (direction == SwipeDirection.right) {
                    if (searchIndex > 1) context.read<index2>().decrement();
                  }
                },
                swipeConfig: SimpleSwipeConfig(
                  verticalThreshold: 40.0,
                  horizontalThreshold: 40.0,
                  swipeDetectionBehavior:
                      SwipeDetectionBehavior.continuousDistinct,
                ),
                child: Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.lightBlue,
                    child: Row(
                      children: [
                        Image.network(_profilePicUrl),
                        Text(
                            "${searchIndex} ${json?["name"]}  ${json?["age"]}   ${json?["sex"]}"),
                      ],
                    )),
              ),
              SimpleGestureDetector(
                onHorizontalSwipe: (direction)async {
                  if (direction == SwipeDirection.left) {
                    if (bodyPicIndex < json?["SHOWTOOTHERcount"]) {
                      setState(() {
                        bodyPicIndex++;
                        
                      });
                    
                      String temp3 = await bodyPicUrl(uid, bodyPicIndex);
                      setState(() {
                        
                            _bodyPicUrl = temp3;
                      });
                      print(bodyPicIndex);
                    }
                  }
                  if (direction == SwipeDirection.right) {
                    if (bodyPicIndex > 1) {
                      setState(() {
                        bodyPicIndex--;
                        
                      });
                    
                      String temp3 = await bodyPicUrl(uid, bodyPicIndex);
                      setState(() {
                        
                            _bodyPicUrl = temp3;
                        
                      });
                      print(bodyPicIndex);
                    }
                    ;
                  }
                },
                swipeConfig: SimpleSwipeConfig(
                  verticalThreshold: 40.0,
                  horizontalThreshold: 40.0,
                  swipeDetectionBehavior:
                      SwipeDetectionBehavior.continuousDistinct,
                ),
                child:bodyPicIndex==1?Image.network(_profilePicUrl,height: 400,width: 500,) :Image.network(
                  _bodyPicUrl,
                  height: 400,
                  width: 500,
                ),
              ),
              Row(
                children: [
                  acceptButton == 0
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              acceptButton = 1;
                              rejectButton = 0;
                            });
                          },
                          icon: Icon(Icons.check_box))
                      : IconButton(
                          onPressed: () {}, icon: Icon(Icons.block_flipped)),
                  rejectButton == 0
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              rejectButton = 1;
                              acceptButton = 0;
                            });
                          },
                          icon: Icon(Icons.wallet_membership_rounded))
                      : IconButton(
                          onPressed: () {}, icon: Icon(Icons.block_flipped)),
                ],
              ),
            ],
          ));
    });
  }
}
