import 'package:orangedatacenter/res/SharedPreference.dart';

class UserData{
  String ?name;
  String ?email;
  String ?password;
  String ?gender;
  String ?phoneNumber;
  int ?universityId;
  int ?gradeId;
  UserData.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    password=json['password'];
    gender=json['gender'];
    phoneNumber=json['phoneNumber'];
    universityId=json['universityId'];
    gradeId=json['gradeId'];
    storeInCache();
  }

  void storeInCache(){
    SharedCache.saveData(key: 'name', value:name);
    SharedCache.saveData(key: 'email', value:email);
    SharedCache.saveData(key: 'password', value:password);
    SharedCache.saveData(key: 'gender', value:gender);
    SharedCache.saveData(key: 'phoneNumber', value:phoneNumber);
    SharedCache.saveData(key: 'universityId', value:universityId);
    SharedCache.saveData(key: 'gradeId', value:gradeId);
  }
  static void clearCache(){
    SharedCache.removeData(key: 'name');
    SharedCache.removeData(key: 'email');
    SharedCache.removeData(key: 'password');
    SharedCache.removeData(key: 'gender');
    SharedCache.removeData(key: 'phoneNumber');
    SharedCache.removeData(key: 'universityId');
    SharedCache.removeData(key: 'gradeId');
    SharedCache.removeData(key: 'token');
  }
}