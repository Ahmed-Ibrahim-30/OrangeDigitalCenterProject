import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/res/icon_broken.dart';
import 'package:orangedatacenter/res/widget_shared.dart';
import 'package:orangedatacenter/view/Modules/base_screen.dart';
import 'package:orangedatacenter/view/Modules/home_screen/home_screem.dart';
import 'package:orangedatacenter/controller/cubit/app_cubit/cubit.dart';
import 'package:orangedatacenter/controller/cubit/app_cubit/states.dart';
import '../../../../res/constants.dart';

class SectionScreen extends StatelessWidget {
  const SectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit myCubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: myText(text: "Sections",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
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
              condition: myCubit.sectionModel!=null,
              builder: (context)=>ListView.separated(
                  itemBuilder: (context,index)=>myCardTask(
                      subject: myCubit.sectionModel!.data[index].sectionSubject!,
                      form: "Section Day",
                      date:myCubit.sectionModel!.data[index].sectionDate!,
                      startTime: myCubit.sectionModel!.data[index].sectionStartTime!,
                      endTime: myCubit.sectionModel!.data[index].sectionEndTime!,
                  ),
                  separatorBuilder: (context,index)=>SizedBox(height: 10),
                  itemCount: myCubit.sectionModel!.data.length
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator(),),
            ),
          ),
        );
      }
    );
  }
}
