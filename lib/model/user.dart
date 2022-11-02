
class User{
  String name;
  String password;
  int tasks = 0;

  User(this.name, this.password);

  String getName(){
    return name;
  }

  String getPassword(){
    return password;
  }

  int getTasks(){
    return tasks;
  }

  void setName(String name){
    this.name = name;
  }

  void setPassword(String password){
    this.password = password;
  }

  void addTask(){
    tasks++;
  }

  void deleteTask(){
    tasks--;
  }
}