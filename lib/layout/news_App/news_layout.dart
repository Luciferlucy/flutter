import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_App/cubit/cubit.dart';
import 'package:untitled/layout/news_App/cubit/states.dart';
import 'package:untitled/shared/Network/remote/dio_helper.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubic/cubit.dart';

import '../../modules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search,)
                ),
                IconButton(
                    onPressed: (){
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: Icon(
                      Icons.brightness_4_outlined,
                    ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.ChangeBottomNavBar(index);
              },
              items:cubit.bottomItems,
            ),
          );
        },
      );
  }
}
