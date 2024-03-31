import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/modules/web_view/web_view_screen.dart';
import 'package:untitled/shared/cubic/cubit.dart';

import '../../layout/shop_App/cubit/cubit.dart';
import '../styles/colors.dart';

Widget  defaultButton ({
  double width =double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius =0,
  required VoidCallback function,
  required String text,
}) => Container(
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style:TextStyle(
        color: Colors.white,
      ) ,
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius,),
    color: background,
  ),
);

Widget defaultTextButton({
  required dynamic function,
  required String text,
}) =>TextButton(onPressed: function,
  child: Text(text.toUpperCase()),
);
Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  dynamic onSubmit,
  dynamic onchange,
  required dynamic validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  dynamic suffixPressed,
  dynamic onTap,
  bool isclickable = true,
}) => TextFormField(
  controller: controller,
  style: TextStyle(
    fontSize: 40,
  ),
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onchange,
  validator: validate,
  onTap:onTap ,
  enabled: isclickable,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),
);
Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40,
  
          child: Text(
  
            '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 10,
  
        ),
  
        Expanded(
  
          child: Column(
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            mainAxisSize: MainAxisSize.min,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontWeight: FontWeight.bold,
  
                  fontSize: 16,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(
  
          width: 10,
  
        ),
  
        IconButton(
  
            onPressed: (){
  
              AppCubit.get(context).updateData(status: 'done', id:model['id'],);
  
            },
  
            icon: Icon(
  
              Icons.check_box,
  
              color: Colors.green,
  
            )),
  
        IconButton(
  
            onPressed: (){},
  
            icon: Icon(
  
              Icons.archive,
  
              color: Colors.grey,
  
            )),
  
      ],
  
    ),
  
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id:model['id'],);
  },
);
Widget taskbuilder({
  required List<Map> tasks
}) => ConditionalBuilder(
  condition: tasks.length > 0 ,
  builder: (context)=>ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
        ),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
      ),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
        ),
        Text(
            'No tasks yet please add some tasks'
        ),
      ],
    ),
  ),
);
Widget mydividor() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article , context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10),
  
            image:DecorationImage(
  
              image: NetworkImage('${article['urlTbImage']}'),
  
              fit: BoxFit.cover,
  
            ) ,
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Container(
  
          height: 120,
  
          child: Column(
  
            mainAxisAlignment: MainAxisAlignment.start,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Expanded(
  
                child: Text(
  
                  '${article['title']}',
  
                  style: Theme.of(context).textTheme.bodyText1,
  
                  maxLines: 3,
  
                  overflow: TextOverflow.ellipsis,
  
                ),
  
                
  
              ),
  
              Text(
  
                '${article['publishedAt']}',
  
              ),
  
            ],
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);
Widget articleBuilder(list, context,{isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0 ,
  builder: (context)=> ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(context, index) =>buildArticleItem(list[index] , context),
    separatorBuilder: (context, index) => mydividor(),
    itemCount: 10,
  ),
  fallback: (context)=>isSearch ? Container() :Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
builder: (context) => widget,
),
);
void ShowToastt({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates {Success , Error , Warning}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}
PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios,
    ),
  ),
  title: Text(
      '$title',
  ),
  titleSpacing: 5,
  actions:actions,
);
Widget buildListProducts(model,context,{bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5,),
                child: const Text(
                  'Discount',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 14,
                    height: 1.3
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopCubit.get(context).ChangeFavorites(model.id!);
                    },
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites![model.id]! ? defaultColor : Colors.grey ,
                      child: const Icon(
                        Icons.favorite_border_outlined,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);