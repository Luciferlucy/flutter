import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/search/cubit/cubit.dart';
import 'package:untitled/shared/components/components.dart';

import 'cubit/states.dart';

class SearchScreenShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , state) {},
        builder: (context , state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String  value){
                          if(value.isEmpty){
                            return 'enter text to searh';
                          }
                          return null;
                        },
                      onSubmit: (String text){
                        SearchCubit.get(context).search(text);
                      },
                      label: "Search",
                      prefix: Icons.search,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index)=> buildListProducts(SearchCubit.get(context).model?.data?.data[index],context,isOldPrice: false) ,
                        separatorBuilder: (context,index) => mydividor(),
                        itemCount: SearchCubit.get(context).model!.data!.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
