import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/favorites_model.dart';

import '../../../layout/shop_App/cubit/cubit.dart';
import '../../../layout/shop_App/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder: (context,state){
        var shopcubit = ShopCubit.get(context).favoritesModel?.data;
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
            itemBuilder: (context, index)=> buildListProducts(shopcubit.data[index].product,context) ,
            separatorBuilder: (context,index) => mydividor(),
            itemCount: shopcubit!.data.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

}
