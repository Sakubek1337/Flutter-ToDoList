import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(MyApp());

List<String> tasks = <String>['EASY PEASY', "&divider&", 'Clean a room'];

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      tasksPage(),
      newTaskPage(),
      loginPage(_formKey)
    ];

    return DefaultTabController(
        length: 3,
        child: Scaffold(
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

Widget tasksPage(){
  return tasks.isNotEmpty ? ListView.builder(
    padding: const EdgeInsets.all(8),
    itemCount: tasks.length,
    itemBuilder: (BuildContext context, int index) {
      if(index.isOdd){
        return Divider();
      }
      return ListTile(
        title: Center(
            child: Text(tasks[index])
        ),
        tileColor: Colors.grey,
        hoverColor: Colors.black,
        textColor: Colors.grey[900],
      );
    },
  ) : const Center(
      child: Text('No tasks')
  );
}

Widget newTaskPage(){
  return const Center(
    child: Text("flkfjlk")
  );
}

void addTask(String task){

}