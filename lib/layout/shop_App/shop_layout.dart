import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_App/cubit/states.dart';
import 'package:untitled/modules/news_app/search/search_screen.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/modules/shop_app/search/search_screen.dart';
import 'package:untitled/shared/components/components.dart';

import '../../shared/Network/local/cache_helper.dart';
import 'cubit/cubit.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){},
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'SALLA',
            ),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchScreenShop());
              }, icon: Icon(Icons.search),),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps,),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite,),
              label: 'favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,),
              label: 'Settings',
            ),

          ],),
        );
      },
    );
  }
}
