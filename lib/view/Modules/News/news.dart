import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/view/Modules/profile_screen/login_screen.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.06),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: height*0.10,
                  child:  myText(text: "News",color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),
                ),

                Container(
                  width: double.infinity,
                  height: height*0.40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            myText(text: "ODCs",color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: orangeColor
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                                      child: Icon(Icons.share,color: Colors.white,),
                                    ),
                                    Container(
                                      color: Colors.grey,
                                      height: 30.0,
                                      width: 1.0,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                                      child: Icon(Icons.copy_all_rounded,color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: width*0.02),
                              child: myText(text: "Orange",color: orangeColor,fontSize: 27,fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width*0.02),
                              child: myText(text: "Digital",color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),
                            ),
                            myText(text: "Center",color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: myText(text: 'ODC Support All University',color: Colors.white,fontWeight: FontWeight.w600),
                      )

                    ],
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
