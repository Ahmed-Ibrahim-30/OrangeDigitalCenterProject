import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orangedatacenter/view/Modules/home_screen/events_screen/events_screen.dart';
import 'package:orangedatacenter/view/Modules/home_screen/final_screen/final_screen.dart';
import 'package:orangedatacenter/view/Modules/home_screen/lecture_Screen/lecture_screen.dart';
import 'package:orangedatacenter/view/Modules/home_screen/midterm_screen/midterm_screen.dart';
import 'package:orangedatacenter/view/Modules/home_screen/notes_screen/notes_screen.dart';
import 'package:orangedatacenter/view/Modules/home_screen/section_screen/section_screen.dart';
import 'package:orangedatacenter/controller/cubit/app_cubit/cubit.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget>homeScreenLayout=[
      myCard(icon: 'lecture1.png',text: "Lecture",context: context,anotherScreen: LectureScreen()),
      myCard(icon: 'section1.png',text: "Sections",context: context,anotherScreen: SectionScreen()),
      myCard(icon: 'midterm1.png',text: "Midterms",color: Colors.orange,context: context,anotherScreen: MidtermScreen()),
      myCard(icon: 'exam1.png',text: "Finals",color: Colors.orange,context: context,anotherScreen: FinalScreen()),
      myCard(icon: 'event1.png',text: "Events",color: Colors.orange,context: context,anotherScreen: EventsScreen()),
      myCard(icon: 'notes1.png',text: "Notes",color: Colors.orange,context: context,anotherScreen: NotesScreen()),
    ];

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(AppCubit.get(context).showTabBar){
      AppCubit.get(context).enableTabBar();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:appBarTitle(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children:List.generate(homeScreenLayout.length,
                    (index) => homeScreenLayout.elementAt(index),
            ),
          ),
        ),
      ),
    );
  }



}
