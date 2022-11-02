import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/task.dart';
import '../model/user.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  ToDoListState createState() => ToDoListState();
}

List<User> users = <User>[User("Salamatbek", "pass"), User("Dummy", "1234")];
List<Task> tasks = <Task>[Task(users[0] ,"Go to GYM")];

class ToDoListState extends State<ToDoList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();


  void removeTask(int index){
    setState(() {
      Task task = tasks[index];
      tasks.removeAt(index);
      for(User user in users){
        if(user.getName() == task.getUser().getName()){
          user.deleteTask();
          return;
        }
      }
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  void _addTask(Task task){
    setState(() {
      tasks.add(task);
      for(User user in users){
        if(user.getName() == task.getUser().getName()){
          user.addTask();
          return;
        }
      }
    });
  }
  
  void _addUser(User user){
    setState(() {
      for (User u in users){
        if(u.getName() == user.getName()){
          return;
        }
      }
      users.add(user);
    });
  }

  void removeUser(int index){
    setState(() {
      String name = users[index].getName();
      users.removeAt(index);
      List<int> indicesToRemove = [];
      for (int i = 0; i < tasks.length; i++){
        if(tasks[i].getUser().getName() == name){
          indicesToRemove.add(i);
        }
      }
      for (int i = indicesToRemove.length - 1; i >= 0; i--){
        tasks.removeAt(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    users[0].addTask();
    User newUser = User('1', '1');
    Task newTask = Task(newUser, '1');

    List<Widget> pages = [

      // Tasks Page --------------------
      tasks.isNotEmpty ? ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shadowColor: Colors.grey.shade300,
            child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  tasks[index].getDescription(), textAlign: TextAlign.left,
                ),
                subtitle: Text(tasks[index].getUser().getName()),
                trailing: IconButton(
                  icon : const Icon(Icons.delete),
                  onPressed:() => removeTask(index),),
                tileColor: Colors.grey
            ),
          );
        },
      ): const Center(
          child: Text('No tasks')
      ),



      //New Task PAGE --------------------
      Center(
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
          },
          child: FocusTraversalGroup(
            child: Form(
              key: _taskFormKey,
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      validator: (value) {
                        if(value == ''){
                          return 'Enter username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Username:'
                      ),
                      onSaved: (String? value) {
                        newTask.setUser(User(value!, '1234'));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      validator: (value) {
                        if(value == ''){
                          return 'Enter task description';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.description),
                          labelText: 'Task Description:'
                      ),
                      onSaved: (String? value) {
                        newTask.setDescription(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_taskFormKey.currentState!.validate()) {
                          _addTask(newTask);
                          _addUser(newTask.getUser());
                        }
                      },
                      child: const Text('Submit'),
                    )
                ),
              ]),
            ),
          ),
        ),
      ),




      //Authorization PAGE --------------------
      Center(
        child: Shortcuts(
          shortcuts: const <ShortcutActivator, Intent>{
            SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
          },
          child: FocusTraversalGroup(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      validator: (value) {
                        if(value == ''){
                          return 'Enter username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Username:'
                      ),
                      onSaved: (String? value) {
                        newUser.setName(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      validator: (value) {
                        if(value == ''){
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          labelText: 'Password:'
                      ),
                      onSaved: (String? value) {
                        newUser.setPassword(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          _addUser(newUser);
                        }
                      },
                      child: const Text('Submit'),
                    )
                ),
              ]),
            ),
          ),
        ),
      )
    ];

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('ToDoList by Mambetkadyrov Salamatbek'),
            ),
            endDrawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Center(child: Text('Users')),
                  ),
                  users.isNotEmpty ? Container(
                    height: double.maxFinite,
                      child:ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shadowColor: Colors.blue[900],
                              child: ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(
                                users[index].getName(), textAlign: TextAlign.left,
                              ),
                              subtitle: Text(users[index].getPassword()),
                              trailing: IconButton(
                                icon : const Icon(Icons.delete),
                                onPressed:() => removeUser(index),),
                              tileColor: Colors.grey
                            )
                          );
                        },
                    )
                  ): const Center(
                      child: Text('No users')
                  )
                ],
              )
              ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.purple[50],
              items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'New Task',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.purple[400],
              onTap: _onItemTapped,
            ),
            body: pages[_selectedIndex]
        )
    );
  }
}

