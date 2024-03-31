import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_App/cubit/cubit.dart';
import 'package:untitled/layout/shop_App/cubit/states.dart';
import 'package:untitled/models/shop_app/categories_model.dart';
import 'package:untitled/shared/components/components.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder: (context,state){
        var shopcubit = ShopCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index)=> buildCatItem(shopcubit.categoriesModel?.data?.data[index]) ,
          separatorBuilder: (context,index) => mydividor(),
          itemCount: shopcubit.categoriesModel!.data!.data.length,
        );
      },
    ) ;
  }
  Widget buildCatItem(DataModel? model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model!.image!),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          model.name!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
