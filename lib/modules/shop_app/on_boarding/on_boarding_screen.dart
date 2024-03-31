import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shared/Network/local/cache_helper.dart';
import 'package:untitled/shared/components/components.dart';

import '../../../models/user/user._model.dart';
import '../../../shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}
class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var BoardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      body: 'On Board 1 body ',
      title: 'On Board 1 Title  ',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      body: 'On Board 2 body ',
      title: 'On Board 2 Title  ',
    ),
    BoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      body: 'On Board 3 body ',
      title: 'On Board 3 Title  ',
    ),
  ];

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    void submit(){
      CasheHelper.saveData(key: 'onBoarding', value: true,).then((value){
        if(value!){
          navigateTo(context, ShopLoginScreen(),);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'SKIP'
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: BoardController,
                onPageChanged: (int index) {
                  setState(() {
                    if (index == boarding.length - 1) {
                      islast = true;
                      print('last');
                    }else{
                      print('not last');
                      islast = false;
                    };
                  });

                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: BoardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 10,
                    dotWidth: 5,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      BoardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}
