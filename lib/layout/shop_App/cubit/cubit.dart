import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:untitled/layout/shop_App/cubit/states.dart';
import 'package:untitled/models/shop_app/categories_model.dart';
import 'package:untitled/models/shop_app/change_favorites_model.dart';
import 'package:untitled/models/shop_app/favorites_model.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/categories/categories_Screen.dart';
import 'package:untitled/modules/shop_app/favorites/favorits_Screen.dart';
import 'package:untitled/modules/shop_app/products/products_screen.dart';
import 'package:untitled/modules/shop_app/settings/settings_screen.dart';
import 'package:untitled/shared/Network/end_points.dart';
import 'package:untitled/shared/Network/remote/dio_helper.dart';
import 'package:untitled/shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates>
{

  ShopCubit(): super (ShopInitialState());
  static ShopCubit get (context) => BlocProvider.of(context);
  int currentIndex =0;
  List<Widget> bottomScreens =
  [
    ProdcutsScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom (int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int , bool>? favorites = {};
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel?.data?.banners[0].image as String);
      print(homeModel?.status);
      homeModel?.data?.products.forEach((element) {
        favorites?.addAll({
          element.id! : element.in_favorites!,
        });
      });
      print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token:token,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccesCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;
  void ChangeFavorites(int productId){
    favorites?[productId] =  !favorites![productId]!;
    emit(ShopLoadingChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
          'product_id':productId
        },
      token:token,
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if( !changeFavoritesModel!.status!){
        favorites?[productId] =  !favorites![productId]!;
      }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites?[productId] =  !favorites![productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token:token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccesGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? usermodel;
  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token:token,
    ).then((value){
      usermodel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccesUserDataState(usermodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void getUpdateUser({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      url: UPDATE_PROFILE,
      token:token,
    ).then((value){
      usermodel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccesUpdateUserState(usermodel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}