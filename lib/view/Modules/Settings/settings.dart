import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/controller/cubit/login_register/login_cubit.dart';
import 'package:orangedatacenter/controller/cubit/login_register/login_states.dart';
import 'package:orangedatacenter/view/Modules/Settings/faq_screen.dart';
import 'package:orangedatacenter/view/Modules/Settings/pattern_screen.dart';
import 'package:orangedatacenter/view/Modules/Settings/support_screen.dart';
import 'package:orangedatacenter/view/Modules/Settings/terms_screen.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){},
      builder: (context,state){
        LoginCubit myCubit=LoginCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: height*0.10,
                    child:  myText(text: "Settings",color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),
                  ),

                  settingsItem(text: "FAQ",myFunction: (){
                    goToAnotherScreen2(context,  FaqScreen());
                  }),
                  settingsItem(text: "Terms & Conditions",myFunction: (){
                    goToAnotherScreen2(context, const TermScreen());
                  }),
                  settingsItem(text: "Our Partenrs",myFunction: (){
                    goToAnotherScreen2(context, const PatternScreen());
                  }),
                  settingsItem(text: "Support",myFunction: (){
                    goToAnotherScreen2(context, SupportScreen());
                  }),
                  settingsItem(text: "Logout",isDivider: false,myFunction: (){
                    showDialog(context: context, builder: (st){
                      return AlertDialog(
                        title: myText(text: "Logout"),
                        content: myText(text: "Are you sure?"),
                        actions: [
                          Row(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width/4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(color: orangeColor, spreadRadius: 1),
                                      ],
                                    ),
                                    child: MaterialButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: myText(text:'Cancel',color: orangeColor,fontSize: 12),
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: width/4,
                                    decoration: BoxDecoration(
                                      color: orangeColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: MaterialButton(
                                      onPressed: (){
                                        myCubit.logout(context);
                                      },
                                      child: myText(text:'Sure',color: Colors.white, fontSize: 12),
                                    )
                                ),
                              ),

                            ],
                          )
                        ],
                      );
                    });
                    //
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
