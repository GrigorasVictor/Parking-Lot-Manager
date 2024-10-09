import 'dart:io';

import 'package:front_end/model/registration.dart';
import 'package:front_end/model/user.dart';

class UserSingleton {
  static UserSingleton ? _userSingleton;
  static User? _user; 
  static File? _file;

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

  static void addNumberPlate(VehicleRegistration vehicleRegistration){
    _user!.registrations.add(vehicleRegistration);
  }

  static List<VehicleRegistration> getVehicleRegistrations(){
    return _user!.registrations;
  }

  static File? getImage(){
    return _file;
  }
  
  static void setImage(File file){
    _file=file;
  }
}