import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';
import '../../base_screen.dart';
import '../home_screem.dart';

class FinalScreen extends StatelessWidget {
  const FinalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit myCubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: myText(text: "Finals",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConditionalBuilder(
                condition: myCubit.examModel!=null,
                builder: (context)=>ListView.separated(
                    itemBuilder: (context,index)=>myCardTask(
                      subject: myCubit.examModel!.finalExams[index].examSubject!,
                      form: "Exam Date",
                      date:myCubit.examModel!.finalExams[index].examDate!,
                      startTime: myCubit.examModel!.finalExams[index].examStartTime!,
                      endTime: myCubit.examModel!.finalExams[index].examEndTime!,
                    ),
                    separatorBuilder: (context,index)=>const SizedBox(height: 10),
                    itemCount: myCubit.examModel!.finalExams.length
                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator(),),
              ),
            ),
          );
        }
    );
  }
}
