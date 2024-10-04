import 'package:front_end/model/user.dart';

class UserSingleton {
  static UserSingleton ? _userSingleton;
  static User? _user; 

  UserSingleton._();
  static Future <UserSingleton> instance() async{
    _userSingleton ??= UserSingleton._();
    return _userSingleton!;
  } 

  static void setUser(User user){
    _user = user;
  }

  static User? getUser(){
    return _user;
  }

}