import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobs_for_all/models/on_boarding_model.dart';
import 'package:jobs_for_all/modules/login/login_screen.dart';
import 'package:jobs_for_all/modules/welcome_screen/welcome_screen.dart';
import 'package:jobs_for_all/shared/network/cache_helper.dart';
import 'package:jobs_for_all/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';


class On_boarding extends StatelessWidget {

var pageViewController = PageController();

List<BoardingModel> boardinglist = [
  BoardingModel(
    image:'assets/images/img1.png' ,
    body: 'If you are looking for a job ...',

  ),
  BoardingModel(
    image:'assets/images/img2.jpg' ,
    body: 'This app will be helpful for you ,you can search and get a career that is suitable for you..',

  ),
  BoardingModel(
    image:'assets/images/img3.png' ,
    body: 'With best wishes for getting a suitable job ..',
  ),
];
bool isLast=false;

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        TextButton(
            onPressed: (){
              CacheHelper.saveData(key: 'boardingSeen', value: true).then((value) {
                navigateAndFinish(context,Welcome_Screen());
              });
            },
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 18,
              ),
            )
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsetsDirectional.all(20),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller:pageViewController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index){
                return builBoardingItem(boardinglist[index]);
              },
              itemCount: boardinglist.length,
              onPageChanged: (index){
                if(index==boardinglist.length-1)
                  isLast=true;
                else
                  isLast=false;
              },
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              SmoothPageIndicator(
                controller: pageViewController,
                count: boardinglist.length,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultcolor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 10

                ) ,
              ),
              Spacer(),
              FloatingActionButton(

                backgroundColor: defaultcolor,
                onPressed: (){
                  if(isLast) {
                    CacheHelper.saveData(
                        key: 'boardingSeen', value: true).then((value) {
                      navigateAndFinish(context,Welcome_Screen());
                    });
                  }
                  else {
                    pageViewController.nextPage(
                      duration: Duration(
                          milliseconds: 750
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                child: Icon(
                    Icons.arrow_forward_ios_outlined ,

                ),
              ),



            ],
          ),
        ],
      ),

    ),


  );
}
Widget builBoardingItem(BoardingModel model){
  return Padding(
      padding: const EdgeInsetsDirectional.only(
      start:30 ,
      end: 30 ,
  ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            height: 40,
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            model.body,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              height: 1.3
            ),
          ),
        ),

      ],
    ),
  );
}

}

