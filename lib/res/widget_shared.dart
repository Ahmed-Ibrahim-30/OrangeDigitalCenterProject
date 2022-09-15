import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../view/Modules/home_screen/notes_screen/add_note.dart';
import '../../../controller/cubit/app_cubit/cubit.dart';
import 'package:page_transition/page_transition.dart';
import '../controller/cubit/login_register/login_cubit.dart';
import 'constants.dart';

Future<Object?> goToAnotherScreen(context,anotherScreen){
  return Navigator.pushAndRemoveUntil(context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: anotherScreen,
          inheritTheme: true,
          ctx: context),
          (route) => false
  );
}


Future<Object?> goToAnotherScreen2(context,anotherScreen){
  return Navigator.push(context,
    PageTransition(
        type: PageTransitionType.rightToLeft,
        child: anotherScreen,
        inheritTheme: true,
        ctx: context),
  );
}


Future<Object?> goToAnotherScreen3(context,anotherScreen){
  return Navigator.pushReplacement(context,
    PageTransition(
        type: PageTransitionType.rightToLeft,
        child: anotherScreen,
        inheritTheme: true,
        ctx: context),
  );
}



Widget appBarTitle(){
  return  Padding(
    padding: const EdgeInsets.only(top:30,left: 20,right: 20),
    child: Image.asset(setImage(url: 'orange.png')),
  );
}



Widget myText({required String text,
  double fontSize=20,
  Color color=Colors.black,
  FontWeight fontWeight=FontWeight.normal,
}){
  return Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}

Widget myDropDown({
  required List items,
  required String hintText,
  required LoginCubit myCubit,
  required String form,
  String ?value,
}){
  return DropdownButtonHideUnderline(
    child: DropdownButton2(
      isExpanded: true,
      hint: Row(
        children:  [
          const Icon(
            Icons.list,
            size: 16,
            color: Colors.black,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              hintText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      items: items
          .map((item) =>
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ))
          .toList(),
      value: value,
      onChanged: (newValue) {
        if(form=="University"){
          myCubit.changeUniversityValue(newValue);
        }
        else if(form=="Gender"){
          myCubit.changeGenderValue(newValue);
        }
        else if(form=="Grade"){
          myCubit.changeGradeValue(newValue);
        }

      },
      icon: const Icon(
        Icons.arrow_forward_ios_outlined,
      ),
      iconSize: 14,
      iconEnabledColor: Colors.black,
      iconDisabledColor: Colors.grey,
      buttonHeight:60,
      //buttonWidth: 200,
      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
      buttonDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: orangeColor,
          width: 4
        ),
        color: Colors.white,
      ),
      buttonElevation: 9,
      itemHeight: 40,
      itemPadding: const EdgeInsets.only(left: 14, right: 14),
      dropdownPadding: null,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      dropdownElevation: 8,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
    ),
  );
}

Widget myButton({
  required String text,
  required dynamic function,
  bool isBoxShadow=false,
  Color buttonColor=Colors.blue,
  double fontSize=22,
  FontWeight fontWeight=FontWeight.bold,
  Color textColor=Colors.white,
  double borderRadius =10,
  double paddingTop=40,
  double paddingBottom=5,
}){
  return Padding(
    padding: EdgeInsets.only(top: paddingTop,bottom: paddingBottom),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          if(isBoxShadow)BoxShadow(color: orangeColor, spreadRadius: 3),
        ],
      ),
      child: MaterialButton(
        onPressed: function,
        height: 55,
        elevation: 20,
        child: myText(text:text,color: textColor,fontWeight: fontWeight,fontSize: fontSize),
      ),
    ),
  );
}

