import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../res/constants.dart';
import '../../../../res/widget_shared.dart';
import '../../../../controller/cubit/app_cubit/cubit.dart';
import '../../../../controller/cubit/app_cubit/states.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class PatternScreen extends StatelessWidget {
  const PatternScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: myText(text: "Our Patterns",
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: orangeColor,),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.40,
                  decoration:  BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors:[Colors.grey,Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),

                  ),
                  child: appBarTitle(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myText(text: 'ODC',color: Colors.white,fontSize: 23),
                ),
              ],
            ),
          )
      ),
    );;
  }
}
