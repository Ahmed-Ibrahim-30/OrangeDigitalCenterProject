import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orangedatacenter/controller/cubit/app_cubit/cubit.dart';
import 'package:orangedatacenter/controller/cubit/app_cubit/states.dart';
import '../../res/constants.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit myCubit=AppCubit.get(context);
          return Scaffold(
            body: SizedBox.expand(
              child: PageView(
                controller: myCubit.pageController!,
                onPageChanged: (index) {
                  myCubit.changeScreen(index);
                },
                children: navBarScreens
              ),
            ),

            bottomNavigationBar:BottomNavyBar(
              backgroundColor: Colors.white,
              showElevation: true,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              itemCornerRadius: 190,
              selectedIndex: myCubit.currentIndex,
              onItemSelected: (index) {
                myCubit.changeScreen(index);
                myCubit.pageController!.jumpToPage(index);
              },
              items: navBarsItems2
            ),
          );
        },
    );
  }
}
