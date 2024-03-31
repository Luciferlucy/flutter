
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_App/cubit/states.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/settings/setting_screen.dart';
import '../../../modules/news_app/sports/sport_screen.dart';
import '../../../shared/Network/remote/dio_helper.dart';
import '../../../shared/cubic/states.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(): super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label:'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label:'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label:'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label:'Settings',
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportScreen(),
    settingScreen(),
  ];
  void ChangeBottomNavBar(int index){
    currentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsbottomNavState());
  }
  List<dynamic> business = [];
  void getBusiness(){
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey':'65f7556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      // print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports(){
    if(sports.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey':'65f7556ec76449fa7dc7c0069f040ca',
          }).then((value) {
        // print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewGetSportsErrorState(error.toString()));
      });
    }else {
      emit(NewGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];
  void getScience(){
    if(science.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apikey':'65f7556ec76449fa7dc7c0069f040ca',
          }).then((value) {
        // print(value.data.toString());
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewGetScienceErrorState(error.toString()));
      });
    }else {
      emit(NewGetScienceSuccessState());
    }

  }

  List<dynamic> search = [];
  void getSearch(String value){
    search =[];
    emit(NewsSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apikey':'65f7556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      // print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewGetSearchErrorState(error.toString()));
    });

  }

}