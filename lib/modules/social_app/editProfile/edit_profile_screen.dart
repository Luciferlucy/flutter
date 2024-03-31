import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = SocialCubit.get(context).usermodel;
        var profileImage = SocialCubit.get(context).ProfileImage;
        var coverImage = SocialCubit.get(context).CoverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar:
          defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(function: (){
                SocialCubit.get(context).UpdateUserData(name: nameController.text, phone: phoneController.text, bio: bioController.text);
              }, text: 'Update'),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(height: 10,),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft:  Radius.circular(4),
                                    topRight:  Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image:coverImage == null ? NetworkImage(
                                        '${userModel.cover}'
                                    ) : FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon:const CircleAvatar(
                                    radius: 20,
                                    child:  Icon(
                                      Icons.camera_alt ,
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null ? NetworkImage(
                                  '${userModel.image}',
                                ) : FileImage(profileImage) as ImageProvider ,

                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon:const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.camera_alt ,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).ProfileImage != null ||SocialCubit.get(context).CoverImage != null )
                    Row(
                    children: [
                      if(SocialCubit.get(context).ProfileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){
                                    SocialCubit.get(context).uploadPorfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  },
                                  text: 'upload profile'),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(
                                height: 5,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )
                      ),
                      SizedBox(width: 5,),
                      if(SocialCubit.get(context).CoverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){
                                    SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  },
                                  text: 'upload cover'),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(
                                height: 5,
                              ),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )
                      ),

                    ],
                  ),
                  if(SocialCubit.get(context).ProfileImage != null ||SocialCubit.get(context).CoverImage != null )
                    SizedBox(height: 20,),
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
                      prefix:Icons.person,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix:Icons.person,
                  ),
                  const SizedBox(
                    height: 10,
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
                    prefix:Icons.call,
                  ),
                ],
              ),
            ),
          ),
        );
      },


    );
  }
}
