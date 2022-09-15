import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/faq_model.dart';
import '../../../res/constants.dart';
import '../../../res/widget_shared.dart';
import '../../../view/Modules/home_screen/notes_screen/notes_screen.dart';
import '../../../controller/cubit/app_cubit/states.dart';
import '../../../models/section_model.dart';
import '../../../network/dio_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../models/lecture_model.dart';
import '../../../models/exam_model.dart';
import '../../../models/note_module.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitState());
  static AppCubit get(context)=>BlocProvider.of(context);
  bool showTabBar=false;
  Database? database;
  SectionModel ?sectionModel;
  LectureModel ?lectureModel;
  ExamModel ?examModel;
  PageController ?pageController=PageController();
  int currentIndex=0;
  List<NoteModel>allNotes=[];



  var termText='';
  void getTerm(){
    DioHelper.getData(
        url: termsEndPoint,
        token: token
    ).then((value) {
      termText=value.data['data']['Terms'];
      emit(GetTermSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetTermErrorState());
    });
  }

  List<FaqModel>faqModel=[];
  void getFaq(){
    DioHelper.getData(
        url: faqEndPoint,
        token: token
    ).then((value) {
      value.data['data'].forEach((value){
        faqModel.add(FaqModel(question: value['question'], answer:value['answer']));
        emit(GetFaqSuccessState());
      });
    }).catchError((error){
      print(error.toString());
      emit(GetFaqErrorState());
    });
  }

  void addNote(String title,String desc,context,date,id){
    allNotes=[];
    insertToDatabase(NoteModel(id:id,title: title, description: desc,date: date));
    Navigator.pop(context);
    emit(AddNoteState());
  }
  void removeNote(int id){
    allNotes=[];
    deleteFromDatabase(id);
    emit(RemoveNoteState());
  }
  void updateNote(String title,String dec,context,date,id){
    allNotes.clear();
    updateDatabase(title,dec,date, id);
    Navigator.pop(context);
    emit(UpdateNoteState());
  }
  void changeScreen(int index){
    currentIndex=index;
    emit(ChangeScreenState());
  }
  void disableTabBar(){
    showTabBar=true;
    emit(DisableTabBarState());
  }
  void enableTabBar(){
    showTabBar=false;
    emit(EnableTabBarState());
  }
  void getSectionData(){
    DioHelper.getData(
        url: sectionsEndPoint,
      token: token
    ).then((value){
      sectionModel=SectionModel.fromJson(value.data['data']);
      emit(GetSectionSuccessState());
    }).catchError((error){
      emit(GetSectionErrorState());
    });
  }
  void getLectureData(){
    DioHelper.getData(
        url: lecturesEndPoint,
        token: token
    ).then((value){
      lectureModel=LectureModel.fromJson(value.data['data']);
      emit(GetLecturesSuccessState());
    }).catchError((error){
      emit(GetLecturesErrorState());
    });
  }
  void getExamData(){
    DioHelper.getData(
        url: examsEndPoint,
        token: token
    ).then((value){
      examModel=ExamModel.fromJson(value.data['data']);
      emit(GetExamSuccessState());
    }).catchError((error){
      emit(GetExamErrorState());
    });
  }
  void createDatabase(context) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    openDatabase(
        path,
        version: 1,
        onCreate: (Database database, int version) {
          print("Database Created Successfuly");
          database
              .execute("CREATE TABLE tasks "
              '(id INTEGER PRIMARY KEY,title TEXT,description TEXT,date TEXT)')
              .then((value) => print("Table Created successfuly"))
              .catchError((error) {
            print(error);
          });
        }, onOpen: (database) async {
      print("Database Opened Successfuly");
      getDataFromDataBase(database);
    }).then((value) {
      database=value;
      emit(CreateDataBaseState());
    });
  }
  Future<void> insertToDatabase(NoteModel newNote) async {
    return await database!.transaction((txn) async {
      await txn.rawInsert('INSERT INTO tasks (title,description,date) '
          'VALUES("${newNote.title}","${newNote.description}","${newNote.date}")')
          .then((value) {
            print('raw insert success id = ${value}');
          })
          .catchError((error) {
        print("raw insert error $error");
      });
    }).then((value) {
      emit(UpdateDataBaseState());
      getDataFromDataBase(database!);
    });
  }
  void deleteFromDatabase(int id) async {
    print("id = $id");
    await database!
        .rawDelete("DELETE FROM tasks WHERE id='$id'")
        .then((value) {
      print("Deleted success");
      emit(DeleteDataBaseState());
      getDataFromDataBase(database!);
    });
  }
  void updateDatabase(String title,String dec,String date,int id) {
    final data = {
      'title': title,
      'description': dec,
      'date': date,
    };
    database!.update('tasks', data, where: "id = ?", whereArgs: [id]).then((value) {
      getDataFromDataBase(database!);
      emit(UpdateDataBaseState());
    }).catchError((error){
      print("error = $error");
    });

  }
  void getDataFromDataBase(Database database) async {
    database.rawQuery("SELECT * FROM tasks").then((value){
      print("Get data from database = ${value}");
      NoteModel newNote;
      value.forEach((element) {
        newNote=NoteModel(
          id: int.parse(element['id'].toString()),
          title: element['title'].toString(),
          date: element['date'].toString(),
          description: element['description'].toString(),
        );
        allNotes.add(newNote);
      });
      print(allNotes.length);
      emit(GetDataBaseState());
    });
  }


}