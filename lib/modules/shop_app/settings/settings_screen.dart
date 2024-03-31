import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_App/cubit/cubit.dart';
import 'package:untitled/layout/shop_App/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var model = ShopCubit.get(context).usermodel;
        nameController.text= model!.data!.name!;
        emailController.text= model.data!.email!;
        phoneController.text= model.data!.phone!;
        return ConditionalBuilder(
          condition: model != null ,
          builder: (context) =>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    function: (){
                      if(formkey.currentState!.validate())
                        {
                          ShopCubit.get(context).getUpdateUser(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                    },
                    text: 'update',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: (){
                        signout(context);
                      },
                      text: 'Log out',
                  ),

                ],
              ),
            ),
          ) ,
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
