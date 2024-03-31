import 'dart:math';

import 'package:flutter/material.dart';

import '../bmi_result/BMI_result.dart';

class BMIcalc extends StatefulWidget {
  @override
  State<BMIcalc> createState() => _BMIcalcState();
}

class _BMIcalcState extends State<BMIcalc> {
  bool isMale = true;
  double height =120;
  int weight = 40;
  int age = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI calculator',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: AssetImage('images/Male_symbol_-_black.png'),
                                  height: 90,
                                  width: 90,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'MALE',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10,),
                            color: isMale ? Colors.blue : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('images/579658-200.png'),
                                height: 90,
                                width: 90,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'FEMALE',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10,),
                            color: ! isMale ? Colors.blue : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10,),
                  color: Colors.grey,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     'HEIGHT',
                     style: TextStyle(
                       fontSize: 25,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         '${height.round()}',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 40,
                         ),
                       ),
                       SizedBox(
                         width: 5,
                       ),
                       Text(
                         'CM',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 20,
                         ),
                       ),

                     ],
                   ),
                   Slider(
                       value: height,
                       max: 220,
                       min: 80,
                       onChanged: (value){
                         setState(() {
                           height = value;
                         });
                         print(value);
                       },
                   ),
                 ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10,),
                        color: Colors.grey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$weight',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    weight --;
                                  });
                                },
                                heroTag: 'we--',
                                mini: true,
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    weight ++;
                                  });
                                },
                                heroTag: 'we++',
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10,),
                        color: Colors.grey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$age',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    age --;
                                  });
                                },
                                heroTag: 'age--',
                                mini: true,
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    age ++;
                                  });
                                },
                                mini: true,
                                heroTag: 'age++',
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(
              onPressed:(){
                double result = weight / pow(height/100 , 2);
                print(result.round());
                Navigator.push(context , MaterialPageRoute(
                  builder: (context) => BMI_result(
                    age: age,
                    isMale: isMale,
                    result: result.round(),
                  ),
                ),
                );
              },
              child: Text(
                'calculate',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
