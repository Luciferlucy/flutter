import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/shared/components/components.dart';

import '../chat_details/chat_details_screen.dart';
class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index) => mydividor(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildChatItem(SocialUserModel model,context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),

          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.2,
            ),
          ),
        ],
      ),
    ),
  );
}
