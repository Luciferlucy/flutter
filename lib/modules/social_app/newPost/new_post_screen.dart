import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(function: (){
                var now = DateTime.now();
                if(SocialCubit.get(context).PostImage == null){
                  SocialCubit.get(context).CreatePost(dateTime: now.toString(), text: textController.text);
                }else{
                  SocialCubit.get(context).UploadPostImage(dateTime: now.toString(), text: textController.text);

                }
              }, text: 'Post'),
            ],
          ),
          body: Padding(

            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-photo/pink-ice-cream-cone-with-sprinkles-sprinkles-it_777174-40.jpg?size=626&ext=jpg&ga=GA1.1.1130376758.1687173586',
                      ),

                    ),
                    SizedBox(
                      width: 15,),
                    Expanded(
                      child:  Text(
                        'mina',
                        style: TextStyle(
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is on your mind, ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).PostImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).PostImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        SocialCubit.get(context).removePostImage();
                      },
                      icon:const CircleAvatar(
                        radius: 20,
                        child:  Icon(
                          Icons.close ,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      }, child: Row(
                        children: [
                          Icon(
                            Icons.image,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'add photo',
                          ),
                        ],
                      )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Row(
                        children: [
                          Text(
                            '# tags',
                          ),
                        ],
                      )),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
