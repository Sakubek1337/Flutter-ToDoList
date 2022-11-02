import 'package:untitled/model/user.dart';

class Task{

  User user;
  String description;

  Task(this.user, this.description);

  void setUser(User user){
    this.user = user;
  }

  void setDescription(String description){
    this.description = description;
  }

  User getUser(){
    return user;
  }

  String getDescription(){
    return description;
  }
}