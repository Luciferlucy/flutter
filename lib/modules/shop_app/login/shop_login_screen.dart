import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_App/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/shared/Network/local/cache_helper.dart';
import 'package:untitled/shared/components/components.dart';

import '../../../shared/components/constants.dart';
import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state){

          if (state is ShopLoginSuccessState){
            dynamic State = state.loginModel.message;
            //dynamic state2 = state.loginModel.status;
            if(state.loginModel.status!){
              print(state.loginModel.data?.token);
              ShowToastt(text: state.loginModel.message!, state: ToastStates.Success);
              CasheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value){
                navigateTo(context, ShopLayout());
                token = state.loginModel.data!.token!;
              });
            }else{
              ShowToastt(text: State, state: ToastStates.Error);
            }
          }
        },
        builder: (context, state){
          ShopLoginCubit shop = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          onSubmit: (context){
                            if(formkey.currentState!.validate()){
                              shop.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffix: shop.suffix,
                          suffixPressed: (){
                            shop.changePasswordVisibility();
                          },
                          isPassword: shop.isPassword,
                          validate: (String value){
                            if(value.isEmpty){
                              return 'password is too short';
                            }},
                          label: 'password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState ,
                          builder: (context) => defaultButton(
                            function: (){
                              if(formkey.currentState!.validate()){
                                shop.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account?',
                            ),
                            defaultTextButton(
                                function:  (){
                                  navigateTo(context, ShopRegisterScreen(),);
                                },
                                text: 'register'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
