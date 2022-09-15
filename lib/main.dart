import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/res/constants.dart';
import 'package:orangedatacenter/view/Modules/Settings/faq_screen.dart';
import 'package:orangedatacenter/view/Modules/Settings/pattern_screen.dart';
import 'res/SharedPreference.dart';
import 'view/Modules/SplachScreen.dart';
import 'controller/cubit/app_cubit/cubit.dart';
import 'controller/cubit/blocObserver.dart';
import 'controller/cubit/login_register/login_cubit.dart';
import 'network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedCache.init();
  await DioHelper.init();
  token=SharedCache.getData(key: 'token')??'';
  BlocOverrides.runZoned(() {runApp(const MyApp());},
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LoginCubit()..getUniversityName()..getGradeName()),
        BlocProvider(create: (context)=>AppCubit()..getSectionData()..getExamData()..getLectureData()..createDatabase(context)..getTerm()..getFaq()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orange Digital Center',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplachScreen(),

      ),
    );
  }
}

