import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/Network/local/cache_helper.dart';
import 'package:untitled/shared/cubic/states.dart';

import '../../modules/Archived_tasks/Archived_tasks.dart';
import '../../modules/Done_tasks/Done_tasks.dart';
import '../../modules/tasks/new_tasks_screen.dart';
import '../Network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit(): super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> tasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];
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
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeIndex(int index){
    currentIndex = index;
    emit(AppChangeBottomNavState());
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
        GetDataFromDatabase(database);
        print('opened');

      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }


  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
            print('$value inserted succesfully');
            emit(AppInsertDatabase());
            GetDataFromDatabase(database);
          }).catchError((error) {
        print('Error ${error.toString()}');
      });
      return null!;
    });
  }
  void GetDataFromDatabase(database){
    tasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value){
      value.forEach((element) {
        if(element['status'] == 'new')
          tasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else archivedtasks.add(element);
      });
      emit(AppGetDatabase());
  });
        }

  void updateData({
    required String status,
    required int id,
}) async {
    database?.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', '$id']
    ).then((value){
      GetDataFromDatabase(database);
      emit(AppUpdateDatabase());
    });
  }
  void deleteData({
    required int id,
  }) async {
    database!.rawDelete(
        'DELETE FROM Tasks WHERE id=? ',
        ['$id']
    ).then((value){
      GetDataFromDatabase(database);
      emit(AppUpdateDatabase());
    });
  }
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }){
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }
    else{
      isDark = !isDark;
      CasheHelper.Putboolean(key: 'isDark', value: isDark).then((value){
        emit(AppChangeModeState());
      });
    }
  }
}