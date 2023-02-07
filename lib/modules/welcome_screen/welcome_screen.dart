import 'package:flutter/material.dart';
import 'package:jobs_for_all/modules/login/login_screen.dart';
import 'package:jobs_for_all/shared/components/components.dart';
import 'package:jobs_for_all/shared/style/colors.dart';

import '../signUp/signUp_screen.dart';

class Welcome_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold( 

      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            Image(
              height: 750,
              image: AssetImage(
                'assets/images/img_2.png',
              ),
              fit: BoxFit.fitHeight,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Get started by ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'creating your acount ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50,),
                  InkWell(
                    onTap: (){
                   navigatorTo(context,SignUp());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.blue
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign up',
                                style: TextStyle(
                                   color: defaultcolor,
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                    ),
                  ),
                 SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          'already have an account ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                        SizedBox(width: 10,),
                        TextButton(
                            onPressed: (){
                              navigateAndFinish(context, Login());
                            },
                            child:Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ) ,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),

            ),

          ],
        ),
      ),

    );
  }
}
