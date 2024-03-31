
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/modules/Archived_tasks/Archived_tasks.dart';
import 'package:untitled/modules/Done_tasks/Done_tasks.dart';
import 'package:untitled/modules/tasks/new_tasks_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:path/path.dart';

import '../shared/components/constants.dart';

class HomeLayout extends StatefulWidget {

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'Tasks',
    'Done',
    'Archived',
  ];
  Database? database;
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timingController = TextEditingController();
  var dateController = TextEditingController();
  List<Map> tasks = [];
  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (context)=> screens[currentIndex],
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown) {
            if (formkey.currentState!.validate()) {
              insertToDatabase(
                title: titleController.text,
                time: timingController.text,
                date: dateController.text,
              ).then((value) {
                GetDataFromDatabase(database).then((value){
                  Navigator.pop(context);
                  setState(() {
                    isBottomSheetShown = false;
                    fabIcon = Icons.edit;
                    tasks = value;
                    print(tasks);
                  });
                });
              });
            }
          } else {
            scaffoldkey.currentState!.showBottomSheet(
                  (context) =>
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'title must not be empty';
                              }
                              return null;
                            },
                            label: 'task title',
                            prefix: Icons.title,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: timingController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()).then((value) {
                                timingController.text =
                                    value!.format(context).toString();
                              });
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'time must not be empty';
                              }
                              return null;
                            },
                            label: 'task time',
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2024-03-05'),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'date must not be empty';
                              }
                              return null;
                            },
                            label: 'task date',
                            prefix: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ),
              elevation: 15,
            ).closed.then((value) {
              isBottomSheetShown = false;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
            label: 'Archived',
          ),
        ],
      ),
    );
  }

  void createDatabase() async {
    String Datapath = await getDatabasesPath();
    String path = join(Datapath, 'todo.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        database.execute(
            'CREATE TABLE "tasks" (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then(
                (value) {
              print('created');
            })
            .catchError((error) {
          print('error${error.toString()}');
        });
      },
      onOpen: (database) {
        print('opened');
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database?.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')
          .then(
              (value) {
            print('$value inserted succesfully');
          })
          .catchError((error) {
        print('Error ${error.toString()}');
      });
      return null!;
    });
  }
  Future<List<Map>> GetDataFromDatabase(database)async {
    return await database.rawQuery('SELECT * FROM tasks');
  }
}