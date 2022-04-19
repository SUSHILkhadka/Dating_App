import 'package:plugin_test_2/services/firebase.dart';
import 'package:scoped_model/scoped_model.dart';

class AppUser extends Model {
  String name = '', uid = '', sex = '', country = '';
  int age = 0;
  bool hasSavedData = false;
  String prefSex = '';
  int prefAgeLower = 0, prefAgeUpper = 0;
  String prefCountryList = '';
  List<dynamic> Proposals = [''],
      SentProposals = [''],
      MyMatches = [''],
      Rejections = [''],
      RejectedBy = [''];

  int SHOWTOOTHERcount = 0, ALBUMcount = 0;

  makeNewUser(
      String name, int age, String s, String country, String prefSex) async {
    this.uid = await giveuid();
    this.name = name;
    this.age = age;
    this.sex = s;
    this.country = country;
    this.hasSavedData = true;
    this.prefSex = prefSex;
    this.prefAgeLower = age - 10;
    this.prefAgeUpper = age + 10;
    prefCountryList = country;
    this.SHOWTOOTHERcount = 0;
    this.ALBUMcount = 0;
    notifyListeners();
    fromModelToMap(this);
  }

  changePreferences(a, b, c, d) {
    prefSex = a;
    prefAgeLower = b;
    prefAgeUpper = c;
    prefCountryList = d;
    notifyListeners();
    fromModelToMap(this);
  }

  addtoSHOWTOOTHERcount() {
    uploadPhoto(this.uid, "SHOWTOOTHERS", this.SHOWTOOTHERcount);
    this.SHOWTOOTHERcount++;
    notifyListeners();
    fromModelToMap(this);
  }

  decrementSHOWTOOTHERcount() {
    this.SHOWTOOTHERcount--;
    notifyListeners();
  }

  addtoALBUMcount() {
    uploadPhoto2(this.uid, "ALBUM");
    this.ALBUMcount++;
    notifyListeners();
    fromModelToMap(this);
  }

  decrementALBUMcount() {
    this.ALBUMcount--;
    notifyListeners();
  }

  SentPropose(String uid) {
    SentProposals.add(uid);
    AddProposal(uid);
    notifyListeners();
  }

  CancelSentPropose(String uid) {
    SentProposals.remove(uid);
    CancelProposal(uid);
    notifyListeners();
  }

  AcceptPropose(String uid) {
    Proposals.remove(uid);
    MyMatches.add(uid);
    AcceptProposal(uid);
    notifyListeners();
  }

  RejectPropose(String uid) {
    Proposals.remove(uid);
    Rejections.add(uid);
    RejectProposal(uid);
    notifyListeners();
  }

  Future<void> fromJsonToModel() async {
    Map<String, dynamic>? json = await fromDatabasetoJson();
    if (json != null) {
      this.uid = json["uid"];
      this.name = json["name"];
      this.age = json['age'];
      this.sex = json['sex'];
      this.country = json['country'];
      this.hasSavedData = json['hasSavedData'];
      this.prefSex = json['prefSex'];
      this.prefAgeLower = json['prefAgeLower'];
      this.prefAgeUpper = json['prefAgeUpper'];
      this.prefCountryList = json['prefCountryList'];
      this.Proposals = json['Proposals'];
      this.SentProposals = json['SentProposals'];
      this.MyMatches = json['MyMatches'];
      this.Rejections = json['Rejections'];
      this.RejectedBy = json['RejectedBy'];
      this.SHOWTOOTHERcount =
          json['SHOWTOOTHERcount'] == null ? 0 : json['SHOWTOOTHERcount'];
      this.ALBUMcount = json['ALBUMcount'] == null ? 0 : json['ALBUMcount'];
      // this.SHOWTOOTHERcount = 1;
      // this.ALBUMcount = 1;

      // return AppUser()
      //   ..uid = json['uid']
      //   ..age = json['age']
      //   ..country = json['country']
      //   ..prefAgeLower = json['prefAgeLower']
      //   ..s = json['s']
      //   ..name = json['name'];
    }
    notifyListeners();
  }

  fromModelToJson() {
    return {
      'uid': this.uid,
      "name": this.name,
      "age": this.age,
      "sex": this.sex,
      'country': this.country,
      "hasSavedData": this.hasSavedData,
      'prefSex': this.prefSex,
      'prefAgeLower': this.prefAgeLower,
      'prefAgeUpper': this.prefAgeUpper,
      'prefCountryList': this.prefCountryList,
      'Proposals': this.Proposals,
      'SentProposals': this.SentProposals,
      'MyMatches': this.MyMatches,
      'RejectedBy': this.RejectedBy,
      'Rejections': this.Rejections,
      'SHOWTOOTHERcount': this.SHOWTOOTHERcount,
      'ALBUMcount': this.ALBUMcount,
    };
  }
}
