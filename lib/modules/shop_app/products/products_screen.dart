import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_App/cubit/states.dart';
import 'package:untitled/models/shop_app/categories_model.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../../layout/shop_App/cubit/cubit.dart';

class ProdcutsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if(state is ShopSuccessChangeFavoritesState){
            if(!state.model.status!){
              ShowToastt(text: state.model.message!, state: ToastStates.Error,);
            }
          }
        },
        builder: (context,state){
          var shopcubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: shopcubit.homeModel != null && shopcubit.categoriesModel  != null,
              builder: (context) => productsBuilder(shopcubit.homeModel,shopcubit.categoriesModel,context),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
          );
        },
    );
  }
  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model?.data?.banners.map((e) => Image(image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) => buildCategory(categoriesModel.data!.data[index]),
                  separatorBuilder:(context,index) => SizedBox(
                    width: 10,
                  ) ,
                  itemCount: categoriesModel!.data!.data.length,
                ),
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount:2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1/1.58,
            children: List.generate(model!.data!.products.length,
                  (index) => buildGridProduct(model.data?.products[index],context),),
          ),
        ),
      ],
    ),
  );
  Widget buildCategory(DataModel? model) => Container(
    height: 100,
    width: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model!.image!),
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.6),
          width: double.infinity,

          child: Text(
            model.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  Widget buildGridProduct(ProductsModel? model , context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model!.image!),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount != 0)
              Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5,),
              child: Text(
                'Discount',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0)
                    Text(
                    '${model.old_price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.3,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).ChangeFavorites(model.id!);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites![model.id]! ? defaultColor : Colors.grey ,
                      child: Icon(
                          Icons.favorite_border_outlined,
                          size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
