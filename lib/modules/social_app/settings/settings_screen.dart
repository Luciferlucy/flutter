import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

import '../editProfile/edit_profile_screen.dart';
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        var userModel = SocialCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${userModel?.cover}'
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          '${userModel?.image}',
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel?.name}',
                style: Theme.of(context).textTheme.bodyLarge,

              ),
              Text(
                '${userModel?.bio}',
                style: Theme.of(context).textTheme.bodySmall,

              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.titleMedium,

                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodySmall,

                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.titleMedium,

                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.bodySmall,

                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.titleMedium,

                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.bodySmall,

                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.titleMedium,

                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context).textTheme.bodySmall,

                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child:OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Add photos',
                        ),
                      ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      Icons.edit,
                      size: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton(onPressed: (){
                    FirebaseMessaging.instance.subscribeToTopic('announcements');
                  }, child:Text(
                    'subscribe',
                  ),),
                  SizedBox(width: 15,),
                  OutlinedButton(onPressed: (){
                    FirebaseMessaging.instance.unsubscribeFromTopic('announcements');

                  }, child:Text(
                    'unsubscribe',
                  ),),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
