import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';
import 'package:untitled/shared/Network/remote/dio_helper.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/Network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit(): super (ShopRegisterIntialState());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}