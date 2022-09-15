import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/view/Modules/home_screen/notes_screen/notes_screen.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';


class AddNote extends StatelessWidget {
  String title='',description='',buttonName;
  String date;
  int index=0;
  AddNote({Key? key,this.title='',this.date='',this.index=0,this.description='',this.buttonName="Add"}) : super(key: key);
  var titleController=TextEditingController();
  var descriptionController=TextEditingController();
  var dateController=TextEditingController();
  bool enter=false;
  @override
  Widget build(BuildContext context) {
    if(!enter){
      if(date==''){
        dateController.text="${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      }
      else{
        dateController.text=date;
      }
      titleController.text=title;
      descriptionController.text=description;
      enter=true;
    }

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit myCubit=AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: myText(text: "Add Notes",color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),
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
                        text: 'Title',
                        controller:titleController,
                        textError: 'Title must not be empty',
                        prefixIcon: Icons.add,
                    ),
                    myTextField(
                        text: 'Date',
                        controller:dateController,
                        textError: 'Date must not be empty',
                        prefixIcon: Icons.add,
                        keyboardType: TextInputType.number,
                        maxLine: 1,
                        minLine: 1
                    ),
                    myTextField(
                      text: 'Description',
                      controller:descriptionController,
                      textError: 'Description must not be empty',
                      prefixIcon: Icons.add,
                      maxLine: 7,
                      minLine: 5
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 90),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: orangeColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                          onPressed: (){
                            if(buttonName=="Add") {
                              myCubit.addNote(titleController.text,descriptionController.text,context,dateController.text,index);
                            } else{
                              myCubit.updateNote(titleController.text,descriptionController.text,context,dateController.text,myCubit.allNotes[index].id);
                            }
                          },
                          child: myText(text:buttonName,color: Colors.white,fontWeight:FontWeight.bold,
                              fontSize: 17),
                        )
                      ),
                    ),
                  ],
                ),
              )
          );
        }
    );
  }
}
