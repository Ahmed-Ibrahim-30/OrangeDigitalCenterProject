import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../base_screen.dart';
import 'login_screen.dart';
import '../../../controller/cubit/login_register/login_cubit.dart';
import '../../../controller/cubit/login_register/login_states.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';


class RegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var fullNameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    LoginCubit  myCubit=LoginCubit.get(context);
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if(state is RegisterSuccessState){
          Fluttertoast.showToast(
            msg: 'Register Successfully',
            fontSize: 16,
            timeInSecForIosWeb: 1,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green,
            textColor: Colors.white
          );
          goToAnotherScreen3(context, const BaseScreen());
        }
        else if(state is RegisterErrorState){
          Fluttertoast.showToast(
              msg: "Registered Error",
              fontSize: 16,
              timeInSecForIosWeb: 1,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: appBarTitle(),
          ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width*0.06,vertical: height/20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style:GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 17,),
                        myTextField(
                            text: 'Name',
                            textError: 'Your Name must not be empty',
                            controller: fullNameController,
                            prefixIcon: Icons.person
                        ),
                        myTextField(
                            text: 'E-Mail',
                            textError: 'Email must not be empty',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            prefixIcon: Icons.email
                        ),
                        myTextField(
                            text: 'Password',
                            textError: 'Password must not be empty',
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            prefixIcon: Icons.key,
                            obscureText: true,
                            myCubit: myCubit
                        ),
                        myTextField(
                            text: 'Password',
                            textError: 'Those passwords didn’t match. Try again.',
                            keyboardType: TextInputType.visiblePassword,
                            controller: confirmPasswordController,
                            confirmPassword: passwordController.text,
                            prefixIcon: Icons.key,
                            obscureText: true,
                            myCubit: myCubit
                        ),
                        myTextField(
                            text: 'Phone Number',
                            textError: 'Phone must not be empty',
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            prefixIcon: Icons.phone_android
                        ),
                        const SizedBox(height: 17,),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Gender',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 140,
                                    child: myDropDown(items: myCubit.gender, hintText: " ",myCubit: myCubit,form: "Gender",value: myCubit.genderValue),
                                  ),
                                ],
                              ),
                               const SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Garde',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 140,
                                    child: myDropDown(items: myCubit.grade, hintText: " ",form: "Grade",myCubit: myCubit,value: myCubit.gradeValue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height*0.02),
                          child: SizedBox(
                            width: double.infinity,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('University',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    //width: 390,
                                    child: myDropDown(items: myCubit.university, hintText: "Select Your University",value: myCubit.universityValue,myCubit: myCubit,form:"University")
                                ),
                              ],
                            ),

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: height*0.02),
                          child: ConditionalBuilder(
                            condition: state is !RegisterLoadingState,
                            builder: (context)=>myButton(text: 'Sign Up',
                                function: ()
                                {
                                  if(formKey.currentState!.validate()){
                                    myCubit.register(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: fullNameController.text,
                                        phoneNumber: phoneController.text,
                                        gender: myCubit.genderValue!,
                                        universityId: myCubit.university.indexOf(myCubit.universityValue!),
                                        gradeId: myCubit.grade.indexOf(myCubit.gradeValue!)
                                    );
                                  }
                                },
                                buttonColor: orangeColor
                            ),
                            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                          ),
                        ),
                        Row(
                          children: const [
                           Expanded(child: Divider(thickness: 1,color: Colors.grey,)),
                            Padding(
                              padding: EdgeInsets.only(left: 7,right: 7),
                              child: Text("OR",style: TextStyle(fontSize: 25),),
                            ),
                            Expanded(child: Divider(thickness: 1,color: Colors.grey,)),
                          ],
                        ),
                        myButton(
                          text: 'Login',
                          isBoxShadow: true,
                          buttonColor: Colors.white,
                          textColor: orangeColor,
                          fontWeight: FontWeight.bold,
                          paddingTop: height*0.02,
                          function: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        },
    );
  }
}
