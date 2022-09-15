import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/view/Modules/Settings/settings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';
import '../base_screen.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var reasonController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit myCubit=AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: myText(text: "Support",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,color: orangeColor,),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    myTextField(
                      text: 'Name',
                      controller:nameController,
                      textError: 'Name must not be empty',
                      prefixIcon: Icons.person,
                    ),
                    myTextField(
                        text: 'E-Mail',
                        controller:emailController,
                        textError: 'Email must not be empty',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        maxLine: 1,
                        minLine: 1
                    ),
                    myTextField(
                        text: 'Waht\'s making you unhappy?',
                        controller:reasonController,
                        textError: 'reason must not be empty',
                        prefixIcon: Icons.add,
                        maxLine: 7,
                        minLine: 5
                    ),
                    myButton(text: "Submit", function:(){
                      goToAnotherScreen3(context, const BaseScreen());
                    },
                      buttonColor: orangeColor
                    )
                  ],
                ),
              ),
          );
        }
    );
  }


}

