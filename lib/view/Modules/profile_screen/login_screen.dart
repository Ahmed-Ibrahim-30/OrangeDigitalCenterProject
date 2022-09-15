import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_screen.dart';
import '../../../controller/cubit/login_register/login_cubit.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';
import '../../../controller/cubit/login_register/login_states.dart';
import '../base_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if(state is LoginSuccessState){
          Fluttertoast.showToast(
              msg: 'Login Successfully',
              fontSize: 16,
              timeInSecForIosWeb: 1,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
          goToAnotherScreen3(context, const BaseScreen());
        }
        else if(state is LoginErrorState){
          Fluttertoast.showToast(
              msg: 'Login Failed',
              fontSize: 16,
              timeInSecForIosWeb: 1,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
        }
      },
      builder: (context,state){
        LoginCubit  myCubit=LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: appBarTitle(),
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height*0.09),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Login',
                            style:GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 17,),
                          myTextField(
                              text: 'E-Mail',
                              controller:emailController,
                              textError: 'Email must not be empty',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email
                          ),
                          myTextField(
                              text: 'Password',
                              controller:passwordController,
                              textError: 'Password must not be empty',
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: Icons.key,
                              obscureText: true,
                              myCubit:myCubit
                          ),
                          InkWell(
                            onTap: (){},//TODO forget password
                            child: const Text(
                                'ForgotPassword?',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange,
                                fontSize: 16
                              ),
                            ),
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context)=>Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: myButton(
                                text: 'Login',
                                buttonColor: orangeColor,
                                paddingTop: height*0.05,
                                paddingBottom: height*0.004,
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    myCubit.login(email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                            ),
                            fallback: (context)=>const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Center(child: CircularProgressIndicator(),),
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
                            text: 'Sign Up',
                            isBoxShadow: true,
                            buttonColor: Colors.white,
                            textColor: orangeColor,
                            fontWeight: FontWeight.bold,
                            paddingTop: height*0.03,
                            function: (){
                              goToAnotherScreen2(context,RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    )
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
