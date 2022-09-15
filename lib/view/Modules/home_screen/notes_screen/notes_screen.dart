import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';
import '../../base_screen.dart';
import '../home_screem.dart';
import 'add_note.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

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
              title: myText(text: "Notes",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,color: orangeColor,),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(setImage(url:'funnel1.png'),color: Colors.orange,height: 30,width: 40,),
                ),
              ],
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                goToAnotherScreen2(context, AddNote());
              },
              elevation: 12,
              backgroundColor: orangeColor,
              child: const Icon(Icons.add,color: Colors.white,),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child:ListView.separated(
                  itemBuilder: (context,index)=>myNote(
                      title: myCubit.allNotes[index].title!,
                      description: myCubit.allNotes[index].description!,
                      date: myCubit.allNotes[index].date!,
                      id: myCubit.allNotes[index].id!,
                      width: width,
                      height: height,
                    index: index,
                    context: context
                  ),
                  separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                  itemCount: myCubit.allNotes.length
              ),
            )
          );
        }
    );
  }
}
