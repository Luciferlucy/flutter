import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/register/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';

import '../../../layout/shop_App/shop_layout.dart';
import '../../../shared/Network/local/cache_helper.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ShopRegisterCubit shop = ShopRegisterCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child:BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context,state){
          if (state is ShopRegisterSuccessState){
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
        builder: (context,state){
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your name';
                              }
                            },
                            label: 'User name',
                            prefix: Icons.person
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
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please enter your phone';
                              }
                            },
                            label: 'Phone number',
                            prefix: Icons.phone
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState ,
                          builder: (context) => defaultButton(
                            function: (){
                              if(formkey.currentState!.validate()){
                                shop.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
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