Widget myTextField({
  required String text,
  required String textError,
  TextInputType keyboardType=TextInputType.text,
  String confirmPassword='',
  required TextEditingController controller,
  bool obscureText=false,
  required IconData prefixIcon,
  LoginCubit ?myCubit,
  Color textColor=Colors.indigo,
  int maxLine=1,
  int minLine=1,
}){
  return  Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      maxLines: maxLine,
      minLines: minLine,
      controller: controller,
      decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        suffixIcon: text.contains('Password')?IconButton(
          icon: Icon(myCubit!.passwordVisibility?Icons.visibility_off:Icons.visibility,color: orangeColor),
          onPressed: (){
            myCubit.changePasswordVisibility();
          },
        ):null,
      ),
      onChanged: (value){
        if(text=='Confirm Password')myCubit!.changeFormDetails();
      },
      validator: (value){
        if(value!=null && value.isEmpty){
          return textError;
        }
        else if(confirmPassword!=value && text=='Confirm Password'){
          return textError;
        }
        else{
          return null;
        }
      },
      obscureText: text.contains('Password')?myCubit!.passwordVisibility:obscureText,
      style: TextStyle(
        color: textColor,
        fontSize: 20
      ),
      keyboardType: keyboardType,
    ),
  );
}

Widget settingsItem({
  required String text,
  required  myFunction,
  bool isDivider=true,

}){
  return InkWell(
    onTap: myFunction,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ListTile(
            title: myText(text: text,color: Colors.black),
            trailing:const Icon(Icons.arrow_forward_ios)
          ),
        ),
        if(isDivider)const Divider(thickness: 2,),
      ],
    )
  );
}



List<BottomNavyBarItem>list=[
  BottomNavyBarItem(
    icon: Icon(Icons.apps),
    title: Text('Home'),
    activeColor: Colors.red,
  ),
  BottomNavyBarItem(
      icon: Icon(Icons.people),
      title: Text('Users'),
      activeColor: Colors.purpleAccent
  ),
  BottomNavyBarItem(
      icon: Icon(Icons.message),
      title: Text('Messages'),
      activeColor: Colors.pink
  ),
];



Widget myCard({
  required String icon,
  required String text,
  Color ?color,
  required BuildContext context,
  required Widget anotherScreen,
}){
  return InkWell(
    onTap: (){
      AppCubit.get(context).disableTabBar();
      goToAnotherScreen2(context, anotherScreen);
    },
    child: Card(
      elevation: 5,
      shadowColor: Colors.grey,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Image.asset(setImage(url: icon),width: 50,color: color,),
            ),
            const SizedBox(height: 5,),
            myText(text: text,fontWeight: FontWeight.bold),
          ],
        ),
      ),
    ),
  );
}



Widget myCardTask({
  required String subject,
  required String form,
  required String date,
  required String startTime,
  required String endTime,
  String duration="2hrs",

}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 13),
    child: Card(
      elevation: 14,
      shadowColor: Colors.grey,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myText(text: subject,fontWeight: FontWeight.bold,color: Colors.black),
                Row(
                  children: [
                    const Icon(Icons.alarm_rounded,color: Colors.black,),
                    myText(text: duration,color: Colors.black,fontWeight: FontWeight.w600),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex:5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myText(text: form,color: Colors.grey,fontSize: 14),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month,),
                            const SizedBox(width: 3,),
                            Expanded(child: myText(text: date,color: Colors.black,fontSize: 14))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 9,),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myText(text: "Start Time",color: Colors.grey,fontSize: 14),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined,color: Colors.green,),
                            const SizedBox(width: 3,),
                            myText(text: startTime,color: Colors.black,fontSize: 15)
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myText(text: "End Time",color: Colors.grey,fontSize: 14),
                        Row(
                          children: [
                            const Icon(Icons.access_time_outlined,color: Colors.red,),
                            const SizedBox(width: 3,),
                            myText(text: endTime,color: Colors.black,fontSize: 15)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget myNote({
  required String title,
  required String description,
  required String date,
  required int id,
  required double width,
  required double height,
  required int index,
  required context,
}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 13),
    child: Card(
      elevation: 14,
      shadowColor: Colors.grey,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myText(text: title,fontWeight: FontWeight.bold,color: Colors.black),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: IconButton(
                          onPressed: (){
                            goToAnotherScreen2(context, AddNote(index:index,title: title,description: description,buttonName: "Update",));
                          },
                          icon: Icon(Icons.edit,color: orangeColor,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: IconButton(
                          onPressed: (){
                            AppCubit.get(context).removeNote(id);
                          },
                          icon: Icon(Icons.delete,color: orangeColor,),
                      ),
                    )
                  ],
                )
              ],
            ),
            myText(text: description,color: Colors.black),
            SizedBox(height: 10,),
            myText(text: date,color: Colors.black),
          ],
        ),
      ),
    ),
  );
}




