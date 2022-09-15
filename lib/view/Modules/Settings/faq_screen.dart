import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:orangedatacenter/controller/cubit/login_register/login_cubit.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../view/Modules/home_screen/notes_screen/add_note.dart';
import '../../../controller/cubit/app_cubit/cubit.dart';
import 'package:page_transition/page_transition.dart';



class FaqScreen extends StatelessWidget {
  String ?value;
   FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit myCubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: myText(text: "Faq",
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: orangeColor,),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.only(top: height*0.01,left: width*0.02,right: width*0.02),
              child: SizedBox(
                width: double.infinity,
                child:  ListView.separated(
                    itemBuilder: (context,index){
                      List myList=[myCubit.faqModel[index]];
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ExpansionTile(
                          expandedCrossAxisAlignment: CrossAxisAlignment.center,
                          expandedAlignment: Alignment.center,
                          collapsedIconColor: Colors.black,
                          iconColor: Colors.black,
                          title: Container(
                            decoration: BoxDecoration(
                              color: orangeColor,
                              boxShadow: const [
                                BoxShadow(color: Colors.white),
                              ]
                            ),
                            child: Html(
                              data: myCubit.faqModel[index].question!,
                              style: {
                                "#": Style(
                                  color: Colors.white,
                                  maxLines: 10,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              },
                            ),
                          ),
                          children:[
                            Container(
                              //width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Html(
                                data: myCubit.faqModel[index].answer!,
                                style: {
                                  "#": Style(
                                    color: Colors.black,
                                    textAlign: TextAlign.center,
                                    maxLines: 10,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context,index)=>SizedBox(height: MediaQuery.of(context).size.height*0.0,),
                    itemCount: myCubit.faqModel.length
                )
              ),
            ),
          );



        },
    );
  }
}


