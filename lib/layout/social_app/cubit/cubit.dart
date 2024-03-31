import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/likes_model.dart';
import 'package:untitled/models/social_app/message_model.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/chats/chats_screen.dart';
import 'package:untitled/modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled/modules/social_app/newPost/new_post_screen.dart';
import 'package:untitled/modules/social_app/users/users_screen.dart';

import '../../../modules/social_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{
  SocialCubit(): super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? usermodel;
  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        'oTI2JG2LklODcVdHmJ6r9byYJrs1'
    ).get().then((value){
      usermodel = SocialUserModel.fromJson(value.data()!);
      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error.toString()));
    });
  }
  int currentInddex = 0;
  List<Widget> screens =[
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles =[
    'News Feed',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index){
    if (index ==1)
      if(users.length ==0)
        getUsers();
    if(index ==2)
      emit(SocialNewPostState());
    else{
      currentInddex = index;
      emit(SocialChangeBottomNavState());
    }



  }
  File? ProfileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async{
    final pickedFile= await picker.pickImage(
        source: ImageSource.gallery);
    if(pickedFile != null){
      ProfileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? CoverImage;
  Future<void> getCoverImage() async{
    final pickedFile= await picker.pickImage(
        source: ImageSource.gallery);
    if(pickedFile != null){
      CoverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }
  void uploadPorfileImage({required String name,
    required String phone,
    required String bio,}){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(ProfileImage!.path).pathSegments.last}').putFile(ProfileImage!).then((value) {
      value.ref.getDownloadURL().then((value){
        UpdateUserData(name: name, phone: phone, bio: bio,image: value);
       // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error){
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadProfileImageErrorState());
    });
  }
  void uploadCoverImage({required String name,
    required String phone,
    required String bio,}){
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(CoverImage!.path).pathSegments.last}').putFile(CoverImage!).then((value) {
      value.ref.getDownloadURL().then((value){
        UpdateUserData(name: name, phone: phone, bio: bio,cover: value);
        //emit(SocialUploadCoverImageSuccessState());
      }).catchError((error){
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void UpdateUserImages({
//     required String name,
//     required String phone,
//     required String bio,
// }){
//     emit(SocialUserUpdateLoadingState());
//     if(CoverImage != null){
//       uploadCoverImage();
//     }else if (ProfileImage != null){
//       uploadPorfileImage();
//     }
//     else if(CoverImage != null &&ProfileImage != null ){
//
//     }else{
//       UpdateUserData(name: name, phone: phone, bio: bio);
//     }
//
//   }
  void UpdateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
}){
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      uId: usermodel?.uId,
      bio: bio,
      cover: cover??usermodel?.cover,
      image: image??usermodel?.image,
      email: usermodel?.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(usermodel?.uId).update(model.toMap()).then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }
  File? PostImage;
  Future<void> getPostImage() async{
    final pickedFile= await picker.pickImage(
        source: ImageSource.gallery);
    if(pickedFile != null){
      PostImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }
  void removePostImage(){
    PostImage = null;
    emit(SocialRemovePostImageState());
  }
  void UploadPostImage({
    required String dateTime,
    required String text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(PostImage!.path).pathSegments.last}').putFile(PostImage!).then((value) {
      value.ref.getDownloadURL().then((value){
        CreatePost(dateTime: dateTime, text: text,postImage: value);
        //emit(SocialUploadCoverImageSuccessState());
      }).catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
  void CreatePost({
    required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: usermodel?.name,
      uId: usermodel?.uId,
      image: usermodel?.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',

    );
    FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });

  }
  List<PostModel>posts = [];
  List<String>postId = [];
  List<int>likes = [];


  void getPost(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
            .collection('likes').get().then((value) {
              likes.add(value.docs.length);
              postId.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
            }).catchError((error){
              
            });
          });
          emit(SocialGetPostsSuccessState());
    })
        .catchError((error){
          emit(SocialGetPostsErrorState(error.toString()));
    });

  }
  void likePost(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(usermodel?.uId)
        .set({
      'like': true,
      'id':usermodel?.uId,
      'postid':postId
    }).then((value){

      emit(SocialLikePostsSuccessState());
    }).catchError((error){
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }


  List<SocialUserModel>users = [] ;
  void getUsers(){
    if(users.length ==0)
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uId'] !=usermodel?.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error){
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
}){
    MessageModel model = MessageModel(
      text: text,
      senderId: usermodel?.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance.collection('users').doc(usermodel?.uId).
    collection('chats').doc(receiverId).collection('messages').
    add(model.toMap()).then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance.collection('users').doc(receiverId).
    collection('chats').doc(usermodel?.uId).collection('messages').
    add(model.toMap()).then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }
  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots().listen((event) {
          messages =[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }

}