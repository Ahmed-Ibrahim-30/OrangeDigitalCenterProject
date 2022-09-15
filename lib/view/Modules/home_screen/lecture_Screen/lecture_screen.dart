import 'package:flutter/cupertino.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/view/Modules/base_screen.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';

class LectureScreen extends StatelessWidget {
  const LectureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit myCubit=AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: myText(text: "Lectures",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
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
                condition: myCubit.lectureModel!=null,
                builder: (context)=>ListView.separated(
                    itemBuilder: (context,index)=>myCardTask(
                      subject: myCubit.lectureModel!.data[index].lectureSubject!,
                      form: "Lecture Date",
                      date:myCubit.lectureModel!.data[index].lectureDate!,
                      startTime: myCubit.lectureModel!.data[index].lectureStartTime!,
                      endTime: myCubit.lectureModel!.data[index].lectureEndTime!,
                    ),
                    separatorBuilder: (context,index)=>const SizedBox(height: 10),
                    itemCount: myCubit.lectureModel!.data.length
                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator(),),
              ),
            ),
          );
        }
    );
  }
}
