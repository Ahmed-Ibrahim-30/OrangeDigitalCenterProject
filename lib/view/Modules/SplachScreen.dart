import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/view/Modules/profile_screen/login_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../res/constants.dart';
import '../../res/widget_shared.dart';
import '../../res/SharedPreference.dart';
import 'base_screen.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: width*0.02),
                  child: myText(text: "Orange",color: orangeColor,fontSize: 23,fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width*0.02),
                  child: myText(text: "Digital",color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),
                ),
                myText(text: "Center",color: Colors.black,fontSize: 23,fontWeight: FontWeight.bold),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: LinearPercentIndicator(
                barRadius: const Radius.circular(30),
                width: MediaQuery.of(context).size.width - 40,
                animation: true,
                lineHeight: 7.0,
                animationDuration: 2000,
                percent: 1,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: orangeColor,
                onAnimationEnd: (){
                  if(SharedCache.getData(key: 'token')!=null){
                    goToAnotherScreen(context, const BaseScreen());
                  }
                  else{
                    goToAnotherScreen(context, LoginScreen());
                  }

                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
