import 'package:flutter/material.dart';

import '../../../shared/components/components.dart';


class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var emailController = TextEditingController();

  var PasswordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'login',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: emailController,
                    label: 'Email',
                    prefix: Icons.email,
                    type: TextInputType.emailAddress,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: PasswordController,
                    label: 'Passowrd',
                    prefix: Icons.lock,
                    suffix: isPassword ? Icons.visibility: Icons.visibility_off,
                    isPassword: isPassword,
                    type: TextInputType.visiblePassword,
                    validate: (value){
                      if(value!.isEmpty){
                        return 'passowrd must not be empty';
                      }
                      return null;
                    },
                    suffixPressed: (){
                      setState(() {
                        isPassword = !isPassword;
                      });
                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                    text: 'login',
                    function: (){
                      if(formkey.currentState!.validate()) {
                        print(emailController.text);
                        print(PasswordController.text);
                      }
                    },
                  ),//defaultButton
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        //overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed:(){},
                            child: Text(
                              'Register Now',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
