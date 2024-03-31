import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/newPost/new_post_screen.dart';
import 'package:untitled/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context , state){
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
             cubit.titles[cubit.currentInddex],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(
                Icons.notifications,
              )),
              IconButton(onPressed: (){}, icon: Icon(
                Icons.search,
              )),
            ],
          ),
          body:cubit.screens[cubit.currentInddex],
          // ConditionalBuilder(
          //   condition: SocialCubit.get(context).model != null,
          //   builder: (context) {
          //     var model = SocialCubit.get(context).model;
          //     return Column(
          //       children: [
          //         if(FirebaseAuth.instance.currentUser!.emailVerified)
          //           Container(
          //             color: Colors.amber.withOpacity(.6),
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 20
          //               ),
          //               child: Row(
          //                 children: [
          //                   Icon(
          //                     Icons.info_outline,
          //                   ),
          //                   SizedBox(
          //                     width: 15,
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       'please verify your email',
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 20,
          //                   ),
          //                   defaultTextButton(
          //                     function: (){
          //                       FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value){
          //                         ShowToastt(text: 'check your mail', state: ToastStates.Success);
          //                       }).catchError((error){});
          //                     },
          //                     text: 'send',
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         cubit.screens[cubit.currentInddex],
          //
          //
          //       ],
          //     );
          //   },
          //   fallback: (context) => Center(child: CircularProgressIndicator()),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentInddex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(
                Icons.home,
              ),label:'Home',),
              BottomNavigationBarItem(icon: Icon(
                Icons.chat,
              ),label:'chat',),
              BottomNavigationBarItem(icon: Icon(
                Icons.upload,
              ),label:'Post',),
              BottomNavigationBarItem(icon: Icon(
                Icons.person,
              ),label:'users',),
              BottomNavigationBarItem(icon: Icon(
                Icons.settings,
              ),label:'settings',),

            ],
            
          ),
        );
      },
    );
  }

}
