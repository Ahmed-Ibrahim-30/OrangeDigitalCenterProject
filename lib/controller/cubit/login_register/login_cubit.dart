import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../res/SharedPreference.dart';
import '../../../res/widget_shared.dart';
import '../../../view/Modules/profile_screen/login_screen.dart';
import '../../../models/user_model.dart';
import '../../../network/dio_helper.dart';
import '../../../res/constants.dart';
import '../app_cubit/cubit.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() :super(LoginInitState());
  static LoginCubit get (context)=>BlocProvider.of(context);
  IconData passwordIcon=Icons.visibility_off;
  bool passwordVisibility=true;
  UserData ?userData;
  var gender = [
    'Male',
    'Female',
  ];

  var university = [];
  
  void getUniversityName(){
    DioHelper.getData(url: universityEndPoint,token: token).then((value) {
      value.data['data'].forEach((value){
        university.add(value['name']);
      });
      emit(GetUniversityNameState());
    }).catchError((error){
      print(error.toString());
    });
  }
  void getGradeName(){
    DioHelper.getData(url: gradeEndPoint,token: token).then((value) {
      value.data['data'].forEach((value){
        grade.add(value['grade']);
      });
      emit(GetUniversityNameState());
    }).catchError((error){
      print(error.toString());
    });
  }

  var grade=[];

  String ?genderValue;
  String ?universityValue;
  String ?gradeValue;


  void changeFormDetails(){
    emit(ChangeFormState());
  }
  void changePasswordVisibility(){
    passwordVisibility=!passwordVisibility;
    emit(ChangePasswordVisibilityState());
  }

  void changeGenderValue(value){
    genderValue=value;
    emit(ChangeGenderValueState());
  }

  void changeGradeValue(value){
    gradeValue=value;
    emit(ChangeGradeValueState());
  }

  void changeUniversityValue(value){
    universityValue=value;
    emit(ChangeUniversityValueState());
  }

  void login({
  required String email,
  required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: loginEndPoint,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      token=value.data['data']['accessToken'];
      SharedCache.saveData(key: 'token', value: token);
      emit(LoginSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
}

void register({
  required String email,
  required String password,
  required String name,
  required String phoneNumber,
  required String gender,
  required int universityId,
  required int gradeId,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: registerEndPoint,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phoneNumber':phoneNumber,
          'gender':gender=="Male"?'m':"f",
          'universityId':universityId,
          'gradeId':gradeId,
        }
    ).then((value) {
      token='785394983475893jhjhhflyr';
      SharedCache.saveData(key: 'token', value: token);
      userData=UserData.fromJson(value.data['data']);
      emit(RegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
}

void logout(BuildContext context){
    UserData.clearCache();
    AppCubit.get(context).pageController=PageController(initialPage: 0);
    AppCubit.get(context).changeScreen(0);
   goToAnotherScreen(context, LoginScreen());
    emit(LogoutSuccessState());
}
}